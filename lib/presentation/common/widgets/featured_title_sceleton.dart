import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:womanly_mobile/presentation/theme/theme_colors.dart';
import 'package:womanly_mobile/presentation/theme/theme_sceleton.dart';
import 'package:womanly_mobile/presentation/theme/theme_text_style.dart';

class FeaturedTitleSceleton extends StatelessWidget {
  const FeaturedTitleSceleton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ThemeSceleton(
        child: Align(
          alignment: Alignment.centerLeft,
          child: Container(
            width: 200,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(100)),
              color: Colors.white,
            ),
            child: Text(
              " ",
              style: ThemeTextStyle.s19w700,
            ),
          ),
        ),
      ),
    );
  }
}
