import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:womanly_mobile/domain/data_repository.dart';
import 'package:womanly_mobile/domain/entities/book.dart';
import 'package:womanly_mobile/domain/library_state.dart';
import 'package:womanly_mobile/presentation/misc/analytics/analytics.dart';
import 'package:womanly_mobile/presentation/misc/analytics/event_read_later.dart';
import 'package:womanly_mobile/presentation/misc/extensions.dart';
import 'package:womanly_mobile/presentation/theme/theme_colors.dart';
import 'package:womanly_mobile/presentation/theme/theme_text_style.dart';

import 'package:app_tracking_transparency/app_tracking_transparency.dart';

enum MyListButtonStyle {
  normal,
  tiny,
  newProduct,
  recommendations,
}

class MyListButton extends StatelessWidget {
  final MyListButtonStyle _style;
  final Book book;
  const MyListButton._(this._style, this.book, {Key? key}) : super(key: key);

  factory MyListButton.normal(Book book) =>
      MyListButton._(MyListButtonStyle.normal, book);
  factory MyListButton.tiny(Book book) =>
      MyListButton._(MyListButtonStyle.tiny, book);
  factory MyListButton.newProduct(Book book) =>
      MyListButton._(MyListButtonStyle.newProduct, book);
  factory MyListButton.recommendations(Book book) =>
      MyListButton._(MyListButtonStyle.recommendations, book);

  @override
  Widget build(BuildContext context) {
    // final bool _newProduct = newProduct &&
    //     context.router.currentSegments.last.args is ProductRouteArgs;

    return GestureDetector(
      onTap: () async {
        if (!book.isEnabledSharingAndListening(context)) {
          return;
        }
        if (context.read<LibraryState>().myList.contains(book)) {
          Analytics.logEvent(EventReadLater(context, book,
              context.read<DataRepository>().getSeries(book), false));
          context.read<LibraryState>().removeFromMyList(book);
        } else {
// If the system can show an authorization request dialog
          if (await AppTrackingTransparency.trackingAuthorizationStatus ==
              TrackingStatus.notDetermined) {
            // Show a custom explainer dialog before the system dialog
            // await showCustomTrackingDialog(context);
            // Wait for dialog popping animation
            await Future.delayed(const Duration(milliseconds: 200));
            // Request system's tracking authorization dialog
            await AppTrackingTransparency.requestTrackingAuthorization();
          }

          Analytics.logEvent(EventReadLater(context, book,
              context.read<DataRepository>().getSeries(book), true));
          context.read<LibraryState>().addToMyList(book);
        }
      },
      child: Opacity(
        opacity: book.isEnabledSharingAndListening(context) ? 1.0 : 0.5,
        child: Container(
            color: Colors.transparent, //essential for tap area
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(children: [
                Container(
                  width: _sizeContainer(),
                  height: _sizeContainer(),
                  decoration: BoxDecoration(
                      color: _colorContainer(), shape: BoxShape.circle),
                  child: Center(
                    child: Image.asset(
                      context.select<LibraryState, bool>(
                              (state) => state.myList.contains(book))
                          ? 'assets/images/icons/iconCheck.png'
                          : 'assets/images/icons/addIcon2.png',
                      color: _colorIcon(),
                      width: _sizeIcon(),
                    ),
                  ),
                ),
                if (_style == MyListButtonStyle.normal)
                  const SizedBox(
                    height: 8,
                    width: 8,
                  ),
                if (_textVisible())
                  Text(
                    'My List',
                    style: ThemeTextStyle.s14w500.copyWith(
                      color: _colorIcon(),
                    ),
                  ),
              ]),
            )),
      ),
    );
  }

  bool _textVisible() {
    switch (_style) {
      case MyListButtonStyle.normal:
        return true;

      case MyListButtonStyle.tiny:
        return false;

      case MyListButtonStyle.newProduct:
        return false;

      case MyListButtonStyle.recommendations:
        return false;
    }
  }

  double _sizeContainer() {
    switch (_style) {
      case MyListButtonStyle.normal:
        return 42;

      case MyListButtonStyle.tiny:
        return 16;

      case MyListButtonStyle.newProduct:
        return 42;

      case MyListButtonStyle.recommendations:
        return 42;
    }
  }

  double _sizeIcon() {
    switch (_style) {
      case MyListButtonStyle.normal:
        return 18;

      case MyListButtonStyle.tiny:
        return 16;

      case MyListButtonStyle.newProduct:
        return 26;

      case MyListButtonStyle.recommendations:
        return 26;
    }
  }

  Color _colorContainer() {
    switch (_style) {
      case MyListButtonStyle.normal:
        return Colors.transparent;

      case MyListButtonStyle.tiny:
        return Colors.transparent;

      case MyListButtonStyle.newProduct:
        return ThemeColors.accentBackground;

      case MyListButtonStyle.recommendations:
        return ThemeColors.accentBackground.withOpacity(0.5);
    }
  }

  Color _colorIcon() {
    switch (_style) {
      case MyListButtonStyle.normal:
        return Colors.white;

      case MyListButtonStyle.tiny:
        return Colors.white;

      case MyListButtonStyle.newProduct:
        return ThemeColors.accentBlueTextTabActive;

      case MyListButtonStyle.recommendations:
        return ThemeColors.accentBlueTextTabActive;
    }
  }
}
