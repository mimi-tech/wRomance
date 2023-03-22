import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:womanly_mobile/presentation/screens/product/product_state.dart';
import 'package:womanly_mobile/presentation/theme/theme_colors.dart';

class PositionedSpotLight extends StatelessWidget {
  const PositionedSpotLight({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 400 - context.select<ProductState, double>((state) => state.offset),
      child: const SpotLight(),
    );
  }
}

class SpotLight extends StatelessWidget {
  const SpotLight({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        gradient: RadialGradient(
          colors: [
            ThemeColors.accentBackground2,
            ThemeColors.accentBackground2.withOpacity(0.2),
            ThemeColors.accentBackground2.withOpacity(0),
          ],
          stops: const [
            0,
            0.5,
            0.9,
          ],
          focal: Alignment.center,
          radius: 0.9,
        ),
      ),
    );
  }
}
