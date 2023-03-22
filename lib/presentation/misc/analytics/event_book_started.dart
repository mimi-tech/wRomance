import 'package:flutter/material.dart';
import 'package:womanly_mobile/domain/entities/book.dart';
import 'package:womanly_mobile/presentation/misc/analytics/analytics_event.dart';
import 'package:womanly_mobile/presentation/misc/analytics/placement.dart';

class EventBookStarted extends AnalyticsEvent {
  final Book book;
  final BuildContext context;
  EventBookStarted(this.context, this.book);

  @override
  String get eventName => 'book_started';

  @override
  Map<String, dynamic>? get eventProperties => {
        keyTabName: tabName,
        keyPlacement: Placement.getLastPlacementForBook(context, book),
        ...bookProperties(context, book),
        "book_number": bookNumberForInstance(context),
      };
}
