import 'package:womanly_mobile/presentation/misc/analytics/analytics_event.dart';

class EventMessageSexualitySent extends AnalyticsEvent {
  final int questionId;
  final String question;

  EventMessageSexualitySent(this.questionId, this.question);

  @override
  String get eventName => 'message_sexuality_sent';

  @override
  Map<String, dynamic>? get eventProperties => {
        'question_id': questionId,
        'question_name': question,
        'message_id': -1,
      };
}
