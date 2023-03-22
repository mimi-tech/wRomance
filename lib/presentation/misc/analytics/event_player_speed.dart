import 'package:flutter/material.dart';
import 'package:womanly_mobile/domain/entities/book.dart';
import 'package:womanly_mobile/domain/entities/enums/player_speed.dart';
import 'package:womanly_mobile/presentation/misc/analytics/analytics_event.dart';
import 'package:womanly_mobile/presentation/misc/analytics/placement.dart';

class EventPlayerSpeed extends AnalyticsEvent {
  final BuildContext context;
  final Book book;
  final PlayerSpeed speed;
  EventPlayerSpeed(this.context, this.book, this.speed);

  @override
  String get eventName => 'player_speed';

  @override
  Map<String, dynamic>? get eventProperties => {
        keyPlacement: Placement.getLastPlacementForBook(context, book),
        ...bookProperties(context, book),
        "value": speed.value.toString(),
      };
}
