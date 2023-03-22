import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:womanly_mobile/domain/entities/book.dart';
import 'package:womanly_mobile/domain/entities/chapter.dart';
import 'package:womanly_mobile/domain/library_state.dart';
import 'package:womanly_mobile/presentation/misc/log.dart';
import 'package:womanly_mobile/presentation/misc/payments/special_offer.dart';

class Experiments {
  static const _keyReadyForHybridMonetization =
      "Experiments.key.readyForHybridMonetization";

  static Chapter _chapter(BuildContext context, Book book) {
    final libraryState = context.read<LibraryState>();
    if (libraryState.currentBook == book) {
      return book.chapters[libraryState.currentChapterIndex ?? 0];
    } else {
      return book.chapters[libraryState.getProgress(book).chapterIndex];
    }
  }

  static List<Widget>? resolveListenButtonTitle(
      BuildContext context, Book book, TextStyle textStyle, bool onlyPurchase) {
    Log.stub();
  }

  static String? resolveListenButtonSubtitle(BuildContext context, Book book) {
    Log.stub();
  }

  static bool resolveAllowedFreeBooks() {
    Log.stub();
    return true;
  }

  static bool resolveIsAllowedToListenBook(BuildContext context, Book book) {
    Log.stub();

    return false;
  }

  static void onCurrentChapterChanged(
      BuildContext? context, Book book, Chapter chapter) {
    Log.stub();
  }

  static bool resolvePauseMomentOnPlayingChanged(Book? book) {
    Log.stub();
    return false;
  }

  static void resolveSuccessfulPaymentIAP(
      Book book, String purchaseSubplacement) {
    Log.stub();
  }

  static SpecialOffer? resolveSpecialOffer(String Function(String) priceFor) {
    Log.stub();
  }

  static bool isReadyForHybrid() {
    Log.stub();

    return false;
  }
}
