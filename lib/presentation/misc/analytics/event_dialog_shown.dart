import 'package:womanly_mobile/presentation/misc/analytics/analytics_event.dart';
import 'package:womanly_mobile/presentation/misc/dialog_message.dart';

class EventDialogShown extends AnalyticsEvent {
  DialogMessage message;
  EventDialogShown(this.message);

  @override
  String get eventName => 'dialog_shown';

  @override
  Map<String, dynamic>? get eventProperties => {
        "title": message.title,
        "body": message.body,
      };
}
