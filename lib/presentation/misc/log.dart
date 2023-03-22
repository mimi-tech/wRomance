import 'dart:core' as core;
import 'dart:core';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Log {
  static const _normalDartConsolePrintLimit = 500;

  static void print(core.dynamic obj) {
    final s = obj.toString();
    if (kDebugMode) {
      if (s.length < _normalDartConsolePrintLimit) {
        core.print(s);
      } else {
        _printLong(s);
      }
    }
  }

  static void _printLong(core.String s, {core.int charsPerLine = 100}) {
    while (s.isNotEmpty) {
      final index = s.length < charsPerLine ? s.length : charsPerLine;
      print("[LONG] :: ${s.substring(0, index)}");
      s = s.substring(index);
    }
  }

  static core.int _markCounter = 0;
  static void mark([core.String? suffix]) => Log.stub();

  static void errorTestListenButton(data) => Log.stub();

  static void stub() {}

  static void errorParsingBookModelFromJson([e, bookId]) => Log.stub();

  static void errorIAPDangerArea([e]) => Log.stub();
  static void errorIAPParsingVerificationResult([e]) => Log.stub();
  static void errorIAPInvalidPurchase([e]) => Log.stub();
  static void errorIAPNoProductsLoadedAtAll([e]) => Log.stub();
  static void errorIAPUnavailableException([e]) => Log.stub();
  static void errorIAPUnavailableFalse([e]) => Log.stub();
  static void errorIAPPossibleNotFoundProduct([e]) => Log.stub();
  static void errorIAPGeneralBeforeStep2([e]) => Log.stub();
  static void errorIAPNotFoundProduct([e]) => Log.stub();
  static void errorIAPCheckSpecialOfferContextIsNull([e]) => Log.stub();
  static void errorDailyQuizBookNotFoundLeft([e]) => Log.stub();
  static void errorDailyQuizBookNotFoundRight([e]) => Log.stub();
  static void errorSteamyTalksLoadResponses([e]) => Log.stub();
  static void errorAnalyticsChangeIsPaidParam([e]) => Log.stub();
  static void errorAnalyticsEventBooksOrderToString([e]) => Log.stub();
  static void errorAnalyticsServiceDeviceNotRegisteredYet([e]) => Log.stub();
  static void errorContactsFormGetSettings([e]) => Log.stub();
  static void errorNetworkPostJson([e]) => Log.stub();
  static void errorNetworkPutJson([e]) => Log.stub();
  static void errorNetworkPatchJson([e]) => Log.stub();
  static void errorParsingSeriesModelFromJson([e]) => Log.stub();
  static void errorNetworkClosingClientOnError([e]) => Log.stub();
  static void errorNetworkGetJson([e]) => Log.stub();
  static void errorNetworkGetBytes([e]) => Log.stub();
  static void errorLibraryManagerBookNotFound([e]) => Log.stub();
  static void errorOnboardingTropesIsEmpty([e]) => Log.stub();
  static void errorFCMGetToken([e]) => Log.stub();
  static void errorFCMSendTokenToServer([e]) => Log.stub();
  static void errorFCMNavigateToBook([e]) => Log.stub();
  static void errorFCMNavigateToAuthor([e]) => Log.stub();
  static void errorIAPPurchaseUpdatedGeneral([e]) => Log.stub();
  static void errorMainZonedGuarded([e, StackTrace? stack]) => Log.stub();
  static void errorFeaturedModelUnknown([e]) => Log.stub();
  static void errorParsingFeaturedModelFromJson([e]) => Log.stub();
  static void errorAllowingCustomCertificates([e]) => Log.stub();
  static void errorEmojiTypeToCode([e]) => Log.stub();
  static void errorFCMDataPushReloadBooks([e]) => Log.stub();
  static void errorIAPPriceNotFoundInMap([e]) => Log.stub();
  static void errorIAPPurchaseUpdatedOnError([e, StackTrace? stack]) =>
      Log.stub();
  static void errorIAPCurrentBookIsNull([e]) => Log.stub();
  static void errorIAPLoadProductsForSale([e]) => Log.stub();
  static void errorIAPCompletionException([e]) => Log.stub();
  static void errorParsingSpecialOfferFromJson([e]) => Log.stub();
  static void errorParsingSpecialOfferDetailsFromJson([e]) => Log.stub();
  static void errorEmotionsOnboardingUpdatePosition([e]) => Log.stub();
  static void errorMoreLikeThisBookNotFound([e]) => Log.stub();
  static void errorMoreLikeThisException([e]) => Log.stub();
  static void errorGetRecommendedBookNotFound([e]) => Log.stub();
  static void errorGetRecommendedException([e]) => Log.stub();
  static void errorShareCaptureStoryImage([e]) => Log.stub();
  static void errorSplashLoadingRequest1([e]) => Log.stub();
  static void errorSplashLoadingRequest2([e]) => Log.stub();
  static void errorSplashLoadingRequest3([e]) => Log.stub();
  static void errorSplashLoadingRequest4([e]) => Log.stub();
  static void errorSplashLoadingData([e]) => Log.stub();
  static void errorIAPSubscriptionNotFoundWhenAskedToSubscribe([e]) =>
      Log.stub();
  static void errorFreeUp2BadSubgenresLength(e) => Log.stub();
  static void errorSharedPreferencesPossibleOOMAndDataDrop(
          core.String key, core.int limitMb) =>
      Log.stub();
  static void errorPlatformDispatcher(
          core.Object error, core.StackTrace stack) =>
      Log.stub();
  static void errorMonetizationSegmentUndefined() => Log.stub();
  static void errorIAPVerificationFailedNoResponse(e) => Log.stub();
  static void errorHivePossibleOOMAndDataDrop(
          core.String key, core.int limitMb) =>
      Log.stub();
  static void errorOpeningHiveBox(e) => Log.stub();
  static void errorFlutter(FlutterErrorDetails flutterErrorDetails) =>
      Log.stub();
  static void errorCrashCandidate(String reason) => Log.stub();
  static void errorParsingFBInstallReferrer(e) => Log.stub();
  static void errorReadingGAID(e) => Log.stub();
  static void errorParsingExpired(e) => Log.stub();

  static void dialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Action hint:"),
        content: Text(message),
      ),
    );
  }
}
