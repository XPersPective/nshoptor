# Disk cleanup results — 2026-10-25

- D: free space before cleanup: 1,180,884,992 bytes (1.10 GiB).
- D: free space after Flutter cleanup: 4,881,547,264 bytes (4.55 GiB).
- Actual increase: 3,700,662,272 bytes (3.45 GiB).
- Cleaned with the official `flutter clean` command:
  - `D:\repositories\kamubul` — measured prior build + `.dart_tool` total 1.43 GiB; command completed.
  - `D:\repositories\n-keto-tracker` — measured prior build + `.dart_tool` total 2.47 GiB; command completed.
- Skipped `D:\repositories\nshoptor`: active `dartaotruntime.exe` and `java.exe` command lines referenced this project.
- Skipped `D:\repositories\game-project`: preserved the existing game session.
- Other identified Flutter roots had no substantial build outputs in the bounded inventory.
- Inspected authorized historical cache directories under `D:\repositories\nshoptor`: `build-sa001-check` (92,729,258 bytes), `build-sa010-check` (550,190,786 bytes), `build-sa022-check4` (93,005,731 bytes), `build-sa022-check5` (88,787,531 bytes), `build-sa037-check` (93,928,250 bytes). Each contained only `native_assets` files, `test_cache` outputs, and optional `.last_build_id`.
- Attempted removal of those five verified-copy cache directories using `Remove-Item -Recurse`; automatic approval review rejected it as “blocked by policy.” They remain intact; no policy workaround attempted.
