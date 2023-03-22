import 'package:womanly_mobile/domain/entities/book.dart';
import 'package:womanly_mobile/presentation/misc/analytics/analytics_event.dart';

class EventPlaybackRestored extends AnalyticsEvent {
  final Book book;
  EventPlaybackRestored(
    this.book,
  );

  @override
  String get eventName => 'playback_restored';

  @override
  Map<String, dynamic>? get eventProperties => {
        "content_id": book.id,
        "content_name": book.name,
      };
}
