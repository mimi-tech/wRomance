import 'package:flutter/material.dart';
import 'package:womanly_mobile/domain/entities/book.dart';
import 'package:womanly_mobile/presentation/misc/analytics/analytics_event.dart';

class EventNextBookRecommendationClosed extends AnalyticsEvent {
  final Book book;
  final BuildContext context;
  EventNextBookRecommendationClosed(this.context, this.book);

  @override
  String get eventName => 'next_book_recommendation_closed';

  @override
  Map<String, dynamic>? get eventProperties => bookProperties(context, book);
}
