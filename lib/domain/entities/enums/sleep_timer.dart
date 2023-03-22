enum SleepTimer {
  none,
  m15,
  m30,
  m45,
  m60,
}

extension SleepTimerX on SleepTimer {
  String? get description {
    switch (this) {
      case SleepTimer.none:
        return null;
      case SleepTimer.m15:
        return "15m";
      case SleepTimer.m30:
        return "30m";
      case SleepTimer.m45:
        return "45m";
      case SleepTimer.m60:
        return "60m";
    }
  }

  Duration? get value {
    switch (this) {
      case SleepTimer.none:
        return null;
      case SleepTimer.m15:
        return const Duration(minutes: 15);
      case SleepTimer.m30:
        return const Duration(minutes: 30);
      case SleepTimer.m45:
        return const Duration(minutes: 45);
      case SleepTimer.m60:
        return const Duration(minutes: 60);
    }
  }
}
