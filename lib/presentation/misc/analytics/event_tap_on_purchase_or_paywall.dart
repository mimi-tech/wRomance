import 'package:flutter/material.dart';
import 'package:womanly_mobile/domain/entities/book.dart';
import 'package:womanly_mobile/presentation/misc/analytics/analytics_event.dart';

class EventTapOnPurchaseOrPaywall extends AnalyticsEvent {
  final String _placement;
  final String? _subplacement;
  final Book? book;
  final BuildContext context;
  final int step;
  final String stepComment;

  /// 'true' for book purchases, false for subscription attempts
  final bool isBookPurchaseEvent;
  final String? paywallPlacement;
  EventTapOnPurchaseOrPaywall(
    this._placement,
    this._subplacement,
    this.context,
    this.book, {
    required this.step,
    required this.stepComment,
    required this.isBookPurchaseEvent,
    this.paywallPlacement, //TODO: make required (analytics work for hybrid/subscription part)
  });

  @override
  String get eventName =>
      isBookPurchaseEvent ? 'tap_on_purchase' : 'tap_on_paywall';

  @override
  Map<String, dynamic>? get eventProperties {
    final result = {
      keyPlacement: _placement,
      if (book != null) ...bookProperties(context, book!, _placement),
      "step": step,
      "step_comment": stepComment,
    };

    if (!isBookPurchaseEvent) {
      result.addAll({
        "paywall_placement": paywallPlacement, //"book",
        "book_placement": _placement,
      });
    }

    if (eventName == "tap_on_paywall") {
      result.addAll({
        "sub_placement": _subplacement,
        "subscription_type": "hybrid",
      });
    }

    return result;
  }
}
