import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:reflect/core/presentation/theme/reflect_colors.dart';

/// iOS: aligned splash overlay while native mark-only launch dismisses.
/// Android: removes native splash after the first frame (no overlay).
class ReflectLaunchOverlay extends StatefulWidget {
  const ReflectLaunchOverlay({
    required this.child,
    this.showIosOverlay = _defaultShowIosOverlay,
    this.removeNativeSplash = FlutterNativeSplash.remove,
    this.onNativeSplashRemoved,
    this.onOverlayHidden,
    super.key,
  });

  static const _splashAsset = 'assets/icons/splash_fullscreen.png';

  final Widget child;

  /// Test hook — when `true`, shows the iOS aligned splash overlay.
  final bool Function() showIosOverlay;

  /// Injectable for tests — defaults to [FlutterNativeSplash.remove].
  final VoidCallback removeNativeSplash;

  /// Test hook — called after [removeNativeSplash].
  final VoidCallback? onNativeSplashRemoved;

  /// Test hook — called when the iOS overlay is hidden (not used on Android).
  final VoidCallback? onOverlayHidden;

  static bool _defaultShowIosOverlay() =>
      defaultTargetPlatform == TargetPlatform.iOS;

  @override
  State<ReflectLaunchOverlay> createState() => _ReflectLaunchOverlayState();
}

class _ReflectLaunchOverlayState extends State<ReflectLaunchOverlay> {
  late final bool _useIosOverlay;
  var _showOverlay = false;
  var _nativeRemoved = false;

  @override
  void initState() {
    super.initState();
    _useIosOverlay = widget.showIosOverlay();
    _showOverlay = _useIosOverlay;
    WidgetsBinding.instance.addPostFrameCallback((_) => _afterFirstFrame());
  }

  void _afterFirstFrame() {
    if (!mounted) return;

    if (_useIosOverlay) {
      _removeNativeOnce();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        setState(() => _showOverlay = false);
        widget.onOverlayHidden?.call();
      });
      return;
    }

    _removeNativeOnce();
  }

  void _removeNativeOnce() {
    if (_nativeRemoved) return;
    _nativeRemoved = true;
    widget.removeNativeSplash();
    widget.onNativeSplashRemoved?.call();
  }

  @override
  Widget build(BuildContext context) {
    if (!_useIosOverlay || !_showOverlay) {
      return widget.child;
    }

    return Stack(
      fit: StackFit.passthrough,
      children: [
        widget.child,
        Positioned.fill(
          child: ColoredBox(
            color: ReflectColors.paper,
            child: Image.asset(
              ReflectLaunchOverlay._splashAsset,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }
}
