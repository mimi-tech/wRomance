import 'package:equatable/equatable.dart';
import 'package:womanly_mobile/domain/entities/trope.dart';

class TropeModel extends Trope with EquatableMixin {
  TropeModel({
    required int id,
    required String title,
    required List<int> subtropes,
    required bool isSubgenre,
    required Map<int, double> levelForTropeId,
  }) : super(
          id: id,
          title: title,
          subtropes: subtropes,
          isSubgenre: isSubgenre,
          levelForTropeId: levelForTropeId,
        );

  static TropeModel fromJson(Map<String, dynamic> json) {
    final List<int> subtropes = json['subtropes'] == null
        ? []
        : (json['subtropes'] as List<dynamic>).cast<int>().toList();

    final levels = ((json['levels'] ?? []) as List<dynamic>);
    final Map<int, double> levelForTropeId = {};

    for (var pair in levels) {
      final num? level = pair['level'];
      final int? subgenreId = pair['subgenre'];
      if (level != null && subgenreId != null) {
        levelForTropeId[subgenreId] = level.toDouble();
      }
    }

    return TropeModel(
      id: json['id'] as int,
      title: json['title'] as String,
      subtropes: subtropes,
      isSubgenre: json['trope_type'] == "subgenre",
      levelForTropeId: levelForTropeId,
    );
  }

  @override
  List<Object?> get props => [id];
}
