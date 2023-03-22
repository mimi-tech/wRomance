import 'package:womanly_mobile/presentation/misc/analytics/analytics_event.dart';

class EventAppReviewResult {
  final int score;
  final bool userPressedButton;

  EventAppReviewResult(this.score, this.userPressedButton);
}

class EventAppReview extends AnalyticsEvent {
  final dynamic data;
  EventAppReview(this.data);

  @override
  String get eventName => 'app_review';

  EventAppReviewResult? get result =>
      data is EventAppReviewResult ? data : null;

  @override
  Map<String, dynamic>? get eventProperties => {
        "action": (result?.userPressedButton ?? false) ? 'rate' : 'close',
        "score": result?.score ?? 0,
        "store_proceed": result == null
            ? "none"
            : (result!.score == 5
                ? (result!.userPressedButton ? "yes" : "no")
                : "none"),
      };
}
