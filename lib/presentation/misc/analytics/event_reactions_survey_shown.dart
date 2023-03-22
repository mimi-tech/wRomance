import 'package:womanly_mobile/presentation/misc/analytics/analytics_event.dart';

class EventReactionsSurveyShown extends AnalyticsEvent {
  final String action;
  EventReactionsSurveyShown(this.action);

  @override
  String get eventName => 'reactions_survey_shown';

  @override
  Map<String, dynamic>? get eventProperties => {
        'action': action,
      };
}
