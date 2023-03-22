import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';

class IOSBackgroundBlur extends StatelessWidget {
  final Widget child;
  final double blur;
  final Color baseColor;
  const IOSBackgroundBlur({
    Key? key,
    required this.child,
    this.blur = 10,
    required this.baseColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // if (!Platform.isIOS) {
    //   return Container(
    //     color: baseColor,
    //     child: child,
    //   );
    // }

    return BackdropFilter(
      filter: ImageFilter.blur(
        sigmaX: blur,
        sigmaY: blur,
      ),
      child: child,
    );
  }
}
