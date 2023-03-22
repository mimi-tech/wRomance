import 'package:womanly_mobile/presentation/misc/analytics/analytics_event.dart';

class EventIAPErrorLoadingPricesSilent extends AnalyticsEvent {
  final String details;

  EventIAPErrorLoadingPricesSilent(this.details);

  @override
  String get eventName => 'iap_error_loading_prices_silent';

  @override
  Map<String, dynamic>? get eventProperties => {
        "details": details,
      };
}
