import 'package:womanly_mobile/presentation/misc/analytics/analytics_event.dart';

class EventPushConverted extends AnalyticsEvent {
  final String? campaign;
  final String? route;
  EventPushConverted(this.campaign, this.route);

  @override
  String get eventName => 'push_converted';

  @override
  Map<String, dynamic>? get eventProperties => {
        "campaign": campaign,
        "route": route,
      };
}
