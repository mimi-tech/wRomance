import 'package:womanly_mobile/presentation/misc/analytics/analytics_event.dart';

class EventChapter1CompletedAF extends AnalyticsEvent {
  @override
  String get eventName => 'm_chapter1_completed';

  @override
  Map<String, dynamic>? get eventProperties => null;

  @override
  bool get allowedForAmplitude => false;
  @override
  bool get allowedForAppsFlyer => true;
}
