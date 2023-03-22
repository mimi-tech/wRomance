// enum CommonPrefsKeys

import 'package:shared_preferences/shared_preferences.dart';
import 'package:womanly_mobile/domain/entities/book.dart';
import 'package:womanly_mobile/main.dart';

enum _Keys {
  bookAddedToMyListTs,
}

class CommonPrefs {
  static const _keyAppReviewScore = "CommonPrefs._keyAppReviewScore";
  static const _keyIsPaidUser = "CommonPrefs._keyIsPaidUser";

  static void init(SharedPreferences prefs) {
    sharedPreferences = prefs;
  }

  static int get _now => DateTime.now().millisecondsSinceEpoch;

  static void writeBookAddedToMyList(Book book) {
    sharedPreferences.setInt(
        _keyForBook(_Keys.bookAddedToMyListTs, book), _now);
  }

  static int readBookAddedToMyList(Book book) {
    return sharedPreferences
            .getInt(_keyForBook(_Keys.bookAddedToMyListTs, book)) ??
        0;
  }

  static String _keyForBook(_Keys key, Book book) =>
      "${key.toString()}_${book.id}";

  static int appReviewScore() {
    return sharedPreferences.getInt(_keyAppReviewScore) ?? 0;
  }

  static void setAppReviewScore(int score) {
    sharedPreferences.setInt(_keyAppReviewScore, score);
  }

  static Future<void> setIsPaidUser(bool isPaidUser) async {
    await sharedPreferences.setBool(_keyIsPaidUser, isPaidUser);
  }

  static bool? isPaidUser() {
    return sharedPreferences.getBool(_keyIsPaidUser);
  }
}
