import 'package:flutter/material.dart';
import 'package:womanly_mobile/domain/entities/book.dart';
import 'package:womanly_mobile/presentation/misc/analytics/analytics_event.dart';
import 'package:womanly_mobile/presentation/misc/analytics/placement.dart';

class Event15SecUsage extends AnalyticsEvent {
  final bool isBack;
  final BuildContext context;
  final Book book;
  Event15SecUsage(
    this.context, {
    required this.isBack,
    required this.book,
  });

  @override
  String get eventName => 'jump_15sec_usage';

  @override
  Map<String, dynamic>? get eventProperties {
    final _placement = Placement.getLastPlacementForBook(context, book);
    return {
      "action": isBack ? "back" : "forward",
      keyPlacement: _placement,
    };
  }
}
