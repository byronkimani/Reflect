import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppLoadingIndicator extends StatelessWidget {
  final Color? color;
  final double radius;

  const AppLoadingIndicator({super.key, this.color, this.radius = 15.0});

  @override
  Widget build(BuildContext context) {
    final platform = Theme.of(context).platform;
    final isApple =
        platform == TargetPlatform.iOS || platform == TargetPlatform.macOS;

    if (isApple) {
      return CupertinoActivityIndicator(color: color, radius: radius);
    }

    return SizedBox(
      height: radius * 2,
      width: radius * 2,
      child: CircularProgressIndicator(color: color, strokeWidth: 2.5),
    );
  }
}
