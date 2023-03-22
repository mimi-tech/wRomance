import 'package:flutter/material.dart';
import 'package:womanly_mobile/domain/entities/actor.dart';
import 'package:womanly_mobile/presentation/misc/analytics/analytics_event.dart';

class EventTapOnAuthor extends AnalyticsEvent {
  final Actor actor;
  final BuildContext context;
  EventTapOnAuthor(this.context, this.actor);

  @override
  String get eventName => 'author_info';

  @override
  Map<String, dynamic>? get eventProperties {
    final _placement = placement(context);

    return {
      'author_id': actor.id,
      'author_name': actor.name,
      keyPlacement: _placement,
    };
  }
}
