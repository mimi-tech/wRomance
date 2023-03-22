import 'package:flutter/material.dart';
import 'package:womanly_mobile/presentation/theme/theme_text_style.dart';

class FeaturedTitle extends StatelessWidget {
  final String text;
  const FeaturedTitle(this.text, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Text(
            text,
            style: ThemeTextStyle.s19w700.copyWith(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
