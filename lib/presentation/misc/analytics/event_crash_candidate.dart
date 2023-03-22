import 'package:womanly_mobile/presentation/misc/analytics/analytics_event.dart';

class EventCrashCandidate extends AnalyticsEvent {
  final String reason;
  EventCrashCandidate(
    this.reason,
  );

  @override
  String get eventName => 'crash_candidate';

  @override
  Map<String, dynamic>? get eventProperties => {
        "reason": reason,
      };
}
