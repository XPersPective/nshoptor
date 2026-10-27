#!/usr/bin/env python3
"""Fetch and validate the public CORDv2 test-row-1 native OCR fixture."""

from __future__ import annotations

import argparse
import base64
import hashlib
import json
import os
from pathlib import Path
import sys
from urllib.error import HTTPError, URLError
from urllib.parse import urlparse
from urllib.request import HTTPRedirectHandler, Request, build_opener


DATASET = "naver-clova-ix/cord-v2"
REVISION = "7f0115a4b758a71d6473b8d085751692da2fef98"
ROWS_URL = (
    "https://datasets-server.huggingface.co/rows?"
    "dataset=naver-clova-ix%2Fcord-v2&config=default&split=test&offset=1&length=1"
)
ALLOWED_HOST = "datasets-server.huggingface.co"
IMAGE_SHA256 = "636284664cfc357e05f7b10d67ddb380f828a1be0a20809514f9e7fc0c611a9f"
IMAGE_LENGTH = 56652
EXPECTED_GROUND_TRUTH = {
    "linePrices": ["17500", "46000", "27500"],
    "totalPrice": "91000",
}
EXPECTED = {
    "currency": "IDR",
    "lineTotalsMinor": [1750000, 2750000, 4600000],
    "totalMinor": 9100000,
}
MAX_IMAGE_BYTES = 100000
MAX_RESPONSE_BYTES = 250000


class _CheckedRedirects(HTTPRedirectHandler):
    """Validate each redirect target before urllib is allowed to request it."""

    def redirect_request(self, req, fp, code, msg, headers, newurl):  # noqa: ANN001
        _validate_url(newurl)
        return super().redirect_request(req, fp, code, msg, headers, newurl)


def _validate_url(url: str) -> None:
    parsed = urlparse(url)
    if (
        parsed.scheme != "https"
        or parsed.hostname != ALLOWED_HOST
        or parsed.username is not None
        or parsed.password is not None
        or parsed.port not in (None, 443)
    ):
        raise ValueError("Refusing non-allowlisted dataset URL")


def _read_limited(url: str, limit: int) -> bytes:
    _validate_url(url)
    opener = build_opener(_CheckedRedirects())
    request = Request(url, headers={"User-Agent": "nshoptor-cord-fixture/1"})
    try:
        with opener.open(request, timeout=30) as response:
            final_url = response.geturl()
            _validate_url(final_url)
            payload = response.read(limit + 1)
    except (HTTPError, URLError, TimeoutError) as error:
        raise RuntimeError(f"Dataset fetch failed: {type(error).__name__}") from error
    if len(payload) > limit:
        raise ValueError("Dataset response exceeds the configured size limit")
    return payload


def _row_from_response(payload: bytes) -> tuple[dict, dict]:
    response = json.loads(payload)
    rows = response.get("rows")
    if not isinstance(rows, list) or len(rows) != 1:
        raise ValueError("Expected exactly one CORDv2 row")
    row = rows[0].get("row")
    if not isinstance(row, dict):
        raise ValueError("Dataset response has no row object")
    image = row.get("image")
    if not isinstance(image, dict) or not isinstance(image.get("src"), str):
        raise ValueError("Dataset row has no image URL")
    if REVISION not in image["src"]:
        raise ValueError("Dataset image does not match the pinned revision")
    ground_truth = json.loads(row.get("ground_truth", "{}"))
    parsed = ground_truth.get("gt_parse", {})
    menu = parsed.get("menu", [])
    prices = [entry.get("price") for entry in menu if isinstance(entry, dict)]
    total = parsed.get("total", {}).get("total_price")
    if prices != EXPECTED_GROUND_TRUTH["linePrices"] or total != EXPECTED_GROUND_TRUTH["totalPrice"]:
        raise ValueError("Dataset row ground truth differs from the pinned receipt")
    return image, ground_truth


def _repo_root() -> Path:
    return Path(__file__).resolve().parents[2]


def _write_define_file(output: Path, image_bytes: bytes) -> None:
    resolved_output = output.resolve()
    try:
        resolved_output.relative_to(_repo_root())
    except ValueError:
        pass
    else:
        raise ValueError("Fixture define output must remain outside the Git repository")
    fixture = {
        "imageBase64": base64.b64encode(image_bytes).decode("ascii"),
        "expected": EXPECTED,
        "revision": REVISION,
    }
    encoded_fixture = json.dumps(fixture, separators=(",", ":"), ensure_ascii=False)
    dart_define = f"CORD_RECEIPT_FIXTURE={encoded_fixture}".encode("utf-8")
    if len(base64.b64encode(dart_define)) > 110000:
        raise ValueError("CORD_RECEIPT_FIXTURE exceeds the safe dart-define size")
    contents = json.dumps(
        {"CORD_RECEIPT_FIXTURE": encoded_fixture},
        separators=(",", ":"),
    )
    if resolved_output.exists():
        if json.loads(resolved_output.read_text(encoding="utf-8")) == json.loads(contents):
            return  # Exact verified fixture is reusable; never overwrite another file.
        raise FileExistsError(f"Existing private fixture differs: {resolved_output}")
    resolved_output.parent.mkdir(parents=True, exist_ok=True)
    resolved_output.write_text(contents + os.linesep, encoding="utf-8")


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--output", required=True, type=Path)
    args = parser.parse_args()

    try:
        image, _ = _row_from_response(_read_limited(ROWS_URL, MAX_RESPONSE_BYTES))
        image_bytes = _read_limited(image["src"], MAX_IMAGE_BYTES)
        if len(image_bytes) != IMAGE_LENGTH:
            raise ValueError("Dataset image length differs from the pinned JPEG")
        if hashlib.sha256(image_bytes).hexdigest() != IMAGE_SHA256:
            raise ValueError("Dataset image SHA-256 differs from the pinned JPEG")
        if not image_bytes.startswith(b"\xff\xd8\xff"):
            raise ValueError("Dataset payload is not a JPEG")
        _write_define_file(args.output, image_bytes)
    except (OSError, ValueError, RuntimeError, json.JSONDecodeError) as error:
        print(f"CORD fixture preparation failed: {error}", file=sys.stderr)
        return 1

    print(
        f"CORD fixture ready: rows=1 image_bytes={IMAGE_LENGTH} "
        f"sha256={IMAGE_SHA256} define_bytes={args.output.stat().st_size}"
    )
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
