import 'package:shared_preferences/shared_preferences.dart';
import 'package:womanly_mobile/domain/audio_player.dart';
import 'package:womanly_mobile/presentation/misc/log.dart';

class JumpResumePositionListener {
  static const _keyLastPausedMs = "JumpResumePositionListener._keyLastPausedMs";
  static const _keySkipNext = "JumpResumePositionListener._keySkipNext";
  static SharedPreferences? _prefs;
  static void init(SharedPreferences prefs) {
    _prefs = prefs;
  }

  static final List<_ResumeShift> _shifts = [
    _ResumeShift(const Duration(seconds: 2), 2),
    _ResumeShift(const Duration(seconds: 10), 5),
    _ResumeShift(const Duration(seconds: 90), 10),
    _ResumeShift(const Duration(minutes: 2), 15),
    _ResumeShift(const Duration(minutes: 5), 20),
    _ResumeShift(const Duration(minutes: 10), 25),
    _ResumeShift(const Duration(minutes: 30), 30),
  ];

  static bool get positionJumpedLastTime {
    if (_positionJumpedLastTime) {
      _positionJumpedLastTime = false;
      return true;
    }
    return false;
  }

  static bool _positionJumpedLastTime = false;

  static void skipNextByUserAction() {
    _prefs?.setBool(_keySkipNext, true);
  }

  static void onIsPlayingChanged(AudioPlayer player, bool isPlaying) {
    if (isPlaying) {
      final duration = _getJumpDuration();
      if (duration != Duration.zero) {
        Log.print("==RESUME jump by: ${duration.inSeconds} seconds");
        player.jumpBy(duration);
        _positionJumpedLastTime = true;
      }
    } else {
      _prefs?.setInt(_keyLastPausedMs, DateTime.now().millisecondsSinceEpoch);
    }
  }

  static Duration _getJumpDuration() {
    if (_prefs?.getBool(_keySkipNext) ?? false) {
      _prefs?.setBool(_keySkipNext, false);
      Log.print("==RESUME skipped");
      return Duration.zero;
    }

    final now = DateTime.now().millisecondsSinceEpoch;
    final lastTimeMs = _prefs?.getInt(_keyLastPausedMs) ?? now;
    final diffMs = now - lastTimeMs;
    Log.print("==RESUME _getJumpDuration: $diffMs");
    for (int i = _shifts.length - 1; i >= 0; i--) {
      if (_shifts[i].duration.inMilliseconds < diffMs) {
        return Duration(seconds: -_shifts[i].shiftSeconds); //negative
      }
    }

    return Duration.zero;
  }
}

class _ResumeShift {
  final Duration duration;
  final int shiftSeconds;

  _ResumeShift(this.duration, this.shiftSeconds);
}
