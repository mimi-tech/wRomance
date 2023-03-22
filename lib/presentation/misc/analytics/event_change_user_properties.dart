import 'package:womanly_mobile/presentation/misc/analytics/analytics_event.dart';

class EventChangeUserProperties extends AnalyticsEvent {
  final Map<String, Object> properties;

  EventChangeUserProperties(this.properties);

  @override
  String get eventName => 'change_properties';

  @override
  Map<String, dynamic>? get eventProperties => properties;
}
