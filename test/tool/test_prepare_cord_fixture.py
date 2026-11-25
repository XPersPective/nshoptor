import contextlib
import importlib.util
import io
from pathlib import Path
import ssl
import tempfile
import unittest
from unittest.mock import MagicMock, Mock, call, patch
from urllib.error import HTTPError, URLError


SOURCE = Path(__file__).resolve().parents[2] / 'tool/qa/prepare_cord_fixture.py'
SPEC = importlib.util.spec_from_file_location('cord_fixture', SOURCE)
fixture = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(fixture)


def response(data=b'ok', url=fixture.ROWS_URL):
    value = MagicMock()
    value.__enter__.return_value = value
    value.geturl.return_value = url
    value.read.return_value = data
    return value


def http_error(code):
    return HTTPError(fixture.ROWS_URL + '&signature=PRIVATE', code, 'failed', {}, None)


class FixtureFetchTests(unittest.TestCase):
    def fetch(self, outcomes, limit=10):
        opener = Mock()
        opener.open.side_effect = outcomes
        return opener, patch.object(fixture, 'build_opener', return_value=opener)

    def test_transient_http_recovers_without_changing_request(self):
        opener, setup = self.fetch([http_error(503), response()])
        with setup, patch.object(fixture.time, 'sleep') as sleep:
            self.assertEqual(fixture._read_limited(fixture.ROWS_URL, 10), b'ok')
        self.assertEqual(opener.open.call_count, 2)
        self.assertIs(opener.open.call_args_list[0].args[0], opener.open.call_args_list[1].args[0])
        sleep.assert_called_once_with(1)

    def test_transient_exhaustion_is_bounded_and_retains_cause(self):
        for code in (408, 429, 503):
            with self.subTest(code=code):
                opener, setup = self.fetch([http_error(code) for _ in range(3)])
                with setup, patch.object(fixture.time, 'sleep') as sleep:
                    with self.assertRaises(RuntimeError) as caught:
                        fixture._read_limited(fixture.ROWS_URL, 10)
                self.assertEqual(opener.open.call_count, 3)
                self.assertEqual(sleep.call_args_list, [call(1), call(2)])
                self.assertIsInstance(caught.exception.__cause__, HTTPError)
                self.assertNotIn('PRIVATE', str(caught.exception))

    def test_nontransient_http_is_not_retried_or_disclosed(self):
        for code in (401, 403, 404):
            with self.subTest(code=code):
                opener, setup = self.fetch([http_error(code)])
                with setup, patch.object(fixture.time, 'sleep') as sleep:
                    with self.assertRaises(RuntimeError) as caught:
                        fixture._read_limited(fixture.ROWS_URL, 10)
                self.assertEqual(opener.open.call_count, 1)
                sleep.assert_not_called()
                self.assertNotIn('PRIVATE', str(caught.exception))
                self.assertIn(str(code), str(caught.exception))

    def test_timeout_exhaustion_and_connection_recovery(self):
        opener, setup = self.fetch([TimeoutError() for _ in range(3)])
        with setup, patch.object(fixture.time, 'sleep') as sleep:
            with self.assertRaises(RuntimeError) as caught:
                fixture._read_limited(fixture.ROWS_URL, 10)
        self.assertEqual(opener.open.call_count, 3)
        self.assertIsInstance(caught.exception.__cause__, TimeoutError)
        self.assertEqual(sleep.call_args_list, [call(1), call(2)])
        opener, setup = self.fetch([URLError(ConnectionResetError()), response()])
        with setup, patch.object(fixture.time, 'sleep'):
            self.assertEqual(fixture._read_limited(fixture.ROWS_URL, 10), b'ok')

    def test_tls_failure_is_not_retried(self):
        opener, setup = self.fetch([URLError(ssl.SSLCertVerificationError())])
        with setup, patch.object(fixture.time, 'sleep') as sleep:
            with self.assertRaises(RuntimeError):
                fixture._read_limited(fixture.ROWS_URL, 10)
        self.assertEqual(opener.open.call_count, 1)
        sleep.assert_not_called()

    def test_forbidden_initial_or_redirect_url_fails_closed(self):
        with patch.object(fixture, 'build_opener') as opener:
            with self.assertRaises(ValueError):
                fixture._read_limited('https://other.invalid/image', 10)
            opener.assert_not_called()
        opener, setup = self.fetch([response(url='https://other.invalid/image')])
        with setup, patch.object(fixture.time, 'sleep') as sleep:
            with self.assertRaises(ValueError):
                fixture._read_limited(fixture.ROWS_URL, 10)
        self.assertEqual(opener.open.call_count, 1)
        sleep.assert_not_called()

    def test_oversized_response_fails_without_retry(self):
        opener, setup = self.fetch([response(b'1234')])
        with setup, patch.object(fixture.time, 'sleep') as sleep:
            with self.assertRaises(ValueError):
                fixture._read_limited(fixture.ROWS_URL, 3)
        self.assertEqual(opener.open.call_count, 1)
        sleep.assert_not_called()

    def test_image_hash_mismatch_still_blocks_output(self):
        bad_image = b'\xff\xd8\xff' + b'0' * (fixture.IMAGE_LENGTH - 3)
        with tempfile.TemporaryDirectory() as folder:
            args = ['prepare', '--output', str(Path(folder) / 'define.json')]
            with patch('sys.argv', args), patch.object(fixture, '_read_limited', side_effect=[b'row', bad_image]), \
                 patch.object(fixture, '_row_from_response', return_value=({'src': fixture.ROWS_URL}, {})), \
                 patch.object(fixture, '_write_define_file') as write, contextlib.redirect_stderr(io.StringIO()):
                self.assertEqual(fixture.main(), 1)
                write.assert_not_called()


if __name__ == '__main__':
    unittest.main()
