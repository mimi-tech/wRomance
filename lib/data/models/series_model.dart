import 'package:womanly_mobile/data/models/book_model.dart';
import 'package:womanly_mobile/domain/entities/book.dart';
import 'package:womanly_mobile/domain/entities/series.dart';
import 'package:womanly_mobile/presentation/misc/log.dart';

// part 'series_model.g.dart';

// @JsonSerializable(createToJson: false)
class SeriesModel extends Series {
  SeriesModel(String id, String name, List<Book> books)
      : super(id, name, books);

  // factory SeriesModel.fromJson(Map<String, dynamic> json) => _$SeriesModelFromJson(json);
  // Map<String, dynamic> toJson() => _$SeriesModelToJson(this);

  static SeriesModel? fromJson(
      Map<String, dynamic> json, Map<String, Book> idToBook) {
    try {
      final id = (json['id'] as num).toString();
      final title = json['title'] as String;

      final List<BookInfo> booksInfo = (json['books'] as List<dynamic>)
          .map((it) => BookInfo(it['id'] as int, it['serial_number'] as int))
          .toList();

      booksInfo.sort((a, b) => a.serialNumber.compareTo(b.serialNumber));

      final List<Book> books = booksInfo
          .map((it) => idToBook[it.bookId.toString()])
          .where((it) => it != null)
          .map((it) => it!)
          .toList();

      return SeriesModel(id, title, books);
    } catch (e) {
      Log.errorParsingSeriesModelFromJson(e);
      return null;
    }
  }
}

class BookInfo {
  final int bookId;
  final int serialNumber;

  BookInfo(this.bookId, this.serialNumber);
}
