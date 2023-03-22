import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:womanly_mobile/presentation/misc/analytics/analytics_event.dart';

class Event3TapsOnBookAF extends AnalyticsEvent {
  BuildContext context;
  Event3TapsOnBookAF(this.context);

  static int _counter = 0;
  static const String _prefsKey = "Event3TapsOnBookAF.allowed";

  @override
  String get eventName => 'm_3taps_on_book';

  @override
  Map<String, dynamic>? get eventProperties => null;

  @override
  bool get allowedForAmplitude => false;
  @override
  bool get allowedForAppsFlyer => true;

  @override
  bool get allowed {
    _counter++;
    if (_counter == 3) {
      final prefs = context.read<SharedPreferences>();
      if (prefs.getBool(_prefsKey) ?? true) {
        prefs.setBool(_prefsKey, false);
        return true;
      }
    }
    return false;
  }
}
