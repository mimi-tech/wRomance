import 'package:adjust_sdk/adjust.dart';
import 'package:womanly_mobile/presentation/misc/analytics/analytics_event.dart';

enum AppState {
  install,
  foreground,
  background,
}

class EventAppLifecycle extends AnalyticsEvent {
  final AppState appState;

  EventAppLifecycle(this.appState) {
    switch (appState) {
      case AppState.foreground:
        Adjust.onResume();
        break;
      case AppState.background:
        Adjust.onPause();
        break;
      default:
    }
  }

  @override
  String get eventName => "app_lifecycle";

  @override
  Map<String, dynamic>? get eventProperties => {
        "app_state": appState.toString().split('.')[1],
      };
}
