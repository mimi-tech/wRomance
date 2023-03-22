import 'package:equatable/equatable.dart';
import 'package:womanly_mobile/domain/entities/actor.dart';
import 'package:womanly_mobile/domain/entities/chapter.dart';

class Book with EquatableMixin {
  final String id;
  final String coverUrl;
  final String sampleUrl;
  final String name;
  final String description;
  final double rating;
  final int popularity;
  final int totalUsersRated;
  final bool isSharingEmotionsEnabled;
  final int hotPeppers; //0..3 values are supported
  final int startChapter;

  final List<String> subGenres;
  final List<String> topTropes;
  final List<String> tags; //excluding genres and topTropes

  final List<Actor> actors;
  final List<Chapter> chapters;
  // final String seria;
  // final List<Seria> seriaNumber; ??
  final String price;
  final int expiredTs;

  Book({
    required this.id,
    required this.coverUrl,
    required this.sampleUrl,
    required this.name,
    required this.description,
    required this.chapters,
    required this.rating,
    required this.totalUsersRated,
    required this.tags,
    required this.subGenres,
    required this.topTropes,
    required this.actors,
    required this.isSharingEmotionsEnabled,
    required this.hotPeppers,
    required this.popularity,
    required this.startChapter,
    required this.price,
    required this.expiredTs,
  });

  @override
  List<Object?> get props => [id];
}
