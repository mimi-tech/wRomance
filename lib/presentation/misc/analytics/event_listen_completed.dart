import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:womanly_mobile/domain/audio_player.dart';
import 'package:womanly_mobile/domain/entities/book.dart';
import 'package:womanly_mobile/domain/entities/enums/player_speed.dart';
import 'package:womanly_mobile/domain/library_state.dart';
import 'package:womanly_mobile/presentation/misc/analytics/analytics.dart';
import 'package:womanly_mobile/presentation/misc/analytics/analytics_event.dart';
import 'package:womanly_mobile/presentation/misc/analytics/book_statistics.dart';
import 'package:womanly_mobile/presentation/misc/analytics/event_chapter1_completed_af.dart';
import 'package:womanly_mobile/presentation/misc/analytics/event_chapter2_completed_af.dart';
import 'package:womanly_mobile/presentation/misc/analytics/event_chapter3_completed_af.dart';
import 'package:womanly_mobile/presentation/misc/analytics/event_listen_3chapters_completed.dart';
import 'package:womanly_mobile/presentation/misc/analytics/placement.dart';
import 'package:womanly_mobile/presentation/misc/log.dart';

class EventListenCompleted extends AnalyticsEvent {
  final BuildContext context;
  final Book book;
  EventListenCompleted(this.context, this.book) {
    final chapterId =
        book.chapters[context.read<LibraryState>().currentChapterIndex ?? 0].id;
    final reason = BookStatistics.playbackPauseReason;

    if (reason == PlaybackPauseReason.chapter_ended) {
      switch (chapterId) {
        case 2001:
          Analytics.logEventOnce(
            EventChapter1CompletedAF(),
            AnalyticsOnceKey.eventChapterNCompletedAF,
            suffix: "1",
          );
          break;
        case 2002:
          Analytics.logEventOnce(
            EventChapter2CompletedAF(),
            AnalyticsOnceKey.eventChapterNCompletedAF,
            suffix: "2",
          );
          break;
        case 2003:
          Analytics.logEventOnce(
            EventChapter3CompletedAF(),
            AnalyticsOnceKey.eventChapterNCompletedAF,
            suffix: "3",
          );
          Analytics.logEventOnce(
            EventListen3ChaptersCompleted(context, book),
            AnalyticsOnceKey.eventChapter3Completed,
            suffix: "3_${book.id}",
          );
          break;
      }
    }
    Log.print("==ELC: $chapterId $reason");
  }

  @override
  String get eventName => 'listen_completed';

  @override
  Map<String, dynamic>? get eventProperties => {
        keyTabName: tabName,
        keyPlacement: Placement.getLastPlacementForBook(context, book),
        ...bookProperties(context, book),
        "chapter": book
            .chapters[context.read<LibraryState>().currentChapterIndex ?? 0].id,
        "speed": context.read<AudioPlayer>().speed.description,
        "actual_duration": BookStatistics.chapterListeningTimeMinutes(),
        "chapter_completeness":
            BookStatistics.getChapterCompleteness(context, book),
        "reason": BookStatistics.getPlaybackPauseReasonString(),
      };
}
