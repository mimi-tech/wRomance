import 'package:womanly_mobile/presentation/misc/analytics/analytics_event.dart';

class EventScreenShownFirstTime extends AnalyticsEvent {
  final String name;

  EventScreenShownFirstTime(this.name);

  @override
  String get eventName => 'screen_shown_first_time';

  @override
  Map<String, dynamic>? get eventProperties => {
        "screen": name,
      };
}
