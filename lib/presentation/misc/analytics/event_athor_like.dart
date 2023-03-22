import 'package:flutter/material.dart';
import 'package:womanly_mobile/domain/entities/actor.dart';
import 'package:womanly_mobile/presentation/misc/analytics/analytics_event.dart';

class EventAuthorLike extends AnalyticsEvent {
  final Actor actor;
  final BuildContext context;
  final bool isLike;
  EventAuthorLike(this.context, this.actor, this.isLike);

  @override
  String get eventName => 'author_like';

  @override
  Map<String, dynamic>? get eventProperties {
    final _placement = placement(context);

    return {
      'author_id': actor.id,
      'author_name': actor.name,
      "action": isLike ? 'add' : 'remove',
      keyPlacement: _placement,
    };
  }
}
