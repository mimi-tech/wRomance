import 'package:flutter/material.dart';
import 'package:womanly_mobile/domain/entities/book.dart';
import 'package:womanly_mobile/presentation/misc/analytics/analytics_event.dart';
import 'package:womanly_mobile/presentation/misc/analytics/placement.dart';

class EventPlayerInfo extends AnalyticsEvent {
  final BuildContext context;
  final Book book;
  EventPlayerInfo(this.context, this.book);

  @override
  String get eventName => 'player_info';

  @override
  Map<String, dynamic>? get eventProperties => {
        keyPlacement: Placement.getLastPlacementForBook(context, book),
        ...bookProperties(context, book),
      };
}
