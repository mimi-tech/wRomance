import 'package:womanly_mobile/presentation/misc/analytics/analytics_event.dart';

class EventPurchaseAttemptAF extends AnalyticsEvent {
  @override
  String get eventName => 'purchase_attempt';

  @override
  bool get allowedForAmplitude => false;
  @override
  bool get allowedForAppsFlyer => false;

  @override
  Map<String, dynamic>? get eventProperties => null;
}
