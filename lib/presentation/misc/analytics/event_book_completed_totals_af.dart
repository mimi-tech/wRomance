import 'package:womanly_mobile/presentation/misc/analytics/analytics_event.dart';

class EventBookCompletedTotalsAF extends AnalyticsEvent {
  @override
  String get eventName => 'm_book_completed_totals';

  @override
  Map<String, dynamic>? get eventProperties => null;

  @override
  bool get allowedForAmplitude => false;
  @override
  bool get allowedForAppsFlyer => true;
}
