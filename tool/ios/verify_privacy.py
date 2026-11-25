"""Verify the app-owned required-reason declaration in source, app or IPA."""
import argparse
import plistlib
import zipfile
from pathlib import Path

parser = argparse.ArgumentParser(description=__doc__)
parser.add_argument("path", type=Path)
args = parser.parse_args()
if args.path.suffix == ".ipa":
    with zipfile.ZipFile(args.path) as archive:
        names = [n for n in archive.namelist()
                 if n.startswith("Payload/") and n.endswith(".app/PrivacyInfo.xcprivacy")
                 and n.count("/") == 2]
        if len(names) != 1:
            raise SystemExit("Expected one app-root privacy manifest in IPA")
        manifest = plistlib.loads(archive.read(names[0]))
else:
    path = args.path / "PrivacyInfo.xcprivacy" if args.path.is_dir() else args.path
    manifest = plistlib.loads(path.read_bytes())
entries = manifest.get("NSPrivacyAccessedAPITypes", [])
matching = [e for e in entries
            if e.get("NSPrivacyAccessedAPIType") == "NSPrivacyAccessedAPICategorySystemBootTime"]
if len(matching) != 1 or "35F9.1" not in matching[0].get("NSPrivacyAccessedAPITypeReasons", []):
    raise SystemExit("Missing app timer API reason 35F9.1")
print("App timer privacy declaration verified")
