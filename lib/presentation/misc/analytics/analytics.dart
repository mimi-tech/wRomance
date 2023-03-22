import 'dart:async';

import 'package:womanly_mobile/presentation/misc/analytics/analytics_event.dart';
import 'package:womanly_mobile/presentation/misc/analytics/session_manager.dart';
import 'package:womanly_mobile/presentation/misc/log.dart';

enum AnalyticsOnceKey {
  firstOpen,
  bookStarted,
  bookCompleted,
  listenSignificantStarted,
  userSource,
  onceADay,
  eventListenStartedAF,
  eventListenSignificantStartedAF,
  eventBookCompletedUniquesAF,
  eventChapterNCompletedAF,
  eventChapter3Completed,
  eventTNBRecListenStarted,
  eventTNBRecListenSignificantStarted,
  eventTSexQuizListenSignificantStarted,
  tReactionsListenSignificantStarted,
  eventAbTest,
  eventAbTestV2,
  eventPushReceived,
  screenShownFirstTime,
  firstPurchaseAF,
  secondPurchaseAF,
  firstOpenAF,
}

class Analytics {
  static late SessionManager sessionManager;

  static Future<void> updateUserProperties() async {
    Log.stub();
  }

  static void logRevenue(String productId, double price) async {
    Log.stub();
  }

  static void logEvent(AnalyticsEvent event, {bool delayed = false}) async {
    Log.stub();
  }

  static void logEventOnce(AnalyticsEvent event, AnalyticsOnceKey _key,
      {String suffix = ""}) {
    Log.stub();
  }
}
