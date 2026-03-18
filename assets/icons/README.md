# App icon and splash assets

- **app_icon.png** – Source app icon (1024×1024 recommended). Used for:
  - **Launcher icons (Android, iOS, Windows, macOS):** `dart run flutter_launcher_icons`
  - **Splash screens (Android + iOS):** `dart run flutter_native_splash:create`
- Replace `app_icon.png` with your own asset, then re-run the commands above to regenerate platform assets.
- **Note:** Linux is not supported by `flutter_launcher_icons`; desktop splash screens are not supported by `flutter_native_splash`.
