import 'dart:ui';
import 'package:flutter/material.dart';

/// A wrapper widget that provides a prominent "frosted glass" effect beneath its child.
/// Designed to be used as a floating footer or sticky bar
/// to blur obscured content and maintain focus on action buttons.
class GlassFAB extends StatelessWidget {
  const GlassFAB({
    super.key,
    required this.child,
    this.blurSigma = 18.0,
    this.borderRadius = const BorderRadius.all(Radius.circular(32.0)),
    this.padding = const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
  });

  final Widget child;
  final double blurSigma;
  final BorderRadius borderRadius;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Stack(
      children: [
        Positioned.fill(
          child: ClipRRect(
            borderRadius: borderRadius,
            child: ShaderMask(
              shaderCallback: (Rect bounds) {
                return const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.white38,
                    Colors.white,
                  ],
                  stops: [0.2, 0.6, 1.0], // Non-existent at top, smooth taper down
                ).createShader(bounds);
              },
              blendMode: BlendMode.dstIn,
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: borderRadius,
                    border: Border.all(
                      color: Colors.transparent,
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        colorScheme.surface.withValues(alpha: 0.1),
                        colorScheme.surface.withValues(alpha: 0.4),
                      ],
                      stops: const [0.2, 0.6, 1.0],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: padding,
          child: Align(
            alignment: Alignment.center,
            heightFactor: 1.0,
            child: child,
          ),
        ),
      ],
    );
  }
}
