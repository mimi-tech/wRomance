import 'package:womanly_mobile/presentation/misc/analytics/analytics_event.dart';

class EventAbTestV1 extends AnalyticsEvent {
  final String name;
  final String group;

  EventAbTestV1({
    required this.name,
    required this.group,
  });

  @override
  String get eventName => 'ab_${name}_$group';

  @override
  Map<String, dynamic>? get eventProperties => null;
}
