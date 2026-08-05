# App icon and splash assets

| File | Purpose |
|------|---------|
| **app_icon.png** | Launcher icon (1024×1024). Mark only — **no wordmark**. |
| **splash_fullscreen.png** | Aligned splash (1284×2778). Mark + **Reflect** — Android native + iOS Flutter overlay. |
| **splash_ios_native.png** | iOS native launch only (1284×2778). Mark only — matches mark position in fullscreen splash. |

## Regenerate

```bash
make splash
```

Runs `tool/generate_splash_assets.py`, launcher icons, `flutter_native_splash:create`, and `tool/patch_splash_platforms.sh` (Android v31 + iOS storyboard patches).

## Platform behavior

**Android 12+:** `values-v31/styles.xml` uses `@drawable/launch_background` (full-screen static splash).

**iOS:** Native launch uses mark-only `splash_ios_native.png` so the icon zoom does not squash the wordmark. The aligned lockup (mark + **Reflect**) is shown by `ReflectLaunchOverlay` in Flutter. Runtime handoff uses `FlutterNativeSplash.preserve()` / `remove()` in `lib/main.dart` and `lib/core/startup/reflect_launch_overlay.dart`.

## Verify on iOS (after splash changes)

1. `flutter clean`
2. Uninstall the app (clears cached launch screens)
3. Cold install: `flutter run`
4. Kill app → relaunch by **tapping the home-screen icon** (not hot restart)

**Pass:** mark-only zoom → aligned splash with Reflect → Today. No congested wordmark during zoom.
