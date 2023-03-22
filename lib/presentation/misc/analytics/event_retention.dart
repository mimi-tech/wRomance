import 'package:shared_preferences/shared_preferences.dart';
import 'package:womanly_mobile/main.dart';
import 'package:womanly_mobile/presentation/misc/analytics/analytics.dart';
import 'package:womanly_mobile/presentation/misc/analytics/analytics_event.dart';
import 'package:womanly_mobile/presentation/misc/analytics/event_retention_d2_without_d1.dart';

class EventRetention extends AnalyticsEvent {
  final SharedPreferences _prefs;
  bool _allowed = false;
  late final int dayNumber;
  EventRetention(this._prefs) {
    dayNumber = calculateDayNumber();
    final properDay = [1, 2, 3, 4, 5, 6, 7, 14, 21, 30].contains(dayNumber);

    if (properDay &&
        !(_prefs.getBool(_uniqueKeyForEvent(dayNumber)) ?? false)) {
      _prefs.setBool(_uniqueKeyForEvent(dayNumber), true);
      _allowed = true;

      if (dayNumber == 2 && !wasEvent(_prefs, 1)) {
        Analytics.logEvent(EventRetentionD2WithoutD1());
      }
    }
  }

  @override
  bool get allowedForAppsFlyer => false;

  @override
  bool get allowed => _allowed;

  static int _lastCalculatedDayNumber = 0;

  static int calculateDayNumber() {
    final firstOpenedMs = sharedPreferences.getInt(_keyFirstOpened);
    late final int result;
    if (firstOpenedMs == null) {
      sharedPreferences.setInt(
          _keyFirstOpened, DateTime.now().millisecondsSinceEpoch);
      result = 0;
    } else {
      result = Duration(
              milliseconds:
                  DateTime.now().millisecondsSinceEpoch - firstOpenedMs)
          .inDays;
    }

    if (_lastCalculatedDayNumber != result) {
      _lastCalculatedDayNumber = result;
      Analytics.updateUserProperties();
    }

    return result;
  }

  static bool wasEvent(SharedPreferences prefs, int dayNumber) {
    return prefs.getBool(_uniqueKeyForEvent(dayNumber)) ?? false;
  }

  static String _uniqueKeyForEvent(int dayNumber) =>
      "UniqueKeyFor_EventRetention_d$dayNumber";

  static const String _keyFirstOpened = "EventRetention._keyFirstOpened";

  @override
  String get eventName => 'm_retention_d$dayNumber';

  @override
  Map<String, dynamic>? get eventProperties => null;
}
