import 'package:flutter/material.dart';
import 'package:womanly_mobile/presentation/theme/theme_colors.dart';

class CloseDialogButton extends StatelessWidget {
  final Color color;
  final VoidCallback? onPressed;
  const CloseDialogButton({
    this.color = ThemeColors.accentBlue,
    this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: GestureDetector(
        onTap: () {
          onPressed?.call();
          Navigator.pop(context);
        },
        child: Container(
          color: Colors.transparent,
          child: Container(
            width: 28,
            height: 28,
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color,
            ),
            child: Center(
              child: Image.asset(
                "assets/images/icons/cross.png",
                width: 10.5,
                height: 10.5,
                // fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
