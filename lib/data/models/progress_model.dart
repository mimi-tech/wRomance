import 'package:womanly_mobile/domain/entities/progress.dart';

import 'package:json_annotation/json_annotation.dart';

part 'progress_model.g.dart';

@JsonSerializable()
class ProgressModel extends Progress {
  ProgressModel(int chapterIndex, Duration position) : super(chapterIndex, position);

  factory ProgressModel.fromJson(Map<String, dynamic> json) => _$ProgressModelFromJson(json);
  Map<String, dynamic> toJson() => _$ProgressModelToJson(this);
}
