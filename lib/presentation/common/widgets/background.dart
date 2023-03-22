import 'package:flutter/material.dart';
import 'package:womanly_mobile/presentation/theme/theme_colors.dart';

class Background extends StatelessWidget {
  final Widget child;
  const Background({required this.child, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ThemeColors.accentBackground,
      child: Stack(children: [
        RepaintBoundary(
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Image.asset(
              "assets/images/common_bg.jpg",
              fit: BoxFit.fill,
            ),
          ),
        ),
        child,
      ]),
    );
  }
}
