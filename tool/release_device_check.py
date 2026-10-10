"""Owned Android release QA helper; taps only nodes from a freshly observed UI dump."""
import argparse
import os
from pathlib import Path
import re
import subprocess
import xml.etree.ElementTree as ET

ADB = "C:/Users/rubicon/AppData/Local/Android/Sdk/platform-tools/adb.exe"
DEVICE = os.environ.get("NSHOPTOR_QA_DEVICE", "emulator-5554")
OUT = Path(os.environ.get("APP_PUBLISHING_ROOT", "D:/AppPublishing")) / "apps/nshoptor/artifacts/release-qa"


def adb(*args):
    return subprocess.check_output([ADB, "-s", DEVICE, *args])


def nodes():
    dump = adb("shell", "uiautomator", "dump", "/sdcard/nshoptor-qa-window.xml")
    assert b"dumped to:" in dump, "fresh UI root unavailable; retry after the app draws (never use stale XML)"
    return list(ET.fromstring(adb("shell", "cat", "/sdcard/nshoptor-qa-window.xml")).iter("node"))


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("action", choices=["show", "tap", "point", "field", "type", "replace", "back", "shot", "wake"])
    parser.add_argument("value", nargs="?", default="")
    args = parser.parse_args()
    assert adb("emu", "avd", "name").decode().splitlines()[0] == os.environ.get("NSHOPTOR_QA_AVD", "nshoptor_test"), "wrong emulator"
    if args.action == "show":
        for n in nodes():
            a = n.attrib
            if a.get("text") or a.get("content-desc") or a.get("class") == "android.widget.EditText":
                print(a.get("text") or a.get("content-desc"), a.get("class"), a.get("bounds"))
    elif args.action == "tap":
        matches = [n for n in nodes() if args.value in [n.get("text"), n.get("content-desc"), n.get("resource-id")]]
        assert len(matches) == 1, "expected exactly one observed target"
        x1, y1, x2, y2 = map(int, re.findall(r"\d+", matches[0].get("bounds")))
        adb("shell", "input", "tap", str((x1 + x2) // 2), str((y1 + y2) // 2))
    elif args.action == "point":
        # Coordinates must come from the current captured portrait screenshot.
        x, y = map(int, args.value.split(","))
        assert 0 <= x < 1080 and 0 <= y < 2400
        adb("shell", "input", "tap", str(x), str(y))
    elif args.action == "field":
        editable = [n for n in nodes() if n.get("class") == "android.widget.EditText"]
        target = editable[int(args.value)]
        x1, y1, x2, y2 = map(int, re.findall(r"\d+", target.get("bounds")))
        assert x2 > x1 and y2 > y1 and 0 <= y1 < 2400, "field must be visible"
        adb("shell", "input", "tap", str((x1 + x2) // 2), str((y1 + y2) // 2))
    elif args.action == "replace":
        editable = [n for n in nodes() if n.get("class") == "android.widget.EditText" and n.get("focused") == "true"]
        assert len(editable) == 1, "one focused QA field required"
        adb("shell", "input", "keyevent", "123")
        for _ in editable[0].get("text", ""):
            adb("shell", "input", "keyevent", "67")
        assert re.fullmatch(r"[A-Za-z0-9 .,%_-]+", args.value)
        adb("shell", "input", "text", args.value.replace(" ", "%s"))
    elif args.action == "type":
        assert re.fullmatch(r"[A-Za-z0-9 .,%_-]+", args.value), "only simple synthetic QA text"
        adb("shell", "input", "text", args.value.replace(" ", "%s"))
    elif args.action == "back":
        adb("shell", "input", "keyevent", "4")
    elif args.action == "shot":
        assert re.fullmatch(r"[a-z0-9_-]+", args.value), "owned screenshot name required"
        OUT.mkdir(parents=True, exist_ok=True)
        (OUT / (args.value + ".png")).write_bytes(adb("exec-out", "screencap", "-p"))
    else:
        state = adb("shell", "dumpsys", "window", "windows").decode(errors="replace")
        lines = state.splitlines()
        sections = ["\n".join(lines[i:i + 15]) for i, line in enumerate(lines)
                    if "com.crazypenguin.nshoptor" in line and "Window #" in line]
        current = "\n".join(sections)
        if args.value:
            assert args.value in ["on", "off"], "expected on/off"
            assert ("KEEP_SCREEN_ON" in current) == (args.value == "on"), "native wake flag disagrees"
            OUT.mkdir(parents=True, exist_ok=True)
            (OUT / ("wake_" + args.value + ".txt")).write_text(current, encoding="utf-8")
            print("native keep-screen-on=" + args.value)
        else:
            print(current)



if __name__ == "__main__":
    main()
