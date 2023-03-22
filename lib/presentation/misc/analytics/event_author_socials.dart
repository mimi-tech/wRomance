import 'package:flutter/material.dart';
import 'package:womanly_mobile/domain/entities/actor.dart';
import 'package:womanly_mobile/presentation/misc/analytics/analytics_event.dart';

class EventAuthorSocials extends AnalyticsEvent {
  final Actor actor;
  final BuildContext context;
  final String socialName;
  EventAuthorSocials(this.context, this.actor, this.socialName);

  @override
  String get eventName => 'author_socials';

  @override
  Map<String, dynamic>? get eventProperties {
    final _placement = placement(context);

    return {
      'author_id': actor.id,
      'author_name': actor.name,
      'social_network': socialName,
      keyPlacement: _placement,
    };
  }
}
