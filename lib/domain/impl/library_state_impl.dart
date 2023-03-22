import 'dart:convert';

import 'package:womanly_mobile/domain/entities/actor.dart';
import 'package:womanly_mobile/domain/entities/enums/player_speed.dart';
import 'package:womanly_mobile/domain/entities/progress.dart';
import 'package:womanly_mobile/domain/entities/book.dart';
import 'package:womanly_mobile/domain/library_manager.dart';
import 'package:womanly_mobile/domain/library_state.dart';
import 'package:womanly_mobile/presentation/misc/analytics/book_statistics.dart';
import 'package:womanly_mobile/presentation/misc/extensions.dart';
import 'package:womanly_mobile/presentation/misc/log.dart';

class LibraryStateImpl extends LibraryState {
  final LibraryManager _manager;

  LibraryStateImpl(this._manager) {
    _myList = _manager.readMyList();
    _favoriteAuthors = _manager.readFavoriteAuthors();
    _progress = _manager.readProgress();
    _currentBook = _manager.readCurrentBook();
    _firstUseEmotion = _manager.readFirstUseEmotion();
  }

  @override
  Book? get currentBook => _currentBook;
  Book? _currentBook;

  final Map<Book, bool> _finishedBooks = {};

  @override
  PlayerSpeed get playerSpeed {
    final book = currentBook;
    if (book == null) {
      return PlayerSpeed.x1;
    }
    final value = _playerSpeed[book] ?? _manager.readPlayerSpeed(book);
    _playerSpeed[book] = value;
    return value;
  }

  final Map<Book, PlayerSpeed> _playerSpeed = {};

  @override
  int? get currentChapterIndex => _currentChapterIndex;
  int? _currentChapterIndex;

  @override
  bool? get isFirstUseEmotion => _firstUseEmotion;
  late bool? _firstUseEmotion;

  @override
  int currentReactions(Book book) {
    final value = _manager.readCurrentReactions(book);
    return value;
  }

  @override
  int savedTime(Book book) {
    final value = _manager.readSavedTime(book);
    return value;
  }

  @override
  Set<Book> get myList => _myList;
  Set<Book> _myList = {};

  @override
  Set<Actor> get favoriteAuthors => _favoriteAuthors;
  Set<Actor> _favoriteAuthors = {};

  @override
  Progress getProgress(Book book) =>
      _progress[book] ?? Progress(0, Duration.zero);
  Map<Book, Progress> _progress = {};

  @override
  void setCurrentBook(Book? book) {
    _currentBook = book;
    _manager.writeCurrentBook(book);
    final index = _progress[book]?.chapterIndex;
    _currentChapterIndex = index;
    if (index != null) {
      BookStatistics.onCurrentChapterChanged(index);
    }
    notifyListeners();
  }

  @override
  void setCurrentChapter(int index) {
    _currentChapterIndex = index;
    BookStatistics.onCurrentChapterChanged(index);
    notifyListeners();
  }

  @override
  //TODO: refactor to update one at a time
  void addToMyList(Book book) {
    _myList.add(book);
    _manager.writeMyList(_myList);
    notifyListeners();
  }

  @override
  //TODO: refactor to update one at a time
  void removeFromMyList(Book book) {
    _myList.remove(book);
    _manager.writeMyList(_myList);
    notifyListeners();
  }

  @override
  void updateCurrentProgress(Duration duration) {
    final book = currentBook;
    final index = currentChapterIndex;
    if (book != null && index != null) {
      BookStatistics.updateChapterCompleteness(book, index, duration);

      if (index == 0 && duration.inMilliseconds < 500) {
        //fix for chapter 0-1 'isStarted' glitch on Continue screen
        return;
      }

      final newProgress = Progress(index, duration);
      _progress[book] = newProgress;
      // NoMoreThan(const Duration(seconds: 1), _persistProgress);
      if (book.isFormallyFinished(newProgress)) {
        setFinished(book, true);
      }
      if (isFinished(book) && book.isTimeToShowRecommendations(newProgress)) {
        // NoMoreThan(const Duration(seconds: 10), RecommendationsScreen.show);
      }
      notifyListeners();
    }
  }

  void _persistProgress() {
    _manager.writeProgress(_progress);
  }

  @override
  void setBookProgress(Book book, Progress progress) {
    _progress[book] = progress;
    if (book.isFormallyFinished(progress)) {
      setFinished(book, true);
    }
    _manager.writeProgress(_progress);
    notifyListeners();
  }

  @override
  bool isFinished(Book book) {
    final value = _finishedBooks[book] ?? _manager.isFinished(book);
    _finishedBooks[book] = value;
    return value;
  }

  @override
  void setFinished(Book book, bool isFinished) {
    if (_finishedBooks[book] == isFinished) {
      return;
    }

    _finishedBooks[book] = isFinished;
    _manager.setFinished(book, isFinished);
    if (isFinished) {
      BookStatistics.updateFinishedPaidCount(this);
      // Analytics.increaseValueForKey(Analytics.keyBooksCompletedCumulative);
    }
    notifyListeners();
  }

  @override
  void addFavoriteAuthor(Actor author) {
    _favoriteAuthors.add(author);
    _manager.writeFavoriteAuthors(_favoriteAuthors);
    _sendLikeAuthorToServer(author, true);
    notifyListeners();
  }

  @override
  void removeFavoriteAuthor(Actor author) {
    _favoriteAuthors.remove(author);
    _manager.writeFavoriteAuthors(_favoriteAuthors);
    _sendLikeAuthorToServer(author, false);
    notifyListeners();
  }

  @override
  void setPlayerSpeed(PlayerSpeed speed) {
    final book = currentBook;
    if (book == null || _playerSpeed[book] == speed) {
      return;
    }
    _playerSpeed[book] = speed;
    _manager.writePlayerSpeed(speed, book);
    notifyListeners();
  }

  void _sendLikeAuthorToServer(Actor author, bool like) async {
    Log.stub();
  }

  @override
  void setCurrentReactions(int count, int timeNow, Book book) {
    _manager.writeCurrentReactions(count, timeNow, book);
    notifyListeners();
  }

  @override
  void setFirstUseEmotion(bool value) {
    _manager.writeFirstUseEmotion(value);
    notifyListeners();
  }
}
