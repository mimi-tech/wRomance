import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:womanly_mobile/domain/entities/book.dart';
import 'package:womanly_mobile/domain/entities/enums/featured_style.dart';
import 'package:womanly_mobile/domain/entities/enums/featured_type.dart';
import 'package:womanly_mobile/presentation/common/widgets/book_cover.dart';
import 'package:womanly_mobile/presentation/misc/config/remote_config.dart';
import 'package:womanly_mobile/presentation/misc/expiration_timer/expiration_timer_settings.dart';
import 'package:womanly_mobile/presentation/misc/extensions.dart';

class Featured {
  final String title;
  final FeaturedType type;
  final List<Book> books;
  final FeaturedStyle style;
  final List<String> trops;
  final dynamic customData;

  Featured(
    this.title,
    this.books,
    this.style, {
    this.type = FeaturedType.books,
    this.trops = const [],
    this.customData,
  });

  double additionalHeightForExpirationTimer(
          BuildContext context, ExpirationTimerSettings settings) =>
      hasExpirationTimerForAnyBook(context) ? settings.height : 0;

  bool hasExpirationTimerForAnyBook(BuildContext context) => books.any((it) =>
      it.expirationTimerDays(context.read<SharedPreferences>()) != null);

  /// This method indicates if the featured should be styled differently.
  /// 'Free' means that books included are free to read, we don't ask
  /// users to pay for them.
  bool get isFreeMarker {
    return RemoteConfig.isFreeUpExperiment2Enabled
        ? false
        : style == FeaturedStyle.mediumAndRedButton;
  }
}
