import 'package:womanly_mobile/presentation/misc/analytics/analytics_event.dart';

class EventOnboardingMoreUsage extends AnalyticsEvent {
  final bool show;
  EventOnboardingMoreUsage({
    required this.show,
  });

  @override
  String get eventName => 'onboarding_more_usage';

  @override
  Map<String, dynamic>? get eventProperties => {
        "action": show ? "show" : "hide",
      };
}
