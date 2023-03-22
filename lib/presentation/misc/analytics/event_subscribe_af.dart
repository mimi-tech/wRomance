import 'package:womanly_mobile/presentation/misc/analytics/analytics_event.dart';

class EventSubscribeAF extends AnalyticsEvent {
  final String subscriptionProductId;
  final double priceUsd;
  EventSubscribeAF({
    required this.subscriptionProductId,
    required this.priceUsd,
  });

  @override
  String get eventName => 'af_subscribe';

  @override
  bool get allowedForAmplitude => false;
  @override
  bool get allowedForAppsFlyer => true;

  @override
  Map<String, dynamic>? get eventProperties => {
        "af_content_id": subscriptionProductId,
        "af_revenue": priceUsd,
        "af_currency": "USD",
        "renewal": false,
      };
}
