import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:womanly_mobile/presentation/theme/theme_colors.dart';

class ThemeSceleton extends StatelessWidget {
  final Widget? child;
  const ThemeSceleton({this.child, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: ThemeColors.accentBackground2,
      highlightColor: const Color(0xFF274173).withOpacity(0.53),
      child: child ??
          Container(
            decoration: const BoxDecoration(
              color: ThemeColors.accentBackground2,
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
          ),
    );
  }

  static Widget fromWHR(double width, double height, double radius) {
    return ThemeSceleton(
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: ThemeColors.accentBackground2,
          borderRadius: BorderRadius.all(
            Radius.circular(radius),
          ),
        ),
      ),
    );
  }
}
