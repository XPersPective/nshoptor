import unittest

from tool.store.apk_signer import certificate_digest


_DIGEST = "0123456789abcdef" * 4
_OTHER_DIGEST = "fedcba9876543210" * 4


class CertificateDigestTests(unittest.TestCase):
    def test_legacy_numbered_signer(self):
        self.assertEqual(
            certificate_digest(f"Signer #1 certificate SHA-256 digest: {_DIGEST}"),
            _DIGEST,
        )

    def test_colon_separated_digest_is_normalized(self):
        colon_digest = ":".join(_DIGEST[i : i + 2] for i in range(0, 64, 2)).upper()
        self.assertEqual(
            certificate_digest(
                f"Signer #1 certificate SHA-256 digest: {colon_digest}"
            ),
            _DIGEST,
        )

    def test_allowlisted_scheme_specific_signers(self):
        for label in (
            "V1 Signer: certificate SHA-256 digest:",
            "V2 Signer: certificate SHA-256 digest:",
            "V3 Signer: certificate SHA-256 digest:",
            "V3.0 Signer: certificate SHA-256 digest:",
            "V3.1 Signer: certificate SHA-256 digest:",
            "V3.2 Signer: certificate SHA-256 digest:",
            "V4 Signer: certificate SHA-256 digest:",
        ):
            with self.subTest(label=label):
                self.assertEqual(certificate_digest(f"{label} {_DIGEST}"), _DIGEST)

    def test_allowlisted_sdk_range_signer_forms(self):
        self.assertEqual(
            certificate_digest(
                "Signer (minSdkVersion=33, maxSdkVersion=2147483647) "
                f"certificate SHA-256 digest: {_DIGEST}"
            ),
            _DIGEST,
        )
        self.assertEqual(
            certificate_digest(
                "V3.1 Signer: (minSdkVersion=33, maxSdkVersion=2147483647) "
                f"certificate SHA-256 digest: {_DIGEST}"
            ),
            _DIGEST,
        )

    def test_repeated_same_digest_across_schemes_is_one_identity(self):
        output = "\n".join(
            (
                f"Signer #1 certificate SHA-256 digest: {_DIGEST}",
                f"V3.0 Signer: certificate SHA-256 digest: {_DIGEST.upper()}",
                "V3.1 Signer: (minSdkVersion=33, maxSdkVersion=2147483647) "
                f"certificate SHA-256 digest: {_DIGEST}",
            )
        )
        self.assertEqual(certificate_digest(output), _DIGEST)

    def test_conflicting_signer_certificates_fail_closed(self):
        with self.assertRaisesRegex(ValueError, "conflict"):
            certificate_digest(
                f"Signer #1 certificate SHA-256 digest: {_DIGEST}\n"
                f"Signer #2 certificate SHA-256 digest: {_OTHER_DIGEST}"
            )

    def test_public_key_only_is_not_a_certificate_identity(self):
        with self.assertRaisesRegex(ValueError, "missing"):
            certificate_digest(f"Signer #1 public key SHA-256 digest: {_DIGEST}")

    def test_source_stamp_only_is_not_an_apk_signer(self):
        with self.assertRaisesRegex(ValueError, "missing"):
            certificate_digest(
                f"Source Stamp Signer certificate SHA-256 digest: {_DIGEST}"
            )

    def test_public_key_and_source_stamp_are_ignored_when_apk_signer_exists(self):
        output = "\n".join(
            (
                f"Signer #1 public key SHA-256 digest: {_OTHER_DIGEST}",
                f"Source Stamp Signer certificate SHA-256 digest: {_OTHER_DIGEST}",
                f"Signer #1 certificate SHA-256 digest: {_DIGEST}",
            )
        )
        self.assertEqual(certificate_digest(output), _DIGEST)

    def test_malformed_digest_encodings_fail_closed(self):
        malformed = (
            "a" * 63,
            "g" * 64,
            "-".join(["01"] * 32),
            ":".join(["01"] * 31),
            ":".join(["001"] + ["01"] * 31),
        )
        for value in malformed:
            with self.subTest(value=value):
                with self.assertRaisesRegex(ValueError, "Malformed"):
                    certificate_digest(
                        f"Signer #1 certificate SHA-256 digest: {value}"
                    )

    def test_unknown_or_malformed_certificate_labels_fail_closed(self):
        lines = (
            f"V5 Signer: certificate SHA-256 digest: {_DIGEST}",
            f"Custom Signer: certificate SHA-256 digest: {_DIGEST}",
            "V3.1 Signer: (minSdkVersion=33 maxSdkVersion=2147483647) "
            f"certificate SHA-256 digest: {_DIGEST}",
            f"Signer #1 certificate SHA-256 digest {_DIGEST}",
            f"Signer #1 certificate SHA-256 digest: {_DIGEST} trailing-data",
            "V3 Signer: (minSdkVersion=35, maxSdkVersion=33) "
            f"certificate SHA-256 digest: {_DIGEST}",
            "V3 Signer: (minSdkVersion=33, maxSdkVersion=2147483648) "
            f"certificate SHA-256 digest: {_DIGEST}",
        )
        for line in lines:
            with self.subTest(line=line):
                with self.assertRaises(ValueError):
                    certificate_digest(line)


if __name__ == "__main__":
    unittest.main()
