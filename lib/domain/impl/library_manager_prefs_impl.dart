import 'dart:convert';

import 'package:womanly_mobile/data/common_prefs.dart';
import 'package:womanly_mobile/domain/entities/actor.dart';
import 'package:womanly_mobile/domain/entities/enums/player_speed.dart';
import 'package:womanly_mobile/presentation/misc/log.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:womanly_mobile/domain/data_repository.dart';
import 'package:womanly_mobile/domain/entities/progress.dart';
import 'package:womanly_mobile/domain/entities/book.dart';
import 'package:womanly_mobile/domain/library_manager.dart';

enum _Keys {
  myList,
  progress,
  currentBookId,
  finishedBookWithId,
  favoriteAuthors,
  playerSpeed,
  currentReactions,
  savedTime,
  firstUseEmotion,
}

class LibraryManagerPrefsImpl extends LibraryManager {
  final SharedPreferences _preferences;
  final DataRepository _dataRepository;

  LibraryManagerPrefsImpl(this._preferences, this._dataRepository);

  @override
  Set<Book> readMyList() {
    Log.stub();
    return {};
  }

  @override
  void writeMyList(Set<Book> myList) {
    final oldSet = readMyList();
    final booksAdded = myList.difference(oldSet);
    booksAdded.forEach(CommonPrefs.writeBookAddedToMyList);

    final ids = myList.map((it) => it.id).toList();
    Log.stub();
  }

  @override
  //TODO: time consuming to calculate/get frequently
  Map<Book, Progress> readProgress() {
    Log.stub();
    final data = [];
    final books = _dataRepository.books;
    final Map<Book, Progress> result = {};
    try {
      for (String it in data) {
        final json = jsonDecode(it);
        final bookId = json['bookId'];
        final book = books.firstWhere((book) => book.id == bookId);
        final progress = Progress(
          json['chapterIndex'] as int,
          Duration(microseconds: json['position'] as int),
        );
        result.putIfAbsent(book, () => progress);
      }
    } catch (e) {
      Log.print(e);
    }

    return result;
  }

  @override
  void writeProgress(Map<Book, Progress> progress) {
    final data =
        progress.keys.map((book) => progress[book]!.toDto(book.id)).toList();
    Log.stub();
  }

  @override
  Book? readCurrentBook() {
    final bookId = _preferences.getString(_Keys.currentBookId.toString());
    if (bookId == null) {
      return null;
    }

    try {
      return _dataRepository.books.firstWhere((it) => it.id == bookId);
    } catch (e) {
      Log.errorLibraryManagerBookNotFound("[$bookId]");
      return null;
    }
  }

  @override
  void writeCurrentBook(Book? book) {
    if (book == null) {
      _preferences.remove(_Keys.currentBookId.toString());
    } else {
      _preferences.setString(_Keys.currentBookId.toString(), book.id);
    }
  }

  String _keyForFinished(Book book) =>
      "${_Keys.finishedBookWithId.toString()}_${book.id}";

  @override
  bool isFinished(Book book) =>
      _preferences.getBool(_keyForFinished(book)) ?? false;

  @override
  void setFinished(Book book, bool isFinished) {
    if (isFinished) {
      // Analytics.logEventOnce(
      //   EventBookCompleted(globalNavigatorState.currentContext!, book),
      //   AnalyticsOnceKey.bookCompleted,
      //   suffix: book.id,
      // );
      // Analytics.setFirstFinishedBookWasFree(
      //     book.price == MonetizationState.freeProductId);
    }
    _preferences.setBool(_keyForFinished(book), isFinished);
  }

  @override
  void writeFavoriteAuthors(Set<Actor> favoriteAuthors) {
    final ids = favoriteAuthors.map((it) => it.id).toList();
    Log.stub();
  }

  @override
  Set<Actor> readFavoriteAuthors() {
    Log.stub();
    final ids = [];
    return _dataRepository.authors
        .where((it) => it.isAuthor && ids.contains(it.id))
        .toSet();
  }

  String _keyForPlayerSpeed(Book book) =>
      "${_Keys.playerSpeed.toString()}_${book.id}";

  @override
  PlayerSpeed readPlayerSpeed(Book book) {
    final index = _preferences.getInt(_keyForPlayerSpeed(book)) ?? 0;
    return PlayerSpeed.values[index];
  }

  @override
  void writePlayerSpeed(PlayerSpeed speed, Book book) {
    _preferences.setInt(_keyForPlayerSpeed(book), speed.index);
  }

  @override
  void writeCurrentReactions(int count, int timeNow, Book book) {
    _preferences.setInt(
        "${_Keys.currentReactions.toString()}_${book.id}", count);
    _preferences.setInt("${_Keys.savedTime.toString()}_${book.id}", timeNow);
  }

  @override
  int readCurrentReactions(Book book) {
    final value = _preferences
            .getInt("${_Keys.currentReactions.toString()}_${book.id}") ??
        588;
    return value;
  }

  @override
  int readSavedTime(Book book) {
    final value =
        _preferences.getInt("${_Keys.savedTime.toString()}_${book.id}") ??
            DateTime.now().millisecondsSinceEpoch;
    return value;
  }

  @override
  bool? readFirstUseEmotion() {
    final value = _preferences.getBool(_Keys.firstUseEmotion.toString());
    return value;
  }

  @override
  void writeFirstUseEmotion(bool value) {
    _preferences.setBool(_Keys.firstUseEmotion.toString(), value);
  }
}

extension _ProgressX on Progress {
  String toDto(String bookId) => jsonEncode({
        'bookId': bookId,
        'chapterIndex': chapterIndex,
        'position': position.inMicroseconds,
      });
}
