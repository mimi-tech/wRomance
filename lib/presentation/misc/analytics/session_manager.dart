import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:womanly_mobile/main.dart';
import 'package:womanly_mobile/presentation/misc/analytics/analytics.dart';
import 'package:womanly_mobile/presentation/misc/analytics/event_crash_candidate.dart';
import 'package:womanly_mobile/presentation/misc/analytics/event_retention.dart';
import 'package:womanly_mobile/presentation/misc/log.dart';

class SessionManager {
  static const _minutesOfIdleToIncreaseSessionNumber = 30;
  static const _updateIntervalMinutes = 1;

  final _keyLastUpdated = "SessionManager.keyLastUpdated";
  static const _keySessionNumber = "SessionManager.keySessionNumber";
  static const _keyLastStateWasIdle = "SessionManager.keyLastStateWasIdle";
  final SharedPreferences _prefs;
  static bool wasCrashCandidateThisLaunch = false;

  Timer? _timer;
  SessionManager(this._prefs) {
    _onTimer(null);
  }

  static void checkLastState() {
    final lastStateWasIdle =
        sharedPreferences.getBool(_keyLastStateWasIdle) ?? true;

    if (!lastStateWasIdle && kReleaseMode) {
      //In debug mode any Restart/Stop will finish the app in ACTIVE state
      //It is also possible that user force-stopped the app or rebooted it
      wasCrashCandidateThisLaunch = true;
      const reason = "Last run app was finished in ACTIVE state";
      Analytics.logEvent(EventCrashCandidate(reason));
      Log.errorCrashCandidate(reason);
    }
  }

  bool get isInBackground => _isInBackground;

  bool _isInBackground = false;

  void backgrondState() {
    _isInBackground = true;
    _setIdle();
  }

  void foregrondState() {
    _isInBackground = false;
    _setActive();
  }

  void onIsPlayingChanged(bool isPlaying) async {
    await Future.delayed(
        const Duration(seconds: 1)); //to avoid activations by callbacks
    if (_isInBackground && !isPlaying) {
      _setIdle();
    } else {
      _setActive();
    }
  }

  void _setActive() {
    sharedPreferences.setBool(_keyLastStateWasIdle, false);
    if (_timer == null) {
      Log.print("==SessionManager ACTIVE");
      _onTimer(null);
      _timer = Timer.periodic(
          const Duration(minutes: _updateIntervalMinutes), _onTimer);
      Analytics.logEvent(EventRetention(_prefs));
    }
  }

  void _setIdle() {
    sharedPreferences.setBool(_keyLastStateWasIdle, true);
    Log.print("==SessionManager IDLE");
    _timer?.cancel();
    _timer = null;
  }

  static int sessionNumberStatic(SharedPreferences _prefs) =>
      _prefs.getInt(_keySessionNumber) ?? 1;
  int get sessionNumber => sessionNumberStatic(_prefs);
  void _onTimer(_) {
    Log.print("==SessionManager _onTimer()");
    final nowTs = DateTime.now().millisecondsSinceEpoch;
    final lastUpdatedTs = _prefs.getInt(_keyLastUpdated) ?? nowTs;
    if ((nowTs - lastUpdatedTs) / (60 * 1000) >=
        _minutesOfIdleToIncreaseSessionNumber) {
      _prefs.setInt(_keySessionNumber, sessionNumber + 1);
      Log.print("==SessionManager session got new value: $sessionNumber");
    }
    _prefs.setInt(_keyLastUpdated, nowTs);
  }

  void onPositionChanged() {
    _setActive();
  }
}
