class Trope {
  final int id;
  final String title;
  final List<int> subtropes;
  final bool isSubgenre;
  final Map<int, double> levelForTropeId;

  Trope({
    required this.id,
    required this.title,
    required this.subtropes,
    required this.isSubgenre,
    required this.levelForTropeId,
  });

  double level(List<int> subgenreIds) {
    double result = 0;
    for (var subgenreId in subgenreIds) {
      result += levelForTropeId[subgenreId] ?? 0;
    }
    return subgenreIds.isEmpty ? 0 : result / subgenreIds.length.toDouble();
  }
}
