import 'package:flutter/material.dart';
import 'package:womanly_mobile/domain/entities/book.dart';
import 'package:womanly_mobile/domain/entities/series.dart';
import 'package:womanly_mobile/presentation/misc/analytics/analytics_event.dart';

class EventStartSample extends AnalyticsEvent {
  final Book book;
  final Series? series;
  final BuildContext context;
  EventStartSample(this.context, this.book, this.series);

  @override
  String get eventName => 'start_sample';

  @override
  Map<String, dynamic>? get eventProperties => {
        keyPlacement: placement(context),
        ...bookProperties(context, book),
      };
}
