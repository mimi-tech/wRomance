import 'dart:convert';
import 'dart:math';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:womanly_mobile/data/models/book_model.dart';
import 'package:womanly_mobile/data/models/poll_model.dart';
import 'package:womanly_mobile/data/models/series_model.dart';
import 'package:womanly_mobile/data/models/featured_model.dart';
import 'package:womanly_mobile/data/models/trope_model.dart';
import 'package:womanly_mobile/data/storage_manager.dart';
import 'package:womanly_mobile/domain/entities/book.dart';
import 'package:womanly_mobile/domain/entities/enums/featured_style.dart';
import 'package:womanly_mobile/domain/entities/enums/featured_type.dart';
import 'package:womanly_mobile/domain/entities/featured.dart';
import 'package:womanly_mobile/domain/entities/trope.dart';
import 'package:womanly_mobile/main.dart';
import 'package:womanly_mobile/presentation/misc/config/remote_config.dart';
import 'package:womanly_mobile/presentation/misc/exceptions.dart';
import 'package:womanly_mobile/presentation/misc/log.dart';

class StorageManagerImpl extends StorageManager {
  dynamic _booksObj = {};
  dynamic _seriesObj = {};
  dynamic _featuredObj = {};
  dynamic _tropesObj = {};

  final SharedPreferences prefs;

  StorageManagerImpl({
    required String booksJson,
    required String seriesJson,
    required String featuredJson,
    required String tropesJson,
    required this.prefs,
  }) {
    try {
      _booksObj = jsonDecode(booksJson);
    } catch (e) {
      throw JsonParsingException(e, "books");
    }

    try {
      _seriesObj = jsonDecode(seriesJson);
    } catch (e) {
      throw JsonParsingException(e, "series");
    }

    try {
      _featuredObj = jsonDecode(featuredJson);
    } catch (e) {
      throw JsonParsingException(e, "featured");
    }

    try {
      _tropesObj = jsonDecode(tropesJson);
    } catch (e) {
      throw JsonParsingException(e, "tropes");
    }
  }

  @override
  List<BookModel> readBooks() {
    final result = (_booksObj as List<dynamic>)
        .map((it) => BookModel.fromJson(it))
        .where((it) => it != null)
        .cast<BookModel>()
        .toList();

    return result;
  }

  @override
  List<FeaturedModel> readFeatures(List<Book> books) {
    final result = _shuffleFeatured((_featuredObj as List<dynamic>)
        .map((it) => FeaturedModel.fromJson(it, books))
        .where((it) => it != null)
        .cast<FeaturedModel>()
        .toList());

    if (RemoteConfig.isEmotionsEnabled) {
      result.insert(
        0,
        FeaturedModel(
          title: "Emotions",
          books: books.where((it) => it.isSharingEmotionsEnabled).toList(),
          style: FeaturedStyle.emotions,
          type: FeaturedType.books,
        ),
      );
      result.removeWhere((it) => it.style == FeaturedStyle.fullSize);
    }

    return result;
  }

  @override
  List<SeriesModel> readSeries(List<BookModel> books) {
    final Map<String, BookModel> idToBook =
        Map.fromIterables(books.map((it) => it.id), books);

    return (_seriesObj as List<dynamic>)
        .map((it) => SeriesModel.fromJson(it, idToBook))
        .where((it) => it != null)
        .cast<SeriesModel>()
        .toList();
  }

  @override
  List<Trope> readTropes() {
    final result = (_tropesObj['tropes'] as List<dynamic>)
        .map((it) => TropeModel.fromJson(it))
        .toList();

    return result;
  }

  static const _keyShuffledFeaturedStamp =
      "StorageManagerImpl._shuffledFeaturedStamp";
  List<FeaturedModel> _shuffleFeatured(List<FeaturedModel> list) {
    final stamp =
        list.map((it) => it.books.map((book) => book.id).join(',')).join(';');
    final savedStamp = prefs.getString(_keyShuffledFeaturedStamp);

    for (var featured in list) {
      _removeDuplicates(featured.books);
    }

    if (savedStamp != stamp) {
      prefs.setString(_keyShuffledFeaturedStamp, stamp);
    } else {
      list = shuffle(list);
    }
    return list;
  }

  static List<FeaturedModel> shuffle(List<FeaturedModel> list) {
    final random = Random(DateTime.now().millisecond);
    final Set<Book> usedBooks = {};
    for (var featured in list) {
      final books = featured.books;
      books.shuffle(random);
      if (books.length > 2) {
        final firstBook = books[0];
        final secondBook = books[1];
        if (usedBooks.contains(firstBook)) {
          _swap(books, 0, books.length - 1);
        }
        if (usedBooks.contains(secondBook)) {
          _swap(books, 1, books.length - 2);
        }
        usedBooks.add(firstBook);
        usedBooks.add(secondBook);
      } else {
        usedBooks.addAll(books);
      }
    }
    return list;
  }

  static void _swap(List list, int indexA, int indexB) {
    final a = list[indexA];
    final b = list[indexB];
    list.removeAt(indexA);
    list.insert(indexA, b);
    list.removeAt(indexB);
    list.insert(indexB, a);
  }

  void _removeDuplicates<T>(List<T> list) {
    Set<T> unique = {};
    List<int> indexesToDelete = [];
    for (int i = 0; i < list.length; i++) {
      final item = list[i];
      if (unique.contains(item)) {
        indexesToDelete.add(i);
      }
      unique.add(item);
    }
    for (int i = 0; i < indexesToDelete.length; i++) {
      list.removeAt(indexesToDelete[i] - i);
    }
  }
}
