import 'package:flutter/material.dart';
import 'package:womanly_mobile/domain/entities/book.dart';
import 'package:womanly_mobile/presentation/misc/analytics/analytics.dart';
import 'package:womanly_mobile/presentation/misc/analytics/analytics_event.dart';
import 'package:womanly_mobile/presentation/misc/analytics/book_statistics.dart';
import 'package:womanly_mobile/presentation/misc/analytics/event_book_completed_totals_af.dart';
import 'package:womanly_mobile/presentation/misc/analytics/event_book_completed_uniques_af.dart';
import 'package:womanly_mobile/presentation/misc/analytics/placement.dart';

class EventBookCompleted extends AnalyticsEvent {
  final BuildContext context;
  final Book book;
  EventBookCompleted(this.context, this.book) {
    Analytics.logEventOnce(EventBookCompletedUniquesAF(),
        AnalyticsOnceKey.eventBookCompletedUniquesAF);
    Analytics.logEvent(EventBookCompletedTotalsAF());
  }

  @override
  String get eventName => 'book_completed';

  @override
  Map<String, dynamic>? get eventProperties => {
        keyPlacement: Placement.getLastPlacementForBook(context, book),
        ...bookProperties(context, book),
        "duration": BookStatistics.playTimeMinutes(book),
        "unique_days": BookStatistics.playTimeDays(book),
        "book_number": bookNumberForInstance(context),
      };
}
