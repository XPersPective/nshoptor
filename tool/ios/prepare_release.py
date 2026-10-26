"""Prepare private, ephemeral iOS release inputs on the macOS CI runner."""

from __future__ import annotations

import argparse
import base64
import datetime as dt
import json
import os
from pathlib import Path
import plistlib
import re
import shutil
import subprocess
import sys


TEAM_ID = "53X3279WA3"
BUNDLE_ID = "com.crazypenguin.nshoptor"
PROFILE_NAME = "NShoptor AppStore"
VERSION = "1.3.1"
BUILD_NUMBER = "19"
APPLE_ID = "6827116818"
ADS_KEYS = {
    "ADMOB_APP_ID_IOS",
    "ADMOB_BANNER_IOS",
    "ADMOB_INTERSTITIAL_IOS",
    "ADMOB_APP_OPEN_IOS",
}
UNIT_KEYS = ADS_KEYS - {"ADMOB_APP_ID_IOS"}
TEST_PUBLISHER_ID = "3940256099942544"


class ReleaseInputError(Exception):
    pass


def _asc_key_id() -> str:
    value = os.environ.get('IOS_ASC_KEY_ID', '')
    if not re.fullmatch(r'[A-Z0-9]{10}', value):
        raise ReleaseInputError('App Store Connect key identifier is missing or malformed')
    return value


def _private_dir() -> Path:
    raw_runner_temp = os.environ.get("RUNNER_TEMP")
    if not raw_runner_temp:
        raise ReleaseInputError("RUNNER_TEMP is unavailable")
    runner_temp = Path(raw_runner_temp).resolve()
    if not runner_temp.is_dir():
        raise ReleaseInputError("RUNNER_TEMP is unavailable")
    output = (runner_temp / "nshoptor-ios-release").resolve()
    if output.parent != runner_temp:
        raise ReleaseInputError("Private output path is invalid")
    output.mkdir(mode=0o700, parents=True, exist_ok=True)
    try:
        output.chmod(0o700)
    except OSError:
        pass
    return output


def _secret(name: str) -> str:
    value = os.environ.get(name)
    if value is None or not value:
        raise ReleaseInputError(f"Required secret {name} is missing")
    return value


def _decode_secret(name: str, value: str, destination: Path) -> None:
    encoded = "".join(value.split())
    try:
        content = base64.b64decode(encoded, validate=True)
    except (ValueError, base64.binascii.Error) as exc:
        raise ReleaseInputError(f"Secret {name} is not valid base64") from exc
    if not content:
        raise ReleaseInputError(f"Secret {name} decoded empty")
    destination.write_bytes(content)
    destination.chmod(0o600)


def _ads_json(raw: str) -> dict[str, str]:
    def reject_duplicates(pairs: list[tuple[str, object]]) -> dict[str, object]:
        result: dict[str, object] = {}
        for key, value in pairs:
            if key in result:
                raise ReleaseInputError("Ad configuration contains duplicate keys")
            result[key] = value
        return result

    try:
        values = json.loads(raw, object_pairs_hook=reject_duplicates)
    except (json.JSONDecodeError, TypeError) as exc:
        raise ReleaseInputError("Ad configuration JSON is invalid") from exc
    if not isinstance(values, dict) or set(values) != ADS_KEYS:
        raise ReleaseInputError("Ad configuration must contain exactly the four iOS AdMob keys")
    app_id_pattern = re.compile(r"^ca-app-pub-\d{16}~\d{10}$")
    unit_pattern = re.compile(r"^ca-app-pub-\d{16}/\d{10}$")
    for key, value in values.items():
        if not isinstance(value, str):
            raise ReleaseInputError("Ad configuration values must be strings")
        pattern = app_id_pattern if key == "ADMOB_APP_ID_IOS" else unit_pattern
        if not pattern.fullmatch(value) or TEST_PUBLISHER_ID in value:
            raise ReleaseInputError(f"Ad configuration value for {key} is invalid or a Google test ID")
    return values


def _decode_profile(profile_path: Path) -> dict[str, object]:
    try:
        result = subprocess.run(
            ["security", "cms", "-D", "-i", str(profile_path)],
            check=True,
            stdout=subprocess.PIPE,
            stderr=subprocess.DEVNULL,
        )
        profile = plistlib.loads(result.stdout)
    except (
        OSError,
        subprocess.CalledProcessError,
        plistlib.InvalidFileException,
        ValueError,
        TypeError,
    ) as exc:
        raise ReleaseInputError("Provisioning profile could not be verified and decoded") from exc
    expected_app_id = f"{TEAM_ID}.{BUNDLE_ID}"
    teams = profile.get("TeamIdentifier")
    entitlements = profile.get("Entitlements")
    expires = profile.get("ExpirationDate")
    if profile.get("Name") != PROFILE_NAME:
        raise ReleaseInputError("Provisioning profile name does not match the release profile")
    if teams != [TEAM_ID]:
        raise ReleaseInputError("Provisioning profile team does not match")
    if not isinstance(entitlements, dict):
        raise ReleaseInputError("Provisioning profile entitlements are missing")
    if entitlements.get("application-identifier") != expected_app_id:
        raise ReleaseInputError("Provisioning profile application identifier does not match")
    if entitlements.get("com.apple.developer.team-identifier") != TEAM_ID:
        raise ReleaseInputError("Provisioning profile team entitlement does not match")
    if entitlements.get("get-task-allow") is not False:
        raise ReleaseInputError("Provisioning profile is not a distribution profile")
    if "ProvisionedDevices" in profile or "ProvisionsAllDevices" in profile:
        raise ReleaseInputError("Provisioning profile is not App Store distribution")
    if not isinstance(expires, dt.datetime):
        raise ReleaseInputError("Provisioning profile expiration is missing")
    if expires.tzinfo is None:
        expires = expires.replace(tzinfo=dt.timezone.utc)
    expires = expires.astimezone(dt.timezone.utc)
    if expires <= dt.datetime.now(dt.timezone.utc):
        raise ReleaseInputError("Provisioning profile has expired")
    profile_uuid = profile.get("UUID")
    if not isinstance(profile_uuid, str) or not re.fullmatch(
        r"[0-9a-fA-F]{8}-(?:[0-9a-fA-F]{4}-){3}[0-9a-fA-F]{12}", profile_uuid
    ):
        raise ReleaseInputError("Provisioning profile UUID is invalid")
    return {
        "profile_uuid": profile_uuid,
        "profile_name": PROFILE_NAME,
        "team_id": TEAM_ID,
        "bundle_id": BUNDLE_ID,
        "expiration_utc": expires.isoformat(),
    }


def prepare() -> None:
    output = _private_dir()
    p12_path = output / "signing.p12"
    profile_path = output / "profile.mobileprovision"
    ads_path = output / "ads.json"
    runner_temp = Path(os.environ["RUNNER_TEMP"]).resolve()
    private_keys = (runner_temp / "private_keys").resolve()
    if private_keys.parent != runner_temp:
        raise ReleaseInputError("App Store Connect key path is invalid")
    private_keys.mkdir(mode=0o700, parents=True, exist_ok=True)
    try:
        private_keys.chmod(0o700)
    except OSError:
        pass
    key_path = private_keys / f"AuthKey_{_asc_key_id()}.p8"

    _secret("NSHOPTOR_IOS_P12_PASSWORD")
    _decode_secret("NSHOPTOR_IOS_P12_BASE64", _secret("NSHOPTOR_IOS_P12_BASE64"), p12_path)
    _decode_secret(
        "NSHOPTOR_IOS_PROFILE_BASE64",
        _secret("NSHOPTOR_IOS_PROFILE_BASE64"),
        profile_path,
    )
    ads = _ads_json(_secret("NSHOPTOR_IOS_ADS_JSON"))
    ads_path.write_text(json.dumps(ads, separators=(",", ":")), encoding="utf-8")
    ads_path.chmod(0o600)

    private_key = _secret("NSHOPTOR_ASC_PRIVATE_KEY").strip()
    if not private_key.startswith("-----BEGIN PRIVATE KEY-----") or not private_key.endswith(
        "-----END PRIVATE KEY-----"
    ):
        raise ReleaseInputError("App Store Connect private key is not a PKCS#8 PEM")
    key_path.write_text(private_key + "\n", encoding="ascii")
    key_path.chmod(0o600)
    profile_data = _decode_profile(profile_path)
    profile_data["apple_id"] = APPLE_ID
    (output / "profile.json").write_text(
        json.dumps(profile_data, separators=(",", ":")), encoding="utf-8"
    )
    (output / "profile.json").chmod(0o600)

    unit_values = {key: ads[key] for key in sorted(UNIT_KEYS)}
    (output / "defines.json").write_text(
        json.dumps(unit_values, separators=(",", ":")), encoding="utf-8"
    )
    (output / "defines.json").chmod(0o600)

    ads_config = Path("ios/Flutter/AdsConfig.xcconfig")
    ads_config.write_text(f"ADMOB_APP_ID_IOS = {ads['ADMOB_APP_ID_IOS']}\n", encoding="utf-8")

    export_options = {
        "destination": "export",
        "method": "app-store-connect",
        "provisioningProfiles": {BUNDLE_ID: PROFILE_NAME},
        "signingCertificate": "Apple Distribution",
        "signingStyle": "manual",
        "stripSwiftSymbols": True,
        "teamID": TEAM_ID,
        "uploadSymbols": True,
    }
    with (output / "ExportOptions.plist").open("wb") as export_file:
        plistlib.dump(export_options, export_file, sort_keys=True)
    (output / "ExportOptions.plist").chmod(0o600)

    print(
        "Validated iOS release inputs: "
        f"team={TEAM_ID}, bundle={BUNDLE_ID}, profile={PROFILE_NAME}, "
        f"expires={profile_data['expiration_utc']}, ads=4 configured"
    )


def cleanup() -> None:
    raw_runner_temp = os.environ.get("RUNNER_TEMP")
    if not raw_runner_temp:
        raise ReleaseInputError("RUNNER_TEMP is unavailable")
    runner_temp = Path(raw_runner_temp).resolve()
    output = (runner_temp / "nshoptor-ios-release").resolve()
    if output.parent != runner_temp:
        raise ReleaseInputError("Cleanup path is invalid")
    metadata = output / "profile.json"
    if metadata.is_file():
        try:
            profile_uuid = json.loads(metadata.read_text(encoding="utf-8")).get("profile_uuid")
        except (OSError, json.JSONDecodeError):
            profile_uuid = None
        if isinstance(profile_uuid, str) and re.fullmatch(
            r"[0-9a-fA-F]{8}-(?:[0-9a-fA-F]{4}-){3}[0-9a-fA-F]{12}", profile_uuid
        ):
            installed = (
                Path.home()
                / "Library"
                / "MobileDevice"
                / "Provisioning Profiles"
                / f"{profile_uuid}.mobileprovision"
            )
            if installed.is_file() and not installed.is_symlink():
                installed.unlink()
    for name in (
        "signing.p12",
        "profile.mobileprovision",
        "ads.json",
        "defines.json",
        "profile.json",
        "ExportOptions.plist",
    ):
        target = output / name
        if target.is_file() and not target.is_symlink():
            target.unlink()
    ipa_contents = output / "ipa-contents"
    if ipa_contents.is_dir() and not ipa_contents.is_symlink():
        shutil.rmtree(ipa_contents)
    private_keys = runner_temp / "private_keys"
    asc_key = private_keys / f"AuthKey_{_asc_key_id()}.p8"
    if asc_key.is_file() and not asc_key.is_symlink():
        asc_key.unlink()
    if private_keys.is_dir() and not private_keys.is_symlink():
        try:
            private_keys.rmdir()
        except OSError:
            pass
    if output.is_dir() and not output.is_symlink():
        try:
            output.rmdir()
        except OSError:
            pass
    print("Ephemeral iOS signing inputs cleaned")


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("command", choices=("prepare", "cleanup"))
    args = parser.parse_args()
    try:
        if args.command == "prepare":
            prepare()
        else:
            cleanup()
    except ReleaseInputError as exc:
        print(f"iOS release preparation failed: {exc}", file=sys.stderr)
        return 1
    except OSError:
        print("iOS release preparation failed: a required private file could not be accessed", file=sys.stderr)
        return 1
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
