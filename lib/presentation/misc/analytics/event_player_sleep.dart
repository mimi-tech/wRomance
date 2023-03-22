import 'package:flutter/material.dart';
import 'package:womanly_mobile/domain/entities/book.dart';
import 'package:womanly_mobile/domain/entities/enums/sleep_timer.dart';
import 'package:womanly_mobile/presentation/misc/analytics/analytics_event.dart';
import 'package:womanly_mobile/presentation/misc/analytics/placement.dart';

class EventPlayerSleep extends AnalyticsEvent {
  final BuildContext context;
  final Book book;
  final SleepTimer timer;
  EventPlayerSleep(this.context, this.book, this.timer);

  @override
  String get eventName => 'player_sleep';

  @override
  Map<String, dynamic>? get eventProperties => {
        keyPlacement: Placement.getLastPlacementForBook(context, book),
        ...bookProperties(context, book),
        "value": timer.toString().split('.')[1],
      };
}
