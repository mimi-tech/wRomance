import 'package:flutter/material.dart';
import 'package:womanly_mobile/domain/entities/book.dart';
import 'package:womanly_mobile/presentation/misc/analytics/event_listen_started.dart';

class EventTransitionalNextBookRecommendationListenStarted
    extends EventListenStarted {
  EventTransitionalNextBookRecommendationListenStarted(
      BuildContext context, Book book)
      : super(context, book);
  @override
  String get eventName => 't_nbrec_listen_started';

  @override
  bool get allowedForAppsFlyer => false;
}
