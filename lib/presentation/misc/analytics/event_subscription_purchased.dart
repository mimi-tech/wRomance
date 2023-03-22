import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:womanly_mobile/domain/data_repository.dart';
import 'package:womanly_mobile/domain/entities/book.dart';
import 'package:womanly_mobile/domain/library_state.dart';
import 'package:womanly_mobile/main.dart';
import 'package:womanly_mobile/presentation/misc/analytics/analytics.dart';
import 'package:womanly_mobile/presentation/misc/analytics/analytics_event.dart';
import 'package:womanly_mobile/presentation/misc/analytics/placement.dart';

class EventSubscriptionPurchased extends AnalyticsEvent {
  final BuildContext context;
  final Book? book;
  final String subscriptionProductId;
  final double priceUsd;
  final String usePlacement;
  final String useSubplacement;
  EventSubscriptionPurchased(
    this.context,
    this.book, {
    required this.subscriptionProductId,
    required this.priceUsd,
    required this.usePlacement,
    required this.useSubplacement,
  }) {}

  @override
  String get eventName => 'sub_purchased';

  @override
  Map<String, dynamic>? get eventProperties {
    final libraryState = context.read<LibraryState>();
    final finishedBooksCount = context
        .read<DataRepository>()
        .books
        .where((it) => libraryState.isFinished(it))
        .map((it) => it.id)
        .length;

    return {
      "action": "purchase",
      "subscription_type": "hybrid",
      "plan_name": subscriptionProductId,
      "trial_period": "none",
      "billing_period": {
            "book_3_months": "3 months",
            "book_6_months": "6 months",
            "book_1_year": "1 year",
          }[subscriptionProductId] ??
          "unknown",
      "offer_name":
          "none", //offer here means subscription offer in Google Play, currently not supported
      "price_sub_original": priceUsd,
      "price_sub_final": priceUsd,
      "t_subscription_initiates": "stub",
      "books-purchased_cumulative": "stub",
      "books-completed_cumulative": "stub",
      "sub_placement": useSubplacement,
      // "event_count": bookNumberForInstance(context),
      if (book != null) ...{
        "book_placement": usePlacement,
        ...bookProperties(context, book!, usePlacement),
      },
    };
  }
}
