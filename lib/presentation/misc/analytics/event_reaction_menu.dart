import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:womanly_mobile/domain/entities/book.dart';
import 'package:womanly_mobile/domain/library_state.dart';
import 'package:womanly_mobile/presentation/misc/analytics/analytics_event.dart';
import 'package:womanly_mobile/presentation/misc/analytics/book_statistics.dart';
import 'package:womanly_mobile/presentation/misc/analytics/placement.dart';

class EventReactionMenu extends AnalyticsEvent {
  final BuildContext context;
  final Book book;
  final String action;
  EventReactionMenu(this.context, this.book, this.action);

  @override
  String get eventName => 'reaction_menu';

  @override
  Map<String, dynamic>? get eventProperties => {
        "action": action,
        keyPlacement: Placement.getLastPlacementForBook(context, book),
        ...bookProperties(context, book),
        "chapter": book
            .chapters[context.read<LibraryState>().currentChapterIndex ?? 0].id,
        "chapter_completeness":
            BookStatistics.getChapterCompleteness(context, book),
        keyTabName: tabName,
      };
}
