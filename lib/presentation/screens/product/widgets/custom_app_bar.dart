import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:womanly_mobile/presentation/common/widgets/autoscroll_text.dart';
import 'package:womanly_mobile/presentation/common/widgets/ios_background_blur.dart';
import 'package:womanly_mobile/presentation/screens/product/product_state.dart';
import 'package:womanly_mobile/presentation/theme/theme_colors.dart';
import 'package:womanly_mobile/presentation/theme/theme_text_style.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  const CustomAppBar({
    required this.title,
    Key? key,
  }) : super(key: key);
  static const duration = Duration(milliseconds: 300);

  @override
  Widget build(BuildContext context) {
    final paddingTop = MediaQuery.of(context).padding.top;
    final isOpaque =
        context.select<ProductState, bool>((state) => state.isAppBarOpaque);

    return Align(
      alignment: Alignment.topLeft,
      child: AnimatedOpacity(
        opacity: isOpaque ? 1 : 0,
        duration: duration,
        child: Container(
          height: 56 + paddingTop,
          clipBehavior: Clip.hardEdge,
          decoration: const BoxDecoration(),
          child: IOSBackgroundBlur(
            baseColor: ThemeColors.accentBackground,
            child: Container(
              width: double.infinity,
              height: 56 + paddingTop,
              padding: EdgeInsets.only(top: paddingTop, left: 56, right: 56),
              alignment: Alignment.center,
              // color: const Color(0xFF11203B).withOpacity(0.5),
              color: ThemeColors.accentBackground.withOpacity(0.86),
              child: AutoscrollText(
                title,
                textAlign: TextAlign.center,
                style: ThemeTextStyle.s18w700.copyWith(
                  color: const Color(0xFFFFFFFF),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
