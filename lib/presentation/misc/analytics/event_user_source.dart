import 'dart:convert';

import 'package:womanly_mobile/presentation/misc/analytics/analytics_event.dart';

class EventUserSource extends AnalyticsEvent {
  String jsonParams;
  EventUserSource(this.jsonParams);

  @override
  String get eventName => 'user_source';

  @override
  Map<String, dynamic>? get eventProperties => jsonDecode(jsonParams);
}
