import 'package:flutter/material.dart';
import 'package:womanly_mobile/domain/entities/book.dart';
import 'package:womanly_mobile/presentation/misc/analytics/analytics_event.dart';
import 'package:womanly_mobile/presentation/misc/analytics/placement.dart';

class EventTapOnBookShare extends AnalyticsEvent {
  final Book book;
  final BuildContext context;
  final String from;
  EventTapOnBookShare(this.context, this.book, this.from);

  @override
  String get eventName => 'tap_on_book_share_menu';

  @override
  Map<String, dynamic>? get eventProperties {
    String placementFound = "";
    try {
      placementFound = placement(context);
    } catch (e) {
      placementFound = Placement.getLastPlacementForBook(context, book);
    }
    return {
      "action": 'open',
      "from": from,
      keyPlacement: placementFound,
      ...bookProperties(context, book),
    };
  }
}
