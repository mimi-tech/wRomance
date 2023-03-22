import 'package:womanly_mobile/domain/entities/chapter.dart';
import 'package:womanly_mobile/presentation/misc/log.dart';

// part 'chapter_model.g.dart';

// @JsonSerializable()
class ChapterModel extends Chapter {
  ChapterModel(int id, String title, Duration duration, String trackUrl)
      : super(id, title, duration, trackUrl);

  // factory ChapterModel.fromJson(Map<String, dynamic> json) => _$ChapterModelFromJson(json);
  // Map<String, dynamic> toJson() => _$ChapterModelToJson(this);

  factory ChapterModel.fromJson(Map<String, dynamic> json, String rootDir) {
    final track = json['audio'] as String;
    var durationInSeconds = (json['duration'] as num?)?.toInt();
    if (durationInSeconds == null) {
      final errorMessage = "error: durationNotSet for track $track";
      Log.print(errorMessage);
      // throw DataLoadingException(errorMessage); //TODO: do smth
      durationInSeconds = 0;
    }

    return ChapterModel(
      json['id'] as int,
      json['title'] as String,
      Duration(seconds: durationInSeconds),
      track.isNotEmpty ? "$rootDir$track" : "",
    );
  }
}
