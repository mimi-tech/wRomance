import 'package:womanly_mobile/domain/entities/actor.dart';
import 'package:womanly_mobile/domain/entities/book.dart';
import 'package:womanly_mobile/domain/entities/enums/player_speed.dart';
import 'package:womanly_mobile/domain/entities/progress.dart';

abstract class LibraryManager {
  Set<Book> readMyList();
  Map<Book, Progress> readProgress();
  void writeMyList(Set<Book> myList);
  void writeProgress(Map<Book, Progress> progress);
  void writeCurrentBook(Book? book);
  Book? readCurrentBook();
  bool isFinished(Book book);
  void setFinished(Book book, bool isFinished);
  Set<Actor> readFavoriteAuthors();
  void writeFavoriteAuthors(Set<Actor> favoriteAuthors);
  PlayerSpeed readPlayerSpeed(Book book);
  void writePlayerSpeed(PlayerSpeed speed, Book book);
  int readCurrentReactions(Book book);
  int readSavedTime(Book book);
  void writeCurrentReactions(int count, int timeNow, Book book);
  void writeFirstUseEmotion(bool value);
  bool? readFirstUseEmotion();
  // void writeShowedAfterEmotion(bool value);
  // bool readShowedAfterEmotion();
}
