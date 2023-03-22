import 'package:womanly_mobile/presentation/misc/analytics/analytics_event.dart';

class EventDialogButtonPressed extends AnalyticsEvent {
  String title;
  EventDialogButtonPressed(this.title);

  @override
  String get eventName => 'dialog_button_pressed';

  @override
  Map<String, dynamic>? get eventProperties => {
        "title": title,
      };
}
