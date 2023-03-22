import 'package:womanly_mobile/presentation/misc/analytics/analytics_event.dart';

class EventSexualityQuizAnswer extends AnalyticsEvent {
  final int quizId;
  final String quizName;

  EventSexualityQuizAnswer(this.quizId, this.quizName);

  @override
  String get eventName => 'sexuality_quiz_answer';

  @override
  Map<String, dynamic>? get eventProperties => {
        'quiz_id': quizId,
        'quiz_name': quizName,
      };
}
