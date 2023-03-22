import 'package:flutter/material.dart';
import 'package:womanly_mobile/presentation/theme/theme_colors.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 0.5,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Colors.transparent,
            ThemeColors.accentBlueButtons,
            ThemeColors.accentBlueButtons,
            Colors.transparent
          ],
        ),
      ),
    );
  }
}
