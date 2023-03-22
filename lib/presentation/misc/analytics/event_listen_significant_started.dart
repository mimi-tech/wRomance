import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:womanly_mobile/domain/entities/book.dart';
import 'package:womanly_mobile/presentation/misc/analytics/analytics.dart';
import 'package:womanly_mobile/presentation/misc/analytics/analytics_event.dart';
import 'package:womanly_mobile/presentation/misc/analytics/event_t_nbrec_listen_significant_started.dart';
import 'package:womanly_mobile/presentation/misc/analytics/event_t_sexquiz_listen_significant_started.dart';
import 'package:womanly_mobile/presentation/misc/analytics/placement.dart';

class EventListenSignificantStarted extends AnalyticsEvent {
  static const eventNameListenSignificantStarted = 'listen_significant_started';

  final BuildContext context;
  final Book book;
  late final _placement = Placement.getLastPlacementForBook(context, book);
  EventListenSignificantStarted(this.context, this.book) {
    if (_placement == "next_book_recommendation" &&
        eventName == eventNameListenSignificantStarted) {
      Analytics.logEventOnce(
        EventTransitionalNextBookRecommendationListenSignificantStarted(
            context, book),
        AnalyticsOnceKey.eventTNBRecListenSignificantStarted,
        suffix: book.id,
      );
    }
    if (_placement == "sexuality_quiz" &&
        eventName == eventNameListenSignificantStarted) {
      Analytics.logEventOnce(
        EventTransitionalSexQuizListenSignificantStarted(context, book),
        AnalyticsOnceKey.eventTSexQuizListenSignificantStarted,
        suffix: book.id,
      );
    }
  }

  @override
  String get eventName => eventNameListenSignificantStarted;

  @override
  Map<String, dynamic>? get eventProperties {
    return {
      keyTabName: tabName,
      keyPlacement: _placement,
      ...bookProperties(context, book),
      "book_number": bookNumberForInstance(context),
    };
  }

  @override
  bool get allowedForAppsFlyer => true;
}
