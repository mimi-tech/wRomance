import 'package:womanly_mobile/domain/entities/book.dart';

class Series {
  final String id;
  final String title;
  final List<Book> books;

  Series(this.id, this.title, this.books);
}
