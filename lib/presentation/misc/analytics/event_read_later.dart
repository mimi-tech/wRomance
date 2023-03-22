import 'package:flutter/material.dart';
import 'package:womanly_mobile/domain/entities/book.dart';
import 'package:womanly_mobile/domain/entities/series.dart';
import 'package:womanly_mobile/presentation/misc/analytics/analytics_event.dart';

class EventReadLater extends AnalyticsEvent {
  final Book book;
  final Series? series;
  final bool isBookAdded;
  final BuildContext context;
  EventReadLater(this.context, this.book, this.series, this.isBookAdded);

  @override
  String get eventName => 'read_later';

  @override
  Map<String, dynamic>? get eventProperties => {
        "action": isBookAdded ? 'add' : 'remove',
        keyTabName: tabName,
        keyPlacement: placement(context),
        ...bookProperties(context, book),
        "book_number": bookNumberForInstance(context, "$isBookAdded"),
      };
}
