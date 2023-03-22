import 'package:womanly_mobile/domain/entities/book.dart';

class Product {
  final Book book;
  final List<Book> featuredThisAuthor;
  final List<Book> featuredLikeThis;

  Product(this.book, this.featuredThisAuthor, this.featuredLikeThis);
}
