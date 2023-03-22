import 'package:womanly_mobile/data/models/answer_model.dart';
import 'package:womanly_mobile/domain/entities/answer.dart';
import 'package:womanly_mobile/domain/entities/poll.dart';

class PollModel extends Poll {
  PollModel(
      {required int id,
      required String poll,
      required String expiration,
      required List<Answer> answers})
      : super(
          id: id,
          poll: poll,
          expiration: expiration,
          answers: answers,
        );

  factory PollModel.fromJson(Map<String, dynamic> json) {
    return PollModel(
      id: json['id'] as int,
      poll: json['poll'] as String,
      expiration: json['expiration'] as String,
      answers: (json['answers'] as List<dynamic>)
          .map((it) => AnswerModel.fromJson(it))
          .toList(),
    );
  }
}
