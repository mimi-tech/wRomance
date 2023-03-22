import 'package:womanly_mobile/presentation/misc/analytics/analytics_event.dart';

class EventPushPermissionShown extends AnalyticsEvent {
  final bool? permissionGranted;
  EventPushPermissionShown(this.permissionGranted);

  @override
  String get eventName => 'push_permission_shown';

  @override
  Map<String, dynamic>? get eventProperties => {
        "action": permissionGranted == true
            ? 'enabled'
            : permissionGranted == false
                ? 'disabled'
                : 'dismissed',
      };
}
