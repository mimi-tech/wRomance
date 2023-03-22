import 'package:womanly_mobile/domain/entities/answer.dart';

class AnswerModel extends Answer {
  AnswerModel(
      {required int id,
      required String title,
      required int bookId,
      required String image,
      required int count,
      required bool deviceAnswer})
      : super(
          id: id,
          title: title,
          bookId: bookId,
          image: image,
          count: count,
          deviceAnswer: deviceAnswer,
        );

  factory AnswerModel.fromJson(Map<String, dynamic> json) {
    return AnswerModel(
      id: json['id'] as int,
      title: (json['title'] as String?) ?? "",
      bookId: (json['book_id'] as int?) ?? -1,
      image: json['image'] as String,
      count: json['count'] as int,
      deviceAnswer: json['device_answer'] as bool,
    );
  }
}
