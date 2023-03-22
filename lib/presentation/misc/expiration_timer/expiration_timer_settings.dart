import 'package:womanly_mobile/presentation/misc/config/remote_config.dart';

enum ExpirationTimerBannerStyle {
  normal,
  small,
}

class ExpirationTimerSettings {
  final ExpirationTimerBannerStyle style;
  final bool alignWithOtherInRow;
  final bool blurWhenGone;
  final bool alwaysHidden;

  static const ExpirationTimerSettings hidden =
      ExpirationTimerSettings(alwaysHidden: true);

  const ExpirationTimerSettings({
    this.style = ExpirationTimerBannerStyle.normal,
    this.alignWithOtherInRow = false,
    this.blurWhenGone = true,
    this.alwaysHidden = false,
  });

  double get height {
    if (!RemoteConfig.isExpiredTimerEnabled) {
      return 0;
    }
    switch (style) {
      case ExpirationTimerBannerStyle.normal:
        return 30;
      case ExpirationTimerBannerStyle.small:
        return 24;
    }
  }
}
