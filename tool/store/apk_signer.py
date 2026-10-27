"""Strict parsing for the APK signer certificate digest printed by apksigner."""

from __future__ import annotations

import re


_HEX_DIGEST = re.compile(r"[0-9A-Fa-f]{64}\Z")
_COLON_DIGEST = re.compile(r"[0-9A-Fa-f]{2}(?::[0-9A-Fa-f]{2}){31}\Z")
_CERTIFICATE_MARKER = re.compile(
    r"\bcertificate\b.*\bSHA-256\b.*\bdigest\b", re.IGNORECASE
)
_SOURCE_STAMP = re.compile(r"^Source Stamp Signer certificate SHA-256 digest:")

_RANGE = r"\(minSdkVersion=(?P<min_sdk>[0-9]+), maxSdkVersion=(?P<max_sdk>[0-9]+)\)"
_DIGEST_VALUE = r"[ \t]+(?P<digest>\S+)[ \t]*"
_LABEL_PATTERNS = (
    re.compile(
        r"Signer #[1-9][0-9]* certificate SHA-256 digest:" + _DIGEST_VALUE
    ),
    re.compile(
        r"(?:(?:V1|V2|V3(?:\.[0-9]+)?|V4) )?Signer: "
        r"(?:" + _RANGE + r" )?certificate SHA-256 digest:"
        + _DIGEST_VALUE
    ),
    re.compile(
        r"Signer " + _RANGE + r" certificate SHA-256 digest:" + _DIGEST_VALUE
    ),
)


def _normalize_digest(value: str) -> str:
    if _HEX_DIGEST.fullmatch(value):
        return value.lower()
    if _COLON_DIGEST.fullmatch(value):
        return value.replace(":", "").lower()
    raise ValueError("Malformed APK signer certificate SHA-256 digest")


def _check_sdk_range(match: re.Match[str]) -> None:
    min_sdk = match.groupdict().get("min_sdk")
    max_sdk = match.groupdict().get("max_sdk")
    if min_sdk is not None:
        min_value = int(min_sdk)
        max_value = int(max_sdk)
        if min_value > max_value or max_value > 2_147_483_647:
            raise ValueError("Malformed APK signer SDK range")


def certificate_digest(output: str) -> str:
    """Return the one unique APK certificate SHA-256 digest from apksigner output.

    Only known APK signer certificate labels are accepted. Public-key and source
    stamp digests are not APK signing identities and are never used as fallbacks.
    """
    if not isinstance(output, str):
        raise TypeError("apksigner output must be text")

    digests: set[str] = set()
    for raw_line in output.splitlines():
        line = raw_line.strip()
        if _SOURCE_STAMP.match(line):
            continue
        if not _CERTIFICATE_MARKER.search(line):
            continue

        for pattern in _LABEL_PATTERNS:
            match = pattern.fullmatch(line)
            if match is not None:
                _check_sdk_range(match)
                digests.add(_normalize_digest(match.group("digest")))
                break
        else:
            raise ValueError("Unrecognized APK signer certificate SHA-256 label")

    if not digests:
        raise ValueError("APK signer certificate SHA-256 digest is missing")
    if len(digests) != 1:
        raise ValueError("APK signer certificate SHA-256 digests conflict")
    return next(iter(digests))
