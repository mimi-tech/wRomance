import 'dart:math';

import 'package:flutter/material.dart';
import 'package:womanly_mobile/presentation/theme/theme_colors.dart';

class PressButton extends StatefulWidget {
  final Widget child;
  final VoidCallback onPressed;
  final Color? color;
  final bool noisyGradientStyle;
  final bool borderedStyle;
  final double? specialHeight;
  final bool allowShadow;
  final bool forRecommendationScreen;
  const PressButton({
    required this.child,
    required this.onPressed,
    this.color,
    this.noisyGradientStyle = false,
    this.borderedStyle = false,
    this.specialHeight,
    this.allowShadow = true,
    this.forRecommendationScreen = false,
    Key? key,
  }) : super(key: key);

  static const height = 55.0;

  @override
  State<PressButton> createState() => _PressButtonState();
}

class _PressButtonState extends State<PressButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      onTapDown: (_) {
        setState(() {
          _isPressed = true;
        });
      },
      onTapUp: (_) {
        setState(() {
          _isPressed = false;
        });
      },
      child: Container(
        margin: EdgeInsets.only(top: _isPressed ? 0.5 : 0),
        // width: screenWidth - 32,
        height: widget.specialHeight ?? PressButton.height,
        decoration: BoxDecoration(
          color: (widget.noisyGradientStyle || widget.borderedStyle)
              ? const Color(0xFF0A142A)
              : widget.color ?? ThemeColors.accentBlueButtons,
          borderRadius:
              BorderRadius.all(Radius.circular(widget.borderedStyle ? 8 : 10)),
          border: widget.borderedStyle || widget.forRecommendationScreen
              ? Border.all(
                  color: ThemeColors.accentBlueTextTabActive,
                  width: 1,
                )
              : null,
          image: (widget.noisyGradientStyle && !widget.borderedStyle)
              ? const DecorationImage(
                  image: AssetImage("assets/images/listen_button_gradient.png"),
                  fit: BoxFit.cover,
                )
              : null,
          boxShadow: widget.allowShadow
              ? const [
                  BoxShadow(
                      color: Color(0x80020D21),
                      // color: Colors.red,
                      spreadRadius: 10,
                      blurRadius: 44,
                      offset: Offset(0, 15))
                ]
              : null,
        ),
        child: Padding(
          padding: EdgeInsets.only(top: _isPressed ? 1 : 0),
          child: widget.child,
        ),
      ),
    );
  }
}
