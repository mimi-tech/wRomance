import 'dart:convert';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:womanly_mobile/main.dart';
import 'package:womanly_mobile/presentation/misc/analytics/analytics.dart';
import 'package:womanly_mobile/presentation/misc/analytics/event_ab_test_v2.dart';
import 'package:womanly_mobile/presentation/misc/config/ab_experiment.dart';
import 'package:womanly_mobile/presentation/misc/config/remote_config_parameter.dart';
import 'package:womanly_mobile/presentation/misc/log.dart';
import 'package:womanly_mobile/presentation/misc/payments/monetization_user_status.dart';

enum SplashType {
  ///
  ///Don't change names, they are used on server side
  ///
  unlimitedListening,
  unlimitedListeningNoTrial,
  hurryToListenFree,
  onlyLogo,
  steamyReadAndTalks,
  handpickedTopRomanceAudiobooks,
  handpickedTopRomanceAudiobooksFreeUpExperiment2,
  handpickedTopRomanceAudiobooksV3,
}

extension SplashTypeExt on SplashType {
  String get name => toString().split('.')[1];

  static SplashType? named(String name) {
    try {
      return SplashType.values.firstWhere((it) => it.name == name);
    } catch (e) {
      Log.print(e);
      return null;
    }
  }
}

class RemoteConfig {
  static const _abSlotInAppDefaultValue = r"""{"name":"none","group":"none"}""";

  static final _abSlot1 = RemoteConfigParameter(
    name: "AB_slot1",
    inAppDefaultValue: _abSlotInAppDefaultValue,
  );
  static final _abSlot2 = RemoteConfigParameter(
    name: "AB_slot2",
    inAppDefaultValue: _abSlotInAppDefaultValue,
  );
  static final _abSlot3 = RemoteConfigParameter(
    name: "AB_slot3",
    inAppDefaultValue: _abSlotInAppDefaultValue,
  );
  static final _abSlot4 = RemoteConfigParameter(
    name: "AB_slot4",
    inAppDefaultValue: _abSlotInAppDefaultValue,
  );
  static final _abSlot5 = RemoteConfigParameter(
    name: "AB_slot5",
    inAppDefaultValue: _abSlotInAppDefaultValue,
  );
  static final _sessionNumberToShowAppReviewDialog = RemoteConfigParameter(
    name: "sessionNumberToShowAppReviewDialog",
    inAppDefaultValue: 5,
  );
  static final _isEmotionsEnabled = RemoteConfigParameter(
    name: "isEmotionsEnabled",
    inAppDefaultValue: false,
  );
  static final _isAppReviewDialogEnabled = RemoteConfigParameter(
    name: "isAppReviewDialogEnabled",
    inAppDefaultValue: true,
  );
  static final _isOpenALargePlayer = RemoteConfigParameter(
    name: "isOpenALargePlayer",
    inAppDefaultValue: false,
  );
  static final _isSearchSortEnabled = RemoteConfigParameter(
    name: "isSearchSortEnabled",
    inAppDefaultValue: true,
  );
  static final _isSearchSortByPopularityEnabled = RemoteConfigParameter(
    name: "isSearchSortByPopularityEnabled",
    inAppDefaultValue: true,
  );
  static final _isSearchSortBySpicyEnabled = RemoteConfigParameter(
    name: "isSearchSortBySpicyEnabled",
    inAppDefaultValue: true,
  );
  static final _isSubgenresStyledAsBlocks = RemoteConfigParameter(
    name: "isSubgenresStyledAsBlocks",
    inAppDefaultValue: true,
  );
  static final _isSteamyTalksEnabled = RemoteConfigParameter(
    name: "isSteamyTalksEnabled",
    inAppDefaultValue: false,
  );
  static final _isDailyQuizEnabled = RemoteConfigParameter(
    name: "isDailyQuizEnabled",
    inAppDefaultValue: false,
  );
  static final _isIOSPushNotificationsEnabled = RemoteConfigParameter(
    name: "isIOSPushNotificationsEnabled",
    inAppDefaultValue: true,
  );
  static final _splashType = RemoteConfigParameter(
    name: "splashType",
    inAppDefaultValue:
        SplashType.handpickedTopRomanceAudiobooksFreeUpExperiment2.name,
  );
  static final _monetizationRequestStatus = RemoteConfigParameter(
    name: "monetizationRequestStatus",
    inAppDefaultValue: MonetizationUserStatus.oneTimePurchases.name,
  );
  static final _isExpiredTimerEnabled = RemoteConfigParameter(
    name: "isExpiredTimerEnabled",
    inAppDefaultValue: false,
  );
  static final _isBookPeppersEnabled = RemoteConfigParameter(
    name: "isBookPeppersEnabled",
    inAppDefaultValue: true,
  );
  static final _isOnboardingEnabled = RemoteConfigParameter(
    name: "isOnboardingEnabled",
    inAppDefaultValue: true,
  );
  static final _isFreeUpExperiment1Enabled = RemoteConfigParameter(
    name: "isFreeUpExperiment1Enabled",
    inAppDefaultValue: false,
  );
  static final _isFreeUpExperiment2Enabled = RemoteConfigParameter(
    name: "isFreeUpExperiment2Enabled",
    inAppDefaultValue: false,
  );
  static final _freeUpExperimentNumber = RemoteConfigParameter(
    name: "freeUpExperimentNumber",
    inAppDefaultValue: 0,
  );
  static final _isAgePollEnabled = RemoteConfigParameter(
    name: "isAgePollEnabled",
    inAppDefaultValue: true,
  );
  static final _mediaUrl = RemoteConfigParameter(
    name: "mediaUrl",
    inAppDefaultValue: "",
  );
  static final _isNewPlayerScreenEnabled = RemoteConfigParameter(
    name: "isNewPlayerScreenEnabled",
    inAppDefaultValue: true,
  );
  static final _isNewMainScreenEnabled = RemoteConfigParameter(
    name: "isNewMainScreenEnabled",
    inAppDefaultValue: true,
  );
  static final _isNewSearchScreenEnabled = RemoteConfigParameter(
    name: "isNewSearchScreenEnabled",
    inAppDefaultValue: true,
  );
  static final _isNewMyListScreenEnabled = RemoteConfigParameter(
    name: "isNewMyListScreenEnabled",
    inAppDefaultValue: true,
  );
  static final _isNewProductScreenEnabled = RemoteConfigParameter(
    name: "isNewProductScreenEnabled",
    inAppDefaultValue: false,
  );
  static final _debugParam1 = RemoteConfigParameter(
    name: "debugParam1",
    inAppDefaultValue: "",
  );
  static final _fixIapUnavailable = RemoteConfigParameter(
    name: "fixIapUnavailable",
    inAppDefaultValue: false,
  );
  static final _forceSetPriceTierForNonFree = RemoteConfigParameter(
    name: "forceSetPriceTierForNonFree",
    inAppDefaultValue: "",
  );
  static final _forceSetPriceTierForAll = RemoteConfigParameter(
    name: "forceSetPriceTierForAll",
    inAppDefaultValue: "",
  );
  static final _is3ChaptersFree = RemoteConfigParameter(
    name: "is3ChaptersFree",
    inAppDefaultValue: false,
  );
  static final _isOnlyOneOfferForNewUsers = RemoteConfigParameter(
    name: "isOnlyOneOfferForNewUsers",
    inAppDefaultValue: false,
  );
  static final _subscriptionPlans = RemoteConfigParameter(
    name: "subscriptionPlans",
    inAppDefaultValue: "",
  );
  static final _readyForHybridConditionDaysAfterInstall = RemoteConfigParameter(
    name: "readyForHybridConditionDaysAfterInstall",
    inAppDefaultValue: 9,
  );
  static final _readyForHybridConditionFinishedPaidBooks =
      RemoteConfigParameter(
    name: "readyForHybridConditionFinishedPaidBooks",
    inAppDefaultValue: 1,
  );
  static final _readyForHybridConditionOperatorIsAND = RemoteConfigParameter(
    name: "readyForHybridConditionOperatorIsAND",
    inAppDefaultValue: true,
  );
  static final _isAllowedHybridMonetizationOnConditions = RemoteConfigParameter(
    name: "isAllowedHybridMonetizationOnConditions",
    inAppDefaultValue: false,
  );
  static final _adjustAttributionMap = RemoteConfigParameter(
    name: "adjustAttributionMap",
    inAppDefaultValue: "{}",
  );
  static final _yearlySubscription = RemoteConfigParameter(
    name: "yearlySubscription",
    inAppDefaultValue: true,
  );

  static bool? _debugYearlySubscription;

//----------------------------------------

  static ABExperiment get _abExperimentSlot1 =>
      ABExperiment(_abSlot1.getValue(_instance));
  static ABExperiment get _abExperimentSlot2 =>
      ABExperiment(_abSlot2.getValue(_instance));
  static ABExperiment get _abExperimentSlot3 =>
      ABExperiment(_abSlot3.getValue(_instance));
  static ABExperiment get _abExperimentSlot4 =>
      ABExperiment(_abSlot4.getValue(_instance));
  static ABExperiment get _abExperimentSlot5 =>
      ABExperiment(_abSlot5.getValue(_instance));

  static List<ABExperiment> get activeAbExperiments => [
        _abExperimentSlot1,
        _abExperimentSlot2,
        _abExperimentSlot3,
        _abExperimentSlot4,
        _abExperimentSlot5,
      ].where((it) => it.name != "none").toList();

  static int get sessionNumberToShowAppReviewDialog =>
      _sessionNumberToShowAppReviewDialog.getValue(_instance);
  static bool get isEmotionsEnabled => _isEmotionsEnabled.getValue(_instance);
  static bool get isAppReviewDialogEnabled =>
      _isAppReviewDialogEnabled.getValue(_instance);
  static bool get isOpenALargePlayer => _isOpenALargePlayer.getValue(_instance);
  static bool get isSearchSortEnabled =>
      _isSearchSortEnabled.getValue(_instance);
  static bool get isSearchSortByPopularityEnabled =>
      _isSearchSortByPopularityEnabled.getValue(_instance);
  static bool get isSearchSortBySpicyEnabled =>
      _isSearchSortBySpicyEnabled.getValue(_instance);
  static bool get isSubgenresStyledAsBlocks =>
      _isSubgenresStyledAsBlocks.getValue(_instance);
  static bool get isSteamyTalksEnabled =>
      _isSteamyTalksEnabled.getValue(_instance);
  static bool get isDailyQuizEnabled => _isDailyQuizEnabled.getValue(_instance);
  static bool get isIOSPushNotificationsEnabled =>
      _isIOSPushNotificationsEnabled.getValue(_instance);
  static bool get isExpiredTimerEnabled =>
      _isExpiredTimerEnabled.getValue(_instance);
  static SplashType? get splashType =>
      SplashTypeExt.named(_splashType.getValue(_instance));
  static MonetizationUserStatus? get monetizationRequestStatus =>
      MonetizationUserStatusExt.named(
          _monetizationRequestStatus.getValue(_instance));
  static bool get isBookPeppersEnabled =>
      _isBookPeppersEnabled.getValue(_instance);
  static bool get isOnboardingEnabled =>
      _isOnboardingEnabled.getValue(_instance);
  static bool get isFreeUpExperiment1Enabled =>
      freeUpExperimentNumber == 1 &&
      _isFreeUpExperiment1Enabled.getValue(_instance);
  static bool get isFreeUpExperiment2Enabled =>
      freeUpExperimentNumber == 2 &&
      _isFreeUpExperiment2Enabled.getValue(_instance);
  static int get freeUpExperimentNumber =>
      _freeUpExperimentNumber.getValue(_instance);
  static bool get isAgePollEnabled => _isAgePollEnabled.getValue(_instance);
  static String get mediaUrl => _mediaUrl.getValue(_instance);
  static bool get isNewPlayerScreenEnabled =>
      _isNewPlayerScreenEnabled.getValue(_instance);
  static bool get isNewMainScreenEnabled =>
      _isNewMainScreenEnabled.getValue(_instance);
  static bool get isNewSearchScreenEnabled =>
      _isNewSearchScreenEnabled.getValue(_instance);
  static bool get isNewMyListScreenEnabled =>
      _isNewMyListScreenEnabled.getValue(_instance);
  static bool get isNewProductScreenEnabled =>
      _isNewProductScreenEnabled.getValue(_instance);
  static String get debugParam1 => _debugParam1.getValue(_instance);
  static bool get fixIapUnavailable => _fixIapUnavailable.getValue(_instance);
  static String get forceSetPriceTierForNonFree =>
      _forceSetPriceTierForNonFree.getValue(_instance);
  static String get forceSetPriceTierForAll =>
      _forceSetPriceTierForAll.getValue(_instance);
  static bool get is3ChaptersFree => _is3ChaptersFree.getValue(_instance);
  static bool get isOnlyOneOfferForNewUsers =>
      true; //true for all since 1.0.153
  // _isOnlyOneOfferForNewUsers.getValue(_instance);
  static List<String> get subscriptionPlans =>
      _subscriptionPlans.getValue(_instance).split(",");
  static int get readyForHybridConditionDaysAfterInstall =>
      _readyForHybridConditionDaysAfterInstall.getValue(_instance);
  static int get readyForHybridConditionFinishedPaidBooks =>
      _readyForHybridConditionFinishedPaidBooks.getValue(_instance);
  static bool get readyForHybridConditionOperatorIsAND =>
      _readyForHybridConditionOperatorIsAND.getValue(_instance);
  static bool get isAllowedHybridMonetizationOnConditions =>
      (isTestEnvironment() && _debugYearlySubscription != null)
          ? _debugYearlySubscription!
          : _isAllowedHybridMonetizationOnConditions.getValue(_instance);
  static dynamic get adjustAttributionMap =>
      jsonDecode(_adjustAttributionMap.getValue(_instance));
  static bool get yearlySubscription =>
      (isTestEnvironment() && _debugYearlySubscription != null)
          ? _debugYearlySubscription!
          : _yearlySubscription.getValue(_instance);

//----------------------------------------

  static FirebaseRemoteConfig? _instance;
  static bool _remoteConfigFetched = false;
  static bool get isFetched => _remoteConfigFetched;

  static final List<VoidCallback> _listeners = [];

  static void addNewValuesActivatedListener(VoidCallback callback) {
    _listeners.add(callback);
  }

  static void removeNewValuesActivatedListener(VoidCallback callback) {
    _listeners.remove(callback);
  }

  static Future<void> init() async {
    Log.stub();
  }

  static void sendAbExperimentData([int maxAttempts = 10]) {
    if (maxAttempts < 0) {
      return;
    }

    if (!_remoteConfigFetched) {
      Future.delayed(const Duration(seconds: 30), () {
        sendAbExperimentData(maxAttempts - 1);
      });
      return;
    }

    Analytics.updateUserProperties();
    for (var experiment in activeAbExperiments) {
      final name = experiment.name;
      final group = experiment.group;

      if (name.isNotEmpty && group.isNotEmpty) {
        Analytics.logEventOnce(
          EventAbTestV2(name: name, group: group),
          AnalyticsOnceKey.eventAbTestV2,
          suffix: "${name}_$group",
        );
      }
    }
  }

  static void debugChangeYearlySubscription() {
    _debugYearlySubscription = yearlySubscription;
    _debugYearlySubscription = !_debugYearlySubscription!;
  }
}
