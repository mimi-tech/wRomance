import 'package:womanly_mobile/data/models/book_model.dart';
import 'package:womanly_mobile/data/models/featured_model.dart';
import 'package:womanly_mobile/domain/entities/actor.dart';
import 'package:womanly_mobile/domain/entities/book.dart';
import 'package:womanly_mobile/domain/entities/featured.dart';
import 'package:womanly_mobile/domain/entities/series.dart';
import 'package:womanly_mobile/domain/entities/trope.dart';

abstract class DataRepository {
  Future<void> load();

  //storage, loaded once
  List<Book> get books;
  List<Actor> get authors;
  List<Series> get series;
  List<Featured> get features;
  List<String> get topTropes;
  List<Trope> get tropes;
  Map<String, int> get tropesCount;
  Series? getSeries(Book book);
  Future<String> getAuthorAbout(Actor author);
  void reloadFeatured(List<FeaturedModel> featured);
  void reloadBooks(List<BookModel> books);
}
