import 'package:flutter/material.dart';
import 'package:womanly_mobile/presentation/misc/analytics/analytics_event.dart';

class EventFilterUsage extends AnalyticsEvent {
  final BuildContext context;
  final bool isSelected;
  final String name;
  EventFilterUsage(this.context, this.name, this.isSelected);

  @override
  String get eventName => 'filter_usage';

  @override
  Map<String, dynamic>? get eventProperties => {
        keyTabName: tabName,
        keyPlacement: placement(context),
        "action": isSelected ? "select" : "unselect",
        "filter_name": name,
      };
}
