import 'package:flutter/material.dart';
import 'package:womanly_mobile/presentation/theme/theme_colors.dart';

class TopShadow extends StatelessWidget {
  const TopShadow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              ThemeColors.accentBackground.withOpacity(1.0),
              ThemeColors.accentBackground.withOpacity(0),
            ],
            stops: const [0.1, 1.0],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
      ),
    );
  }
}
