import 'package:equatable/equatable.dart';
import 'package:womanly_mobile/domain/entities/book.dart';

class Actor with EquatableMixin {
  final String id;
  final String name;
  final String avatarUrl;
  // final String about =
  //     'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using Content here, content here, making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for lorem ipsum will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).';

  final String webUrl;
  final String facebookUrl;
  final String instagramUrl;
  final String twitterUrl;
  final String tikTokUrl;

  ///if true: actor is an author
  ///otherwise - a narrator
  final bool isAuthor;
  final Set<Book> expiredBooks;

  Actor({
    required this.id,
    required this.name,
    required this.avatarUrl,
    required this.isAuthor,
    required this.webUrl,
    required this.facebookUrl,
    required this.instagramUrl,
    required this.twitterUrl,
    required this.tikTokUrl,
    required this.expiredBooks,
  });

  @override
  List<Object?> get props => [id];
}
