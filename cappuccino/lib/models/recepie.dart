class Recepie {
  final int id;
  String title;
  int timeOfPrep = 0;
  DateTime dateOfCreation;
  int timesPrepared = 0;
  String ingredients;
  String products;
  String steps;
  List<String> captions = List.empty(growable: true);

  Recepie({
    required this.id,
    required this.title,
    required this.timeOfPrep,
    required this.dateOfCreation,
    required this.ingredients,
    required this.products,
    required this.steps,
    this.timesPrepared = 0,
  });
}
