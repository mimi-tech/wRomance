import 'package:womanly_mobile/data/models/book_model.dart';
import 'package:womanly_mobile/data/models/featured_model.dart';
import 'package:womanly_mobile/data/models/series_model.dart';
import 'package:womanly_mobile/domain/entities/trope.dart';

abstract class StorageManager {
  List<BookModel> readBooks();
  List<FeaturedModel> readFeatures(List<BookModel> books);
  List<SeriesModel> readSeries(List<BookModel> books);
  List<Trope> readTropes();
}
