import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:womanly_mobile/domain/entities/book.dart';
import 'package:womanly_mobile/main.dart';
import 'package:womanly_mobile/presentation/misc/analytics/analytics.dart';
import 'package:womanly_mobile/presentation/misc/analytics/analytics_event.dart';
import 'package:womanly_mobile/presentation/misc/analytics/event_first_purchase_af.dart';
import 'package:womanly_mobile/presentation/misc/analytics/event_purchase_af.dart';
import 'package:womanly_mobile/presentation/misc/analytics/event_second_purchase_af.dart';
import 'package:womanly_mobile/presentation/misc/analytics/override_properties.dart';

class EventBookPurchased extends AnalyticsEvent {
  final String _placement;
  final Book book;
  final BuildContext context;
  EventBookPurchased(
    this._placement,
    this.context,
    this.book, {
    required double price,
  }) {
    _bookNumber = bookNumberForInstance(context);

    if (price > 0 && !isTestEnvironment()) {
      Analytics.logRevenue(book.name, price);
      Analytics.logEvent(EventPurchaseAF(book, price));

      Analytics.logEventOnce(
        EventFirstPurchaseAF(context, book),
        AnalyticsOnceKey.firstPurchaseAF,
      );

      if (_bookNumber == 2) {
        Analytics.logEventOnce(
          EventSecondPurchaseAF(),
          AnalyticsOnceKey.secondPurchaseAF,
        );
      }
    }
  }

  int _bookNumber = 0;

  @override
  String get eventName => 'book_purchased';

  @override
  Map<String, dynamic>? get eventProperties => {
        keyPlacement: _placement,
        ...bookProperties(context, book, _placement),
        "books_purchased": _bookNumber,
      };
}
