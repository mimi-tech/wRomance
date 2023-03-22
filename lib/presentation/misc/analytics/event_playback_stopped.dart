import 'package:womanly_mobile/domain/entities/book.dart';
import 'package:womanly_mobile/presentation/misc/analytics/analytics_event.dart';

class EventPlaybackStopped extends AnalyticsEvent {
  final int stopSeconds;
  final Book book;
  final String reason;
  EventPlaybackStopped(
    this.book,
    this.stopSeconds,
    this.reason,
  );

  @override
  String get eventName => 'playback_stopped';

  @override
  Map<String, dynamic>? get eventProperties => {
        "seconds": stopSeconds,
        "content_id": book.id,
        "content_name": book.name,
        "reason": reason,
      };
}
