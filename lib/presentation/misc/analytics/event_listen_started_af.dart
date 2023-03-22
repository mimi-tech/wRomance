import 'package:flutter/material.dart';
import 'package:womanly_mobile/domain/entities/book.dart';
import 'package:womanly_mobile/presentation/misc/analytics/event_listen_started.dart';

class EventListenStartedAF extends EventListenStarted {
  EventListenStartedAF(BuildContext context, Book book) : super(context, book);

  @override
  String get eventName => 'm_listen_started';

  @override
  bool get allowedForAmplitude => false;
  @override
  bool get allowedForAppsFlyer => true;
}
