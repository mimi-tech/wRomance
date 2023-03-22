import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:womanly_mobile/presentation/misc/analytics/event_tap_on_contact_support.dart';
import 'package:womanly_mobile/presentation/misc/log.dart';

import 'analytics/analytics.dart';

class Utils {
  static void contactUs({
    required bool logAnalytics,
    String? analyticsSource,
    String? subject,
    String? body,
  }) async {
    Log.stub();
  }
}
