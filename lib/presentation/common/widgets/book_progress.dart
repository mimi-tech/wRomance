import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:womanly_mobile/domain/entities/book.dart';
import 'package:womanly_mobile/domain/entities/progress.dart';
import 'package:womanly_mobile/domain/library_state.dart';
import 'package:womanly_mobile/presentation/misc/extensions.dart';
import 'package:womanly_mobile/presentation/theme/theme_colors.dart';
import 'package:womanly_mobile/presentation/theme/theme_text_style.dart';

class BookProgress extends StatelessWidget {
  final Book book;
  final bool showBadgeIfFinished;
  const BookProgress(this.book, {this.showBadgeIfFinished = false, Key? key})
      : super(key: key);

  static const _radius = BorderRadius.all(Radius.circular(10));

  @override
  Widget build(BuildContext context) {
    final progress = context
        .select<LibraryState, Progress>((state) => state.getProgress(book));
    final bookPosition = book.position(progress);
    final totalDuration = book.totalDuration;
    final currentBookProgress =
        bookPosition.inMilliseconds / totalDuration.inMilliseconds.toDouble();

    final durationLeft = Duration(
        milliseconds:
            totalDuration.inMilliseconds - bookPosition.inMilliseconds);

    final isFinished = context.select<LibraryState, bool>((state) =>
        state.isFinished(
            book)); //TODO: isFinished obscuration: on reading now we need to show progress, in series we need to mark as finished

    final showFinishedLabelAndBadge =
        showBadgeIfFinished || durationLeft.inMinutes < 1;

    return Column(
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 2),
              child: Text(
                isFinished && showFinishedLabelAndBadge
                    ? ""
                    : durationLeft.hoursAndMinutesFull,
                style: ThemeTextStyle.s10w600.copyWith(
                  color: Colors.white.withOpacity(0.8),
                  letterSpacing: 0.5,
                ),
              ),
            ),
            // if (isFinished && showFinishedLabelAndBadge)
            //   Padding(
            //     padding: const EdgeInsets.only(left: 3),
            //     child: Image.asset(
            //       "assets/images/icons/finished.png",
            //       width: 10,
            //       height: 10,
            //     ),
            //   ),
          ],
        ),
        if ((bookPosition.inSeconds > 1 && !isFinished) ||
            (!showBadgeIfFinished &&
                !(isFinished && showFinishedLabelAndBadge)))
          Container(
            height: 3,
            margin: const EdgeInsets.only(top: 6),
            decoration: const BoxDecoration(
              color: ThemeColors.accentBlueButtons,
              borderRadius: _radius,
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: FractionallySizedBox(
                widthFactor: min(1, currentBookProgress),
                child: Container(
                  height: 3,
                  decoration: const BoxDecoration(
                    color: ThemeColors.accentBlue,
                    borderRadius: _radius,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
