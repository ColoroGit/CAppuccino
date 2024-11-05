import 'dart:convert';
import 'package:flutter/services.dart';

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
    Recepie recepie = Recepie(
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

  // Para cargar recetas desde un JSON. Esto debería ser llamado desde mi barista
  static Future<List<Recepie>> loadRecepies() async {
    final jsonString = await rootBundle.loadString('assets/json/recepies.json');
    final List<dynamic> jsonDecoded = jsonDecode(jsonString) as List<dynamic>;
    print("test----:" + jsonDecoded.toString());
    return jsonDecoded
        .map((dynamic item) => Recepie.fromMap(item as Map<String, dynamic>))
        .toList(); // no sé si esto funcione, sino probar con un for
  }
}
