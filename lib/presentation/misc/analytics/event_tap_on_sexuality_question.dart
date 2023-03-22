import 'package:womanly_mobile/presentation/misc/analytics/analytics_event.dart';

class EventTapOnSexualityQuestion extends AnalyticsEvent {
  final int questionId;
  final String question;

  EventTapOnSexualityQuestion(this.questionId, this.question);

  @override
  String get eventName => 'tap_on_sexuality_question';

  @override
  Map<String, dynamic>? get eventProperties => {
        'question_id': questionId,
        'question_name': question,
      };
}
