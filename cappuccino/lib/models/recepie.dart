class Recepie {
  int id;
  String title;
  int timeOfPrep;
  DateTime dateOfCreation;
  int timesPrepared;
  String ingredients;
  String products;
  String steps;

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

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'timeOfPrep': timeOfPrep,
      'dateOfCreation': dateOfCreation,
      'ingredients': ingredients,
      'products': products,
      'steps': steps,
      'timesPrepared': timesPrepared,
    };
  }

  static Recepie fromMap(Map map) {
    Recepie recepie = new Recepie(
      id: map['id'],
      title: map['title'],
      timeOfPrep: map['timeOfPrep'],
      dateOfCreation: map['dateOfCreation'],
      ingredients: map['ingredients'],
      products: map['products'],
      steps: map['steps'],
      timesPrepared: map['timesPrepared'],
    );
    return recepie;
  }
}
