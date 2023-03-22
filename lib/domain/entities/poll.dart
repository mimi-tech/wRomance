import 'package:equatable/equatable.dart';
import 'package:womanly_mobile/domain/entities/answer.dart';

class Poll {
  final int id;
  final String poll;
  final String expiration;
  final List<Answer> answers;

  Poll({
    required this.id,
    required this.poll,
    required this.expiration,
    required this.answers,
  });
}
