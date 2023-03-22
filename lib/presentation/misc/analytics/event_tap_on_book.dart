import 'package:flutter/material.dart';
import 'package:womanly_mobile/domain/entities/book.dart';
import 'package:womanly_mobile/presentation/misc/analytics/analytics.dart';
import 'package:womanly_mobile/presentation/misc/analytics/analytics_event.dart';
import 'package:womanly_mobile/presentation/misc/analytics/event_3taps_on_book_af.dart';

class EventTapOnBook extends AnalyticsEvent {
  final Book book;
  final BuildContext context;
  EventTapOnBook(this.context, this.book) {
    Analytics.logEvent(Event3TapsOnBookAF(context));
  }

  @override
  String get eventName => 'tap_on_book';

  @override
  Map<String, dynamic>? get eventProperties {
    final _placement = placement(context);
    return {
      keyTabName: tabName,
      keyPlacement: _placement,
      ...bookProperties(context, book, _placement),
      "book_number": bookNumberForInstanceUnique(context, book.id),
    };
  }
}
