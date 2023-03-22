import 'package:womanly_mobile/presentation/misc/analytics/analytics_event.dart';

class EventSexualityQuizConversion extends AnalyticsEvent {
  final int quizId;
  final String quizName;

  EventSexualityQuizConversion(this.quizId, this.quizName);

  @override
  String get eventName => 'sexuality_quiz_conversion';

  @override
  Map<String, dynamic>? get eventProperties => {
        'quiz_id': quizId,
        'quiz_name': quizName,
      };
}
