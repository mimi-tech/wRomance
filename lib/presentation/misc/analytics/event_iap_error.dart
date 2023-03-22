import 'package:womanly_mobile/presentation/misc/analytics/analytics_event.dart';

class EventIAPError extends AnalyticsEvent {
  final String error;
  final String? stackTrace;

  EventIAPError(this.error, [this.stackTrace]);

  @override
  String get eventName => 'iap_error';

  @override
  Map<String, dynamic>? get eventProperties => {
        "error": error,
        "stackTrace": stackTrace,
      };
}
