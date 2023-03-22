import 'package:womanly_mobile/presentation/misc/analytics/analytics_event.dart';

class EventErrorHiveInitialization extends AnalyticsEvent {
  final String error;

  EventErrorHiveInitialization(this.error);

  @override
  String get eventName => 'hive_error_init';

  @override
  Map<String, dynamic>? get eventProperties => {
        "error": error,
      };
}
