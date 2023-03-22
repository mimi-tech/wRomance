import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:womanly_mobile/domain/entities/book.dart';
import 'package:womanly_mobile/domain/library_state.dart';
import 'package:womanly_mobile/presentation/misc/analytics/analytics.dart';
import 'package:womanly_mobile/presentation/misc/analytics/analytics_event.dart';
import 'package:womanly_mobile/presentation/misc/analytics/book_statistics.dart';
import 'package:womanly_mobile/presentation/misc/analytics/event_t_nbrec_listen_started.dart';
import 'package:womanly_mobile/presentation/misc/analytics/event_t_sexquiz_listen_started.dart';
import 'package:womanly_mobile/presentation/misc/analytics/placement.dart';

class EventListenStarted extends AnalyticsEvent {
  static const eventNameListenStarted = 'listen_started';

  final BuildContext context;
  final Book book;
  late final _placement = Placement.getLastPlacementForBook(context, book);
  EventListenStarted(this.context, this.book) {
    if (_placement == "next_book_recommendation" &&
        eventName == eventNameListenStarted) {
      Analytics.logEvent(
          EventTransitionalNextBookRecommendationListenStarted(context, book));
    }
    if (_placement == "sexuality_quiz" && eventName == eventNameListenStarted) {
      Analytics.logEvent(EventTransitionalSexQuizListenStarted(context, book));
    }
  }

  @override
  String get eventName => eventNameListenStarted;

  @override
  Map<String, dynamic>? get eventProperties => {
        keyTabName: tabName,
        keyPlacement: _placement,
        ...bookProperties(context, book),
        "chapter": book
            .chapters[context.read<LibraryState>().currentChapterIndex ?? 0].id,
        "chapter_completeness":
            BookStatistics.getChapterCompleteness(context, book, force: true),
      };

  @override
  bool get allowedForAppsFlyer => true;
}
