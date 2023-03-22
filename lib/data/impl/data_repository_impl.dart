import 'dart:collection';
import 'dart:convert';

import 'package:womanly_mobile/data/models/book_model.dart';
import 'package:womanly_mobile/data/models/featured_model.dart';
import 'package:womanly_mobile/data/models/series_model.dart';
import 'package:womanly_mobile/domain/data_repository.dart';
import 'package:womanly_mobile/domain/entities/actor.dart';
import 'package:womanly_mobile/domain/entities/poll.dart';
import 'package:womanly_mobile/domain/entities/series.dart';
import 'package:womanly_mobile/domain/entities/featured.dart';
import 'package:womanly_mobile/domain/entities/book.dart';
import 'package:womanly_mobile/data/storage_manager.dart';
import 'package:womanly_mobile/domain/entities/trope.dart';
import 'package:womanly_mobile/presentation/misc/exceptions.dart';
import 'package:womanly_mobile/presentation/misc/extensions.dart';
import 'package:womanly_mobile/presentation/misc/log.dart';
import 'package:womanly_mobile/test_data/json_test_author.dart';

class DataRepositoryImpl extends DataRepository {
  final StorageManager _manager;

  DataRepositoryImpl(this._manager);

  List<BookModel>? _books;
  List<Actor>? _authors;
  List<FeaturedModel>? _featured;
  List<SeriesModel>? _series;
  List<String>? _topTropes;
  List<Trope>? _tropes;
  Map<String, int>? _tropesCount;
  Poll? _poll;
  final Map<Actor, String> _about = {};

  @override
  List<Book> get books => UnmodifiableListView(_books ?? []);

  @override
  List<String> get topTropes => UnmodifiableListView(_topTropes ?? []);

  @override
  Map<String, int> get tropesCount => UnmodifiableMapView(_tropesCount ?? {});

  @override
  List<Actor> get authors => UnmodifiableListView(_authors ?? []);

  @override
  List<Series> get series => UnmodifiableListView(_series ?? []);

  @override
  List<Featured> get features => UnmodifiableListView(_featured ?? []);

  @override
  List<Trope> get tropes => UnmodifiableListView(_tropes ?? []);

  @override
  Poll? get poll => _poll;

  @override
  Series? getSeries(Book book) {
    try {
      return (_series ?? []).firstWhere((it) => it.books.contains(book));
    } catch (_) {
      return null;
    }
  }

  @override
  void reloadFeatured(List<FeaturedModel> featured) {
    _featured = featured;
  }

  @override
  void reloadBooks(List<BookModel> books) {
    _books = books;

    _series?.forEach((it) {
      it.books.updateFromBooks(books);
    });
    _featured?.forEach((it) {
      it.books.updateFromBooks(books);
    });
  }

  @override
  Future<void> load() async {
    try {
      _books = _manager.readBooks();
      _featured = _manager.readFeatures(_books!);
      _series = _manager.readSeries(_books!);
      _tropes = _manager.readTropes();
      _topTropes = _getTopTropes(books);

      if ((_books?.length ?? 0) < 10) {
        throw DataLoadingException(
            "Parsed less than 10 books, looks like a global error!", "");
      }

      Set<Actor> allActors = {};
      for (var book in _books!) {
        allActors.addAll(book.actors.where((actor) => actor.isAuthor));

        if (book.isExpired) {
          final bookAuthors = allActors
              .where((actor) =>
                  book.actors.where((it) => it.isAuthor).contains(actor))
              .toList();
          for (var it in bookAuthors) {
            it.expiredBooks.add(book);
          }
        }
      }
      _authors = allActors.toList();
      _authors?.shuffle();
    } catch (e) {
      throw DataLoadingException(e, "general error");
    }
  }

  List<String> _getTopTropes(List<Book> books) {
    Map<String, int> map = {};

    void count(String tag) {
      int value = map[tag] ?? 0;
      value++;
      map[tag] = value;
    }

    for (var it in books) {
      it.subGenres.forEach(count);
      it.topTropes.forEach(count);
      it.tags.forEach(count);
    }

    _tropesCount = map;
    final result = map.keys.toList();
    result.sort((a, b) => (map[b] ?? 0).compareTo(map[a] ?? 0));
    return result;
  }

  @override
  Future<String> getAuthorAbout(Actor author) async {
    //TODO: use '${apiUrl}authors'
    final cached = _about[author];
    if (cached != null) {
      return cached;
    }

    String description = "";
    try {
      final response =
          jsonDecode(author.id == "2" ? jsonTestAuthor : jsonTestAuthor2);
      description = response['data']['description'];
      _about[author] = description;
    } catch (e) {
      Log.print(e);
    }

    return description;
  }
}
