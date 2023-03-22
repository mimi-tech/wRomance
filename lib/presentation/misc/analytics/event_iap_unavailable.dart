import 'package:womanly_mobile/presentation/misc/analytics/analytics_event.dart';

class EventIAPUnavailable extends AnalyticsEvent {
  String type;
  String? data;
  bool dialogShown;
  EventIAPUnavailable(this.type, this.dialogShown, {this.data});

  @override
  String get eventName => 'iap_unavailable';

  @override
  Map<String, dynamic>? get eventProperties => {
        "type": type,
        "data": data,
        "dialog_shown": dialogShown,
      };
}
