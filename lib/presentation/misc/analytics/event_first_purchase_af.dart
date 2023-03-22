import 'package:flutter/material.dart';
import 'package:womanly_mobile/domain/entities/book.dart';
import 'package:womanly_mobile/presentation/misc/analytics/analytics_event.dart';

class EventFirstPurchaseAF extends AnalyticsEvent {
  final Book book;
  final BuildContext context;
  EventFirstPurchaseAF(this.context, this.book);

  @override
  String get eventName => 'af_first_purchase';

  @override
  bool get allowedForAmplitude => false;
  @override
  bool get allowedForAppsFlyer => true;

  @override
  Map<String, dynamic>? get eventProperties => {
        "af_content_id": book.id,
      };
}
