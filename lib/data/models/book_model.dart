import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:womanly_mobile/data/models/actor_model.dart';
import 'package:womanly_mobile/data/models/chapter_model.dart';
import 'package:womanly_mobile/domain/entities/book.dart';
import 'package:womanly_mobile/presentation/misc/config/remote_config.dart';
import 'package:womanly_mobile/presentation/misc/log.dart';

// part 'book_model.g.dart';

// @JsonSerializable(createToJson: false)
class BookModel extends Book {
  BookModel({
    required String id,
    required String coverUrl,
    required String sampleUrl,
    required String name,
    required String description,
    required List<ChapterModel> chapters,
    required double rating,
    required int hotPeppers, //0..3 values are supported
    required int totalUsersRated,
    required List<String> tags,
    required List<String> subGenres,
    required List<String> topTropes,
    required List<ActorModel> actors,
    required bool isSharingEmotionsEnabled,
    required int popularity,
    required int startChapter,
    required String price,
    required int expiredTs,
  }) : super(
          id: id,
          coverUrl: coverUrl,
          sampleUrl: sampleUrl,
          name: name,
          description: description,
          chapters: chapters,
          rating: rating,
          totalUsersRated: totalUsersRated,
          tags: tags,
          subGenres: subGenres,
          topTropes: topTropes,
          actors: actors,
          isSharingEmotionsEnabled: isSharingEmotionsEnabled,
          hotPeppers: hotPeppers,
          popularity: popularity,
          startChapter: startChapter,
          price: price,
          expiredTs: expiredTs,
        );

  // factory BookModel.fromJson(Map<String, dynamic> json) =>
  //     _$BookModelFromJson(json);

  static BookModel? fromJson(Map<String, dynamic> json) {
    try {
      List<ActorModel> authors;
      List<ActorModel> narrators;
      List<String> tags = [];
      List<String> subGenres = [];
      List<String> topTropes = [];

      authors = (json['authors'] as List<dynamic>)
          .map((e) =>
              ActorModel.fromJson(e as Map<String, dynamic>, isAuthor: true))
          .toList();
      narrators = (json['narrators'] as List<dynamic>)
          .map((e) =>
              ActorModel.fromJson(e as Map<String, dynamic>, isAuthor: false))
          .toList();

      final Map<String, int> tagLevels = {};

      for (var it in (json['tags'] as List<dynamic>)) {
        // final id = it['id']; //TODO: create tag entity
        final title = it['title'];
        final level = it['level'];
        switch (level) {
          case 1:
            {
              subGenres.add(title);
              break;
            }
          case 2:
            {
              topTropes.add(title);
              break;
            }
          default:
            {
              tags.add(title);
              tagLevels[title] = level;
              break;
            }
          // default:
          //   throw DataLoadingException("Unknown tag level");
        }
      }

      tags.sort(((a, b) => tagLevels[a]!.compareTo(tagLevels[b]!)));

      final cover = json['cover'] as String;
      final sample = json['sample'] as String;
      final id = json['id'].toString();
      final rootDir = "${RemoteConfig.mediaUrl}$id/";

      List<ChapterModel> chapters = (json['chapters'] as List<dynamic>)
          .map((e) => ChapterModel.fromJson(e as Map<String, dynamic>, rootDir))
          .toList();

      final debugRandom = Random();

      final int peppers = json['peppers'] as int;

      String? overridePrice = RemoteConfig.forceSetPriceTierForNonFree;
      final originalPrice = json['price'];
      String? overridePriceForAll = RemoteConfig.forceSetPriceTierForAll;
      if (overridePriceForAll.isNotEmpty) {
        overridePrice = overridePriceForAll; //higher priority
      }

      return BookModel(
        id: id,
        coverUrl: _getTestCoverUrl(id),
        sampleUrl: "https://wromance.com/flutter-test/sample$id.mp4",
        name: json['title'] as String,
        rating: (json['rating'] as num).toDouble(),
        description: json['description'] as String,
        actors: authors..addAll(narrators),
        tags: tags,
        hotPeppers: peppers,
        subGenres: subGenres,
        topTropes: topTropes,
        chapters: chapters,
        totalUsersRated: 0, //TODO json['totalUsersRated'] as int,
        isSharingEmotionsEnabled:
            RemoteConfig.isEmotionsEnabled && json['emoji'] as bool,
        popularity: (json['popularity'] as num).toInt(),
        startChapter: (json['start_chapter'] as num).toInt(),
        //price: overridePrice ?? originalPrice ?? "",
        price: overridePrice,
        expiredTs: _getExpired(json['expire']),
      );
    } catch (e) {
      Log.errorParsingBookModelFromJson(e, json['id']);
      return null;
    }
  }

  static String _getTestCoverUrl(String id) {
    switch (id) {
      case "6":
        return "https://cdn.filestackcontent.com/aJ8RT0lOQkKtncqiQwB1";
      case "9":
        return "https://cdn.filestackcontent.com/e3ufglkMQMirZVzQOemO";
      default:
        return "https://wromance.com/flutter-test/cover$id.jpg";
    }
  }

  static int _getExpired(dynamic expire) {
    if (expire is String) {
      try {
        return DateFormat("yyyy-MM-dd").parse(expire).millisecondsSinceEpoch +
            DateTime.now().timeZoneOffset.inMilliseconds;
      } catch (e) {
        Log.errorParsingExpired("$e with string: $expire");
      }
    }
    return 0;
  }
  // Map<String, dynamic> toJson() => _$BookModelToJson(this);
}
