import 'package:flutter/material.dart';
import 'package:resize/resize.dart';

class ThemeTextStyle {
  static double get debugFontSizeDelta => 0;
  static bool isTextScaled = true;

  static const fontFamily = "Manrope";
  static const merriweather = "Merriweather";

  static double _getFontSize(double origin) {
    final ref = origin + debugFontSizeDelta;
    return isTextScaled ? ref.sp : ref;
  }

  static TextStyle get s32w900 => TextStyle(
        fontFamily: fontFamily,
        fontSize: _getFontSize(32),
        fontWeight: FontWeight.w900,
      );

  static TextStyle get s28w800 => TextStyle(
        fontFamily: fontFamily,
        fontSize: _getFontSize(28),
        fontWeight: FontWeight.w800,
      );

  static TextStyle get s28w700 => TextStyle(
        fontFamily: fontFamily,
        fontSize: _getFontSize(28),
        fontWeight: FontWeight.w700,
      );

  static TextStyle get s26w900 => TextStyle(
        fontFamily: fontFamily,
        fontSize: _getFontSize(26),
        fontWeight: FontWeight.w900,
      );

  static TextStyle get s24w900 => TextStyle(
        fontFamily: fontFamily,
        fontSize: _getFontSize(24),
        fontWeight: FontWeight.w900,
      );

  static TextStyle get s24w700 => TextStyle(
        fontFamily: fontFamily,
        fontSize: _getFontSize(24),
        fontWeight: FontWeight.w700,
      );

  static TextStyle get s24w600 => TextStyle(
        fontFamily: fontFamily,
        fontSize: _getFontSize(24),
        fontWeight: FontWeight.w600,
      );

  static TextStyle get s24w400 => TextStyle(
        fontFamily: fontFamily,
        fontSize: _getFontSize(24),
        fontWeight: FontWeight.w400,
      );

  static TextStyle get s22w700 => TextStyle(
        fontFamily: fontFamily,
        fontSize: _getFontSize(22),
        fontWeight: FontWeight.w700,
      );

  static TextStyle get s20w700 => TextStyle(
        fontFamily: fontFamily,
        fontSize: _getFontSize(20),
        fontWeight: FontWeight.w700,
      );

  static TextStyle get s20w500 => TextStyle(
        fontFamily: fontFamily,
        fontSize: _getFontSize(20),
        fontWeight: FontWeight.w500,
      );

  static TextStyle get s20w400 => TextStyle(
        fontFamily: fontFamily,
        fontSize: _getFontSize(20),
        fontWeight: FontWeight.w400,
      );

  static TextStyle get s19w800 => TextStyle(
        fontFamily: fontFamily,
        fontSize: _getFontSize(19),
        fontWeight: FontWeight.w800,
      );

  static TextStyle get s19w700 => TextStyle(
        fontFamily: fontFamily,
        fontSize: _getFontSize(19),
        fontWeight: FontWeight.w700,
      );

  static TextStyle get s19w600 => TextStyle(
        fontFamily: fontFamily,
        fontSize: _getFontSize(19),
        fontWeight: FontWeight.w600,
      );

  static TextStyle get s19w400 => TextStyle(
        fontFamily: fontFamily,
        fontSize: _getFontSize(19),
        fontWeight: FontWeight.w400,
      );

  static TextStyle get s18w700 => TextStyle(
        fontFamily: fontFamily,
        fontSize: _getFontSize(18),
        fontWeight: FontWeight.w700,
      );

  static TextStyle get s18w600 => TextStyle(
        fontFamily: fontFamily,
        fontSize: _getFontSize(18),
        fontWeight: FontWeight.w600,
      );

  static TextStyle get s18w400 => TextStyle(
        fontFamily: fontFamily,
        fontSize: _getFontSize(18),
        fontWeight: FontWeight.w400,
      );

  static TextStyle get s17w700 => TextStyle(
        fontFamily: fontFamily,
        fontSize: _getFontSize(17),
        fontWeight: FontWeight.w700,
      );

  static TextStyle get s17w600 => TextStyle(
        fontFamily: fontFamily,
        fontSize: _getFontSize(17),
        fontWeight: FontWeight.w600,
      );

  static TextStyle get s17w400 => TextStyle(
        fontFamily: fontFamily,
        fontSize: _getFontSize(17),
        fontWeight: FontWeight.w400,
      );

  static TextStyle get s16w700 => TextStyle(
        fontFamily: fontFamily,
        fontSize: _getFontSize(16),
        fontWeight: FontWeight.w700,
      );

  static TextStyle get s16w500 => TextStyle(
        fontFamily: fontFamily,
        fontSize: _getFontSize(16),
        fontWeight: FontWeight.w500,
      );

  static TextStyle get s16w600 => TextStyle(
        fontFamily: fontFamily,
        fontSize: _getFontSize(16),
        fontWeight: FontWeight.w600,
      );

  static TextStyle get s16w400 => TextStyle(
        fontFamily: fontFamily,
        fontSize: _getFontSize(16),
        fontWeight: FontWeight.w400,
      );

  static TextStyle get s15w700 => TextStyle(
        fontFamily: fontFamily,
        fontSize: _getFontSize(15),
        fontWeight: FontWeight.w700,
      );

  static TextStyle get s15w600 => TextStyle(
        fontFamily: fontFamily,
        fontSize: _getFontSize(15),
        fontWeight: FontWeight.w600,
      );

  static TextStyle get s15w500 => TextStyle(
        fontFamily: fontFamily,
        fontSize: _getFontSize(15),
        fontWeight: FontWeight.w500,
      );

  static TextStyle get s15w400 => TextStyle(
        fontFamily: fontFamily,
        fontSize: _getFontSize(15),
        fontWeight: FontWeight.w400,
      );

  static TextStyle get s15w300 => TextStyle(
        fontFamily: fontFamily,
        fontSize: _getFontSize(15),
        fontWeight: FontWeight.w300,
      );

  static TextStyle get s14w600 => TextStyle(
        fontFamily: fontFamily,
        fontSize: _getFontSize(14),
        fontWeight: FontWeight.w600,
      );

  static TextStyle get s14w500 => TextStyle(
        fontFamily: fontFamily,
        fontSize: _getFontSize(14),
        fontWeight: FontWeight.w500,
      );

  static TextStyle get s14w400 => TextStyle(
        fontFamily: fontFamily,
        fontSize: _getFontSize(14),
        fontWeight: FontWeight.w400,
      );

  static TextStyle get s14w300 => TextStyle(
        fontFamily: fontFamily,
        fontSize: _getFontSize(14),
        fontWeight: FontWeight.w300,
      );

  static TextStyle get s14w200 => TextStyle(
        fontFamily: fontFamily,
        fontSize: _getFontSize(14),
        fontWeight: FontWeight.w200,
      );

  static TextStyle get s13w800 => TextStyle(
        fontFamily: fontFamily,
        fontSize: _getFontSize(13),
        fontWeight: FontWeight.w800,
      );

  static TextStyle get s13w600 => TextStyle(
        fontFamily: fontFamily,
        fontSize: _getFontSize(13),
        fontWeight: FontWeight.w600,
      );

  static TextStyle get s13w500 => TextStyle(
        fontFamily: fontFamily,
        fontSize: _getFontSize(13),
        fontWeight: FontWeight.w500,
      );

  static TextStyle get s13w400 => TextStyle(
        fontFamily: fontFamily,
        fontSize: _getFontSize(13),
        fontWeight: FontWeight.w400,
      );

  static TextStyle get s12w600 => TextStyle(
        fontFamily: fontFamily,
        fontSize: _getFontSize(12),
        fontWeight: FontWeight.w600,
      );

  static TextStyle get s12w500 => TextStyle(
        fontFamily: fontFamily,
        fontSize: _getFontSize(12),
        fontWeight: FontWeight.w500,
      );

  static TextStyle get s12w400 => TextStyle(
        fontFamily: fontFamily,
        fontSize: _getFontSize(12),
        fontWeight: FontWeight.w400,
      );

  static TextStyle get s11w600 => TextStyle(
        fontFamily: fontFamily,
        fontSize: _getFontSize(11),
        fontWeight: FontWeight.w600,
      );

  static TextStyle get s11w500 => TextStyle(
        fontFamily: fontFamily,
        fontSize: _getFontSize(11),
        fontWeight: FontWeight.w500,
      );

  static TextStyle get s11w400 => TextStyle(
        fontFamily: fontFamily,
        fontSize: _getFontSize(11),
        fontWeight: FontWeight.w400,
      );

  static TextStyle get s10w700 => TextStyle(
        fontFamily: fontFamily,
        fontSize: _getFontSize(10),
        fontWeight: FontWeight.w700,
      );

  static TextStyle get s10w600 => TextStyle(
        fontFamily: fontFamily,
        fontSize: _getFontSize(10),
        fontWeight: FontWeight.w600,
      );

  static TextStyle get s10w400 => TextStyle(
        fontFamily: fontFamily,
        fontSize: _getFontSize(10),
        fontWeight: FontWeight.w400,
      );

  static TextStyle get s9w700 => TextStyle(
        fontFamily: fontFamily,
        fontSize: _getFontSize(9),
        fontWeight: FontWeight.w700,
      );

  static TextStyle get s9w500 => TextStyle(
        fontFamily: fontFamily,
        fontSize: _getFontSize(9),
        fontWeight: FontWeight.w500,
      );

  static TextStyle get s8w600 => TextStyle(
        fontFamily: fontFamily,
        fontSize: _getFontSize(8),
        fontWeight: FontWeight.w600,
      );

  static TextStyle get s8w400 => TextStyle(
        fontFamily: fontFamily,
        fontSize: _getFontSize(8),
        fontWeight: FontWeight.w400,
      );
}
