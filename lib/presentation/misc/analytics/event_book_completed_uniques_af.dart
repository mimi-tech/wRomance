import 'package:womanly_mobile/presentation/misc/analytics/analytics_event.dart';

class EventBookCompletedUniquesAF extends AnalyticsEvent {
  @override
  String get eventName => 'm_book_completed_uniques';

  @override
  Map<String, dynamic>? get eventProperties => null;

  @override
  bool get allowedForAmplitude => false;
  @override
  bool get allowedForAppsFlyer => true;
}
