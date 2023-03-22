import 'package:flutter/material.dart';
import 'package:womanly_mobile/domain/entities/book.dart';
import 'package:womanly_mobile/presentation/misc/analytics/analytics_event.dart';

class EventWelcomeGiftActivated extends AnalyticsEvent {
  final Book book;
  final BuildContext context;
  EventWelcomeGiftActivated(
    this.context,
    this.book,
  );

  @override
  String get eventName => 'welcome_gift_activated';

  @override
  Map<String, dynamic>? get eventProperties => {
        ...bookProperties(context, book),
        "book_number": 1,
      }..addAll({
          "price_final": 0,
          "t_gifted_book": "yes",
          "offer_applied": "no",
        });
}
