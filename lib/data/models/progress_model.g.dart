// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'progress_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProgressModel _$ProgressModelFromJson(Map<String, dynamic> json) =>
    ProgressModel(
      json['chapterIndex'] as int,
      Duration(microseconds: json['position'] as int),
    );

Map<String, dynamic> _$ProgressModelToJson(ProgressModel instance) =>
    <String, dynamic>{
      'chapterIndex': instance.chapterIndex,
      'position': instance.position.inMicroseconds,
    };
