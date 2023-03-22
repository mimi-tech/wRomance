import 'package:flutter/material.dart';
import 'package:womanly_mobile/domain/entities/book.dart';
import 'package:womanly_mobile/presentation/misc/analytics/event_listen_significant_started.dart';

class EventTransitionalNextBookRecommendationListenSignificantStarted
    extends EventListenSignificantStarted {
  EventTransitionalNextBookRecommendationListenSignificantStarted(
      BuildContext context, Book book)
      : super(context, book);
  @override
  String get eventName => 't_nbrec_listen_significant_started';

  @override
  bool get allowedForAppsFlyer => false;
}
