import 'package:womanly_mobile/presentation/misc/analytics/analytics_event.dart';

class EventTapOnTab extends AnalyticsEvent {
  @override
  String get eventName => 'tap_on_tab';

  @override
  Map<String, dynamic>? get eventProperties => {
        keyTabName: tabName,
      };
}
