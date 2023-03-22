import 'package:womanly_mobile/presentation/misc/analytics/analytics_event.dart';

class EventAbTestV2 extends AnalyticsEvent {
  final String name;
  final String group;

  EventAbTestV2({
    required this.name,
    required this.group,
  });

  @override
  String get eventName => 'ab_test';

  @override
  Map<String, dynamic>? get eventProperties => {
        "ab_name": name,
        "ab_variant": group,
      };
}
