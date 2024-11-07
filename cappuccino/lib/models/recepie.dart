import 'dart:convert';
import 'package:cappuccino/models/date.dart';
import 'package:flutter/services.dart';

class Recepie {
  int id;
  String title;
  int timeOfPrep;
  Date dateOfCreation;
  int timesPrepared;
  String ingredients;
  String products;
  String steps;
  String mainCaption = "";

  Recepie({
    required this.id,
    required this.title,
    required this.timeOfPrep,
    required this.dateOfCreation,
    required this.ingredients,
    required this.products,
    required this.steps,
    this.timesPrepared = 0,
    this.mainCaption = "",
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id, //is this necesary?
      'title': title,
      'timeOfPrep': timeOfPrep,
      'dateOfCreation': dateOfCreation.id, //the database recieves the id of doc
      'ingredients': ingredients,
      'products': products,
      'steps': steps,
      'timesPrepared': timesPrepared,
    };
  }

  // Este es para cargar desde un JSON, puede que haya que hacer otro para
  // traerlo desde un map; desde la base de datos
  static Recepie fromJSON(Map map) {
    Recepie recepie = Recepie(
      id: map['id'],
      title: map['title'],
      timeOfPrep: map['timeOfPrep'],
      dateOfCreation: Date.fromJSON(map['dateOfCreation']),
      ingredients: map['ingredients'],
      products: map['products'],
      steps: map['steps'],
      timesPrepared: map['timesPrepared'],
      mainCaption: (map['caption'] != null) ? map['caption'] : "",
    );
    return recepie;
  }

  static Recepie fromDB(Map map, Map d) {
    return Recepie(
      id: map['id'],
      title: map['title'],
      timeOfPrep: map['timeOfPrep'],
      dateOfCreation: Date.fromJSON(d),
      ingredients: map['ingredients'],
      products: map['products'],
      steps: map['steps'],
    );
  }

  // Para cargar recetas desde un JSON. Esto debería ser llamado desde mi barista
  static Future<List<Recepie>> loadRecepies() async {
    final jsonString = await rootBundle.loadString('assets/json/recepies.json');
    final List<dynamic> jsonDecoded = jsonDecode(jsonString) as List<dynamic>;
    return jsonDecoded
        .map((dynamic item) => Recepie.fromJSON(item as Map<String, dynamic>))
        .toList();
  }
}
