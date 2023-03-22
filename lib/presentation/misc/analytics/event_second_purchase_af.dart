import 'package:womanly_mobile/presentation/misc/analytics/analytics_event.dart';

class EventSecondPurchaseAF extends AnalyticsEvent {
  @override
  String get eventName => 'second_purchase';

  @override
  bool get allowedForAmplitude => false;
  @override
  bool get allowedForAppsFlyer => true;

  @override
  Map<String, dynamic>? get eventProperties => null;
}
