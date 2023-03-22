import 'package:flutter/material.dart';
import 'package:womanly_mobile/domain/entities/book.dart';
import 'package:womanly_mobile/presentation/misc/analytics/analytics_event.dart';

class EventBookShare extends AnalyticsEvent {
  final BuildContext context;
  final Book book;
  final String action;
  final String from;

  EventBookShare({
    required this.context,
    required this.book,
    required this.action,
    required this.from,
  });

  @override
  String get eventName => 'book_share';

  @override
  Map<String, dynamic>? get eventProperties => {
        "action": action,
        "from": from,
        keyPlacement: placement(context),
        ...bookProperties(context, book),
      };
}
