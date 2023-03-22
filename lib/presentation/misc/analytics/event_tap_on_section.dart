// ignore_for_file: constant_identifier_names

import 'package:womanly_mobile/presentation/misc/analytics/analytics_event.dart';

enum SectionMyList {
  reading_now,
  read_later,
  finished,
}

enum SectionSearch {
  search_by_tropes,
  search_by_authors,
}

class EventTapOnSection extends AnalyticsEvent {
  final dynamic section;

  EventTapOnSection(this.section);

  @override
  String get eventName => 'tap_on_section';

  @override
  Map<String, dynamic>? get eventProperties => {
        "section_name":
            (section is String) ? section : section.toString().split('.')[1],
      };
}
