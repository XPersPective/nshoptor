# Emulator stability readback — 2026-10-25

Read-only diagnostic on the task-specific AVD `emulator-5556` (`Medium_Phone_API_36.0`-derived temporary AVD). The shared `emulator-5554` was not queried. Device clock reported 2026-10-25 01:52:50 UTC. Root had already disabled Bluetooth on this temporary device; readback confirms `settings global bluetooth_on = 0` and the log records the disable command succeeding at 01:52:20 UTC.

## Evidence

- `dumpsys activity exit-info com.crazypenguin.nshoptor` reported the app process (PID 4888) exited at 01:47:39.765 UTC for **ANR**, with the system description `Input dispatching timed out ... MainActivity is not responding. Waited 5002ms for MotionEvent`. The linked ANR trace was timestamped 01:45:21.362 UTC. This is an input-dispatch ANR, not evidence of an app native crash.
- Filtered recent logcat confirms Android showed the app's ANR window at 01:47:35.815, force-finished MainActivity at 01:47:39.205, and killed PID 4888 at 01:47:39.741. It also contains a Bluetooth power-stats collection failure at 01:48:07 (Bluetooth activity info unavailable/error 9), consistent with the device Bluetooth stack being unhealthy. Root's prior log read identified repeated `com.google.android.bluetooth` HciHal startup SIGABRTs.
- A read-only `dumpsys activity processes` snapshot after that exit contained no `com.crazypenguin.nshoptor` process. No app relaunch was performed, so these checks cannot establish post-disable app behavior.
- `dumpsys meminfo` twice timed out after 10 seconds. Device RAM pressure therefore could not be assessed from Android's service output.
- Windows host query reported 15.71 GiB total visible RAM and 0.80 GiB free at readback. That indicates substantial host memory pressure at that moment; it does not establish that host pressure caused the earlier ANR. Emulator process details were unavailable from the attempted process-name query.

## Assessment and limits

The recorded app failure is an input-dispatch ANR, while separate evidence points to Android Bluetooth/HCI instability. The Bluetooth disable took effect after the ANR, and no controlled app relaunch or interaction was done afterward. Thus this readback does not show whether disabling Bluetooth changes app behavior and cannot support a stability claim. Host memory pressure is a plausible contributing condition, but causation is unproven. No app/process changes, emulator restarts, log clearing, installs, builds, or tests were performed during this readback.

## Follow-up after restart of the task AVD

At the root agent's request, only `emulator-5556` was stopped with `adb emu kill` and restarted from the same verified AVD name `nshoptor_temp_api36` at port 5556 with `-memory 2048 -cores 4 -no-snapshot -no-boot-anim`. User data was preserved. The device reported boot complete; the display overrides remained 720x1600 at density 280 and Bluetooth remained off (`bluetooth_on=0`). Windows free RAM was still only about 0.88 GiB shortly after boot.

The installed app was started with `am start -W -n com.crazypenguin.nshoptor/.MainActivity`; Android returned `Status: timeout`, `WaitTime: 16141`, `LaunchState: UNKNOWN`. The process was alive as PID 1630, but Android logged `ANR in com.crazypenguin.nshoptor/.MainActivity` at 01:59:46.951 UTC. At approximately 02:00 UTC, the screenshot showed the list screen behind an “NShoptor isn't responding” system dialog. A bounded tap on the visible “Wait” action followed by 12 seconds did not clear the dialog; at 02:01:24 UTC, focus still reported `Application Not Responding: com.crazypenguin.nshoptor` and PID 1630 remained present. See [emulator-5556-after-reboot.png](../../artifacts/qa/2026-10-25-native/emulator-5556-after-reboot.png).

The same boot's logcat records multiple low-memory-killer actions with “low watermark is breached” / “device is not responding” reasons, including kills of Permission Controller, carrier config, Android Contacts process, Messaging, keyboard, TTS, WebView, and other system apps. ActivityManager logged additional Messaging ANRs at 02:00:03 and 02:00:24 UTC. This strongly supports whole-device pressure as a condition during the reproduced NShoptor ANR, but does not identify whether app work also contributed. The device's `/proc/pressure/{memory,cpu,io}` files were not readable via the shell UID, and `dumpsys meminfo` had timed out in the earlier readback, so there is no complete device PSI/memory measurement.

Because the app still showed an ANR after the single Wait action, no further UI gestures (guide/search/new-list/settings) were attempted. No app state was cleared and no further restart was performed. This is a reproduced ANR after a clean emulator reboot, with persistent host memory pressure; no stability claim is supported.

## AOSP image availability and install follow-up

After confirming the task-specific AVD name again, emulator-5556 was shut down with `adb emu kill` to free host memory; emulator-5554 was not touched and no AVD was created or started. The Android SDK manager listed both Android 36 revision 2 and Android 35 revision 2 `default;x86_64` system images. The existing installed Google Play API 36 image's package metadata uses `android-sdk-license`, whose accepted hash file was already present.

The Android 36 `system-images;android-36;default;x86_64` install was started without accepting any new licenses. At follow-up, the SDK Manager Java process was no longer active and the package directory was present with `Pkg.Revision=2`, `SystemImage.TagId=default`, `SystemImage.Abi=x86_64`, and a 1,898,971,136-byte `system.img`. This verifies image files and package metadata are installed; the captured command log did not include a clear success line, so command exit status is not confirmed. C: free space read 42.1 GiB before install and 39.8 GiB after. No AVD was created or launched pending root coordination.

SDK Manager output was saved to `C:\Users\rubicon\.android\avd\nshoptor-aosp-install.log`; it contains the available package listing, while the installed package's local metadata was independently read from the SDK.

## Temporary AOSP AVD prepared

Created one AVD named `nshoptor_temp_aosp_api36` at `C:\Users\rubicon\.android\avd\nshoptor_temp_aosp_api36.avd` using `system-images;android-36;default;x86_64` revision 2 and `medium_phone`. Its `config.ini` is set to 720x1600 at density 280, 2048 MB RAM, and 2 CPU cores. `avdmanager list avd` confirms the exact path and Default Android System Image target; the system image file exists. The AVD has not been started. Existing AVD directories and user data were left untouched.

Cleanup reminder: after all native investigations and testing on the temporary AVDs finish, remove only these task-owned AVDs (`nshoptor_temp_aosp_api36` and `nshoptor_temp_api36`) and their matching `.ini` registrations if the user/root directs cleanup. Do not remove either before the native work is complete; no cleanup has been performed.
