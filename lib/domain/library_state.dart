import 'package:flutter/material.dart';
import 'package:womanly_mobile/domain/entities/actor.dart';
import 'package:womanly_mobile/domain/entities/book.dart';
import 'package:womanly_mobile/domain/entities/enums/player_speed.dart';
import 'package:womanly_mobile/domain/entities/progress.dart';

abstract class LibraryState extends ChangeNotifier {
  Book? get currentBook;
  int? get currentChapterIndex;
  int currentReactions(Book book);
  int savedTime(Book book);
  Set<Book> get myList;
  Set<Actor> get favoriteAuthors;
  Progress getProgress(Book book);
  bool isFinished(Book book);
  PlayerSpeed get playerSpeed;
  bool? get isFirstUseEmotion;

  void setCurrentBook(Book? book);
  void setCurrentChapter(int index);
  void addToMyList(Book book);
  void removeFromMyList(Book book);
  void updateCurrentProgress(Duration duration);
  void setBookProgress(Book book, Progress progress);
  void setFinished(Book book, bool isFinished);
  void addFavoriteAuthor(Actor author);
  void removeFavoriteAuthor(Actor author);
  void setPlayerSpeed(PlayerSpeed speed);
  void setCurrentReactions(int count, int timeNow, Book book);
  void setFirstUseEmotion(bool value);

  // void sendPushTokenToServer(String token);
}
