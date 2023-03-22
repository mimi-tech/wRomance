import 'package:flutter/material.dart';
import 'package:womanly_mobile/domain/entities/series.dart';
import 'package:womanly_mobile/presentation/misc/analytics/analytics_event.dart';

class EventSeriesOpen extends AnalyticsEvent {
  final Series series;
  final BuildContext context;
  EventSeriesOpen(this.series, this.context);

  @override
  String get eventName => 'series_open';

  @override
  Map<String, dynamic>? get eventProperties {
    final _placement = placement(context);
    return {
      "series_id": series.id,
      "series_name": series.title,
      keyPlacement: _placement,
    };
  }
}
