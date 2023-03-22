import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:womanly_mobile/domain/entities/book.dart';
import 'package:womanly_mobile/presentation/misc/analytics/analytics.dart';
import 'package:womanly_mobile/presentation/misc/analytics/event_tap_on_book_share.dart';
import 'package:womanly_mobile/presentation/misc/analytics/placement.dart';
import 'package:womanly_mobile/presentation/misc/config/new_design.dart';
import 'package:womanly_mobile/presentation/misc/extensions.dart';
import 'package:womanly_mobile/presentation/misc/log.dart';
import 'package:womanly_mobile/presentation/theme/theme_colors.dart';
import 'package:womanly_mobile/presentation/theme/theme_text_style.dart';

class ShareButton extends StatelessWidget {
  final Book book;
  final bool withLabel;
  final String from;
  final bool ajustColor;
  const ShareButton(
    this.book, {
    this.withLabel = true,
    required this.from,
    required this.ajustColor,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = book.debugIsDarkPlayerControls && ajustColor;
    final bool _newProduct = newProduct;

    return GestureDetector(
      onTap: () {
        Log.dialog(context, "Share book");
      },
      child: Opacity(
        opacity: book.isEnabledSharingAndListening(context) ? 1.0 : 0.5,
        child: Container(
            color: Colors.transparent, //essential for tap area
            child: Padding(
              padding: EdgeInsets.fromLTRB(8, withLabel ? 8 : 8, 8, 8),
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                Container(
                  width: _newProduct ? 42 : null,
                  height: _newProduct ? 42 : null,
                  decoration: BoxDecoration(
                      color: _newProduct
                          ? ThemeColors.accentBackground
                          : Colors.transparent,
                      shape: BoxShape.circle),
                  child: Center(
                    child: Image.asset(
                      'assets/images/icons/shareIcon.png',
                      width: _newProduct
                          ? 30
                          : withLabel
                              ? 24
                              : 32,
                      height: _newProduct
                          ? 30
                          : withLabel
                              ? 24
                              : 32,
                      color: isDark
                          ? Colors.black
                          : _newProduct
                              ? ThemeColors.accentBlueTextTabActive
                              : Colors.white,
                    ),
                  ),
                ),
                if (withLabel && !newProduct) const SizedBox(height: 8),
                if (withLabel && !_newProduct)
                  Text(
                    'Share',
                    style: ThemeTextStyle.s14w500.copyWith(
                      color: Colors.white,
                    ),
                  ),
              ]),
            )),
      ),
    );
  }
}
