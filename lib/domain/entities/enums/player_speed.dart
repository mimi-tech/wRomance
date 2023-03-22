enum PlayerSpeed {
  x1,
  x1_25,
  x1_5,
  x1_75,
}

extension PlayerSpeedX on PlayerSpeed {
  String get description {
    switch (this) {
      case PlayerSpeed.x1:
        return "1x";
      case PlayerSpeed.x1_25:
        return "1.25x";
      case PlayerSpeed.x1_5:
        return "1.5x";
      case PlayerSpeed.x1_75:
        return "1.75x";
    }
  }

  double get value {
    switch (this) {
      case PlayerSpeed.x1:
        return 1.0;
      case PlayerSpeed.x1_25:
        return 1.25;
      case PlayerSpeed.x1_5:
        return 1.5;
      case PlayerSpeed.x1_75:
        return 1.75;
    }
  }
}
