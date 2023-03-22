import 'package:womanly_mobile/presentation/misc/analytics/analytics_event.dart';

class EventSubscribeTryAF extends AnalyticsEvent {
  @override
  String get eventName => 'subscribe_try';

  @override
  bool get allowedForAmplitude => false;
  @override
  bool get allowedForAppsFlyer => true;

  @override
  Map<String, dynamic>? get eventProperties => null;
}
