import 'package:shared_preferences/shared_preferences.dart';
import 'package:womanly_mobile/presentation/misc/analytics/analytics_event.dart';

class EventPushReceived extends AnalyticsEvent {
  final bool isForeground;
  static const _keyPushesReceived = "EventPushReceived.key.pushesReceived";
  final String? campaign;
  EventPushReceived(
    this.campaign,
    SharedPreferences prefs, {
    required this.isForeground,
  }) {
    pushesReceived = prefs.getInt(_keyPushesReceived) ?? 0;
    prefs.setInt(_keyPushesReceived, pushesReceived + 1);
  }
  late final int pushesReceived;

  @override
  String get eventName => 'push_received';

  @override
  Map<String, dynamic>? get eventProperties => {
        "campaign": campaign,
        "pushes_received": pushesReceived,
        "is_foreground": isForeground ? 'yes' : 'no',
      };
}
