import 'package:womanly_mobile/presentation/misc/analytics/analytics_event.dart';

class EventConnectionRetry extends AnalyticsEvent {
  final String error;

  EventConnectionRetry(this.error);

  @override
  String get eventName => 'connection_retry_pressed';

  @override
  Map<String, dynamic>? get eventProperties => {
        "error": error,
      };
}
