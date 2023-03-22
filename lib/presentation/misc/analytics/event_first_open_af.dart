import 'package:womanly_mobile/presentation/misc/analytics/analytics_event.dart';

class EventFirstOpenAF extends AnalyticsEvent {
  @override
  String get eventName => 'c_app_first_open';

  @override
  bool get allowedForAmplitude => false;
  @override
  bool get allowedForAppsFlyer => true;

  @override
  Map<String, dynamic>? get eventProperties => null;
}
