import 'package:womanly_mobile/presentation/misc/log.dart';

/// This status is set for user from server and usually is not
/// going to be changed
enum MonetizationUserStatus {
  /// Initial status for Android and current status for iOS
  /// (for iOS users app is absolutely free)
  undefined,

  /// Allows user to listen any book in the app
  /// without any restrictions
  free,

  /// IAP one per book (some books can still be available for free)
  /// to listen those books unlimitedly
  oneTimePurchases,

  /// TBD, use of subscriptions, paywals and etc.
  subscription,

  /// IAP and subscription alongside
  hybrid,
}

extension MonetizationUserStatusExt on MonetizationUserStatus {
  static MonetizationUserStatus? named(String name) {
    try {
      return MonetizationUserStatus.values.firstWhere((it) => it.name == name);
    } catch (e) {
      Log.print(e);
      return null;
    }
  }

  String get serverRequest {
    switch (this) {
      case MonetizationUserStatus.undefined:
        return "";
      case MonetizationUserStatus.free:
        return "free";
      case MonetizationUserStatus.oneTimePurchases:
        return "one_time_purchases";
      case MonetizationUserStatus.subscription:
        return "subscription";
      case MonetizationUserStatus.hybrid:
        return "hybrid";
    }
  }
}
