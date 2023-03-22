import 'package:flutter/material.dart';
import 'package:womanly_mobile/domain/entities/book.dart';
import 'package:womanly_mobile/presentation/misc/analytics/analytics_event.dart';
import 'package:womanly_mobile/presentation/misc/analytics/placement.dart';

class EventTReactionsListenSignificantStarted extends AnalyticsEvent {
  final BuildContext context;
  final Book book;
  late final _placement = Placement.getLastPlacementForBook(context, book);
  EventTReactionsListenSignificantStarted(this.context, this.book);

  @override
  String get eventName => 't_reactions_listen_significant_started';

  @override
  Map<String, dynamic>? get eventProperties {
    return {
      keyTabName: tabName,
      keyPlacement: _placement,
      ...bookProperties(context, book),
    };
  }

  @override
  bool get allowedForAppsFlyer => false;
}
