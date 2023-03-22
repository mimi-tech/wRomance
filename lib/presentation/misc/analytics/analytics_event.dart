import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:womanly_mobile/domain/entities/book.dart';
import 'package:womanly_mobile/presentation/misc/analytics/placement.dart';
import 'package:womanly_mobile/presentation/misc/log.dart';

abstract class AnalyticsEvent {
  final String keyTabName = "tab_name";
  final String keyPlacement = "placement";

  static const String _keyWillExpireInDays =
      "AnalyticsEvent._keyWillExpireInDays";

  String get tabName => "stub";
  String placement(BuildContext context) => context.read<Placement>().name;

  String get eventName;
  Map<String, dynamic>? get eventProperties;

  bool get allowed => true;
  bool get allowedForAmplitude => true;
  bool get allowedForAppsFlyer => false;
  int bookNumberForInstance(BuildContext context, [String suffix = ""]) {
    if (_bookNumberForInstance == null) {
      final prefs = context.read<SharedPreferences>();
      final key = "AnalyticsEvent.key.book_number_for_$eventName$suffix";
      var value = prefs.getInt(key) ?? 0;
      value++;
      prefs.setInt(key, value);
      _bookNumberForInstance = value;
    }
    return _bookNumberForInstance!;
  }

  int bookNumberForInstanceUnique(BuildContext context, String suffix) {
    Log.stub();
    return -1;
  }

  int? _bookNumberForInstance;

  Map<String, dynamic> bookProperties(BuildContext context, Book book,
      [String? usePlacement]) {
    Log.stub();
    return {};
  }
}
