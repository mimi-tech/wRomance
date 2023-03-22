import 'package:womanly_mobile/domain/entities/actor.dart';
import 'package:womanly_mobile/domain/entities/book.dart';
import 'package:womanly_mobile/presentation/misc/config/remote_config.dart';

// part 'actor_model.g.dart';

// @JsonSerializable()
class ActorModel extends Actor {
  ActorModel({
    required String id,
    required String name,
    required String avatarUrl,
    required String webUrl,
    required String facebookUrl,
    required String instagramUrl,
    required String twitterUrl,
    required String tikTokUrl,
    required bool isAuthor,
    required Set<Book> expiredBooks,
  }) : super(
          id: id,
          name: name,
          avatarUrl: avatarUrl,
          isAuthor: isAuthor,
          webUrl: webUrl,
          facebookUrl: facebookUrl,
          instagramUrl: instagramUrl,
          twitterUrl: twitterUrl,
          tikTokUrl: tikTokUrl,
          expiredBooks: expiredBooks,
        );

  // factory ActorModel.fromJson(Map<String, dynamic> json) =>
  //     _$ActorModelFromJson(json);
  // Map<String, dynamic> toJson() => _$ActorModelToJson(this);

  factory ActorModel.fromJson(Map<String, dynamic> json,
      {required bool isAuthor}) {
    final name = json['name'] as String;
    final surname = json['surname'] as String;
    final avatar = json['photo'] as String;

    return ActorModel(
      id: json['id'].toString(),
      name: "$name${surname.isEmpty ? '' : ' '}$surname",
      avatarUrl: avatar.isNotEmpty ? "${RemoteConfig.mediaUrl}$avatar" : "",
      isAuthor: isAuthor,
      webUrl: (json['web'] as String?) ?? "",
      facebookUrl: (json['fb'] as String?) ?? "",
      instagramUrl: (json['ig'] as String?) ?? "",
      twitterUrl: (json['twitter'] as String?) ?? "",
      tikTokUrl: (json['tikTok'] as String?) ?? "",
      expiredBooks: {}, //initialized later
    );
  }
}
