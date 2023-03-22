import 'package:womanly_mobile/presentation/misc/analytics/analytics_event.dart';

class EventTapOnContactSupport extends AnalyticsEvent {
  final String? source;
  EventTapOnContactSupport({this.source});

  @override
  String get eventName => 'tap_on_contact_support';

  @override
  Map<String, dynamic>? get eventProperties => {
        "source": source,
      };
}
