import 'package:womanly_mobile/domain/entities/book.dart';
import 'package:womanly_mobile/domain/entities/enums/featured_style.dart';
import 'package:womanly_mobile/domain/entities/enums/featured_type.dart';
import 'package:womanly_mobile/domain/entities/featured.dart';
import 'package:womanly_mobile/presentation/misc/log.dart';

class FeaturedModel extends Featured {
  FeaturedModel({
    required String title,
    required List<Book> books,
    required FeaturedStyle style,
    required FeaturedType type,
    List<String> trops = const [],
  }) : super(title, books, style, type: type, trops: trops);

  static FeaturedModel? fromJson(
      Map<String, dynamic> json, List<Book> allBooks) {
    try {
      final type = _getTypeFromString(json['type'] as String);
      if (type != FeaturedType.books && type != FeaturedType.trops) {
        return FeaturedModel(
          title: "",
          books: [],
          style: FeaturedStyle.theOnly,
          type: type,
          trops: [],
        );
      }

      final title = json['title'] as String;
      final style = _getStyleFromString(json['style'] as String);

      bool presentedInAllBooks(String bookId) =>
          allBooks.any((it) => it.id == bookId);

      Book asBook(String bookId) =>
          allBooks.firstWhere((it) => it.id == bookId);

      List<Book> books = type == FeaturedType.books
          ? (json['books'] as List<dynamic>)
              .map((it) => it.toString())
              .where(presentedInAllBooks)
              .map(asBook)
              .toList()
          : [];

      final List<String> trops = type == FeaturedType.trops
          ? (json['books'] as List<dynamic>).cast<String>()
          : const [];

      return FeaturedModel(
        title: title,
        books: books,
        style: style,
        type: type,
        trops: trops,
      );
    } catch (e) {
      Log.errorParsingFeaturedModelFromJson(e);
      return null;
    }
  }

  static FeaturedType _getTypeFromString(String value) {
    switch (value) {
      case "books":
        return FeaturedType.books;
      case "tropes":
        return FeaturedType.trops;
      case "authors":
        return FeaturedType.authors;
      case "poll":
        return FeaturedType.quiz;
      case "question":
        return FeaturedType.sexualitySteamyTalks;
      case "expired_books_soon":
        return FeaturedType.leavingSoonBanner;
      default:
        {
          Log.errorFeaturedModelUnknown("[$value]");
          return FeaturedType.unknown;
        }
    }
  }

  static FeaturedStyle _getStyleFromString(String value) {
    switch (value) {
      case "fullSize":
        return FeaturedStyle.fullSize;
      case "medium":
        return FeaturedStyle.medium;
      case "medium_and_red_button":
        return FeaturedStyle.mediumAndRedButton;
      case "theOnly":
        return FeaturedStyle.theOnly;
      case "": //case for trops type
      case "small":
        return FeaturedStyle.small;
      default:
        throw Exception("undefined tag for 'FeaturedStyle'");
    }
  }
}
