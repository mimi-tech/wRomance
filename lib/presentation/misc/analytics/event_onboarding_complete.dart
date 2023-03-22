import 'package:womanly_mobile/presentation/misc/analytics/analytics_event.dart';

class EventOnboardingComplete extends AnalyticsEvent {
  final bool isSkipped;
  final List<String> subgenresSelected;
  final List<String> tropesSelected;
  final int? spicyLevel;
  EventOnboardingComplete({
    required this.isSkipped,
    required this.subgenresSelected,
    required this.tropesSelected,
    this.spicyLevel,
  });

  @override
  String get eventName => 'onboarding_complete';

  @override
  Map<String, dynamic>? get eventProperties => {
        "action": isSkipped ? "skip" : "complete",
        "subcategories_selected":
            subgenresSelected.isEmpty ? "none" : subgenresSelected,
        "tropes_selected": tropesSelected.isEmpty ? "none" : tropesSelected,
        "steaminess_selected": spicyLevel ?? 0,
      };
}
