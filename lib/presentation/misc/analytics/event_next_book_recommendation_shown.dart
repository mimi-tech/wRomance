import 'package:flutter/material.dart';
import 'package:womanly_mobile/domain/entities/book.dart';
import 'package:womanly_mobile/presentation/misc/analytics/analytics_event.dart';

class EventNextBookRecommendationShown extends AnalyticsEvent {
  final Book book;
  final BuildContext context;
  EventNextBookRecommendationShown(this.context, this.book);

  @override
  String get eventName => 'next_book_recommendation_shown';

  @override
  Map<String, dynamic>? get eventProperties => bookProperties(context, book);
}
