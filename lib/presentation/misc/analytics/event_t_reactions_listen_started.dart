import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:womanly_mobile/domain/entities/book.dart';
import 'package:womanly_mobile/domain/library_state.dart';
import 'package:womanly_mobile/presentation/misc/analytics/analytics_event.dart';
import 'package:womanly_mobile/presentation/misc/analytics/placement.dart';

class EventTReactionsListenStarted extends AnalyticsEvent {
  final BuildContext context;
  final Book book;
  late final _placement = Placement.getLastPlacementForBook(context, book);
  EventTReactionsListenStarted(this.context, this.book);

  @override
  String get eventName => 't_reactions_listen_started';

  @override
  Map<String, dynamic>? get eventProperties => {
        keyTabName: tabName,
        keyPlacement: _placement,
        ...bookProperties(context, book),
        "chapter": book
            .chapters[context.read<LibraryState>().currentChapterIndex ?? 0].id,
      };

  @override
  bool get allowedForAppsFlyer => false;
}
