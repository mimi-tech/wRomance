import 'package:womanly_mobile/domain/entities/book.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:womanly_mobile/presentation/misc/analytics/event_listen_significant_started.dart';

class EventListen3ChaptersCompleted extends EventListenSignificantStarted {
  EventListen3ChaptersCompleted(BuildContext context, Book book)
      : super(context, book);

  @override
  String get eventName => 'listen_3chapters_completed';

  @override
  bool get allowedForAppsFlyer => false;
}
