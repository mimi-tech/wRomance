import 'package:womanly_mobile/presentation/misc/analytics/analytics_event.dart';

class EventRetentionD2WithoutD1 extends AnalyticsEvent {
  @override
  bool get allowedForAmplitude => false;
  @override
  bool get allowedForAppsFlyer => true;

  @override
  Map<String, dynamic>? get eventProperties => null;

  @override
  String get eventName => 'm_retention_d2_without_d1';
}
