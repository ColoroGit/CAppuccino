import 'dart:convert';
import 'package:cappuccino/models/caption.dart';
import 'package:cappuccino/models/date.dart';
import 'package:flutter/services.dart';

class BRecepie {
  String title;
  int timeOfPrep;
  Date dateOfCreation;
  String ingredients;
  String products;
  String steps;
  Caption mainCaption;

  BRecepie({
    required this.title,
    required this.timeOfPrep,
    required this.dateOfCreation,
    required this.ingredients,
    required this.products,
    required this.steps,
    required this.mainCaption,
  });

  // Este es para crear una receta desde un JSON
  static BRecepie fromJSON(Map map) {
    BRecepie br = BRecepie(
      title: map['title'],
      timeOfPrep: map['timeOfPrep'],
      dateOfCreation: Date.fromJSON(map['dateOfCreation']),
      ingredients: map['ingredients'],
      products: map['products'],
      steps: map['steps'],
      mainCaption: Caption.fromJSON(map),
    );
    return br;
  }

  // Para cargar recetas desde un JSON. Esto debería ser llamado desde mi barista
  static Future<List<BRecepie>> loadBRecepies() async {
    final jsonString = await rootBundle.loadString('assets/json/recepies.json');
    final List<dynamic> jsonDecoded = jsonDecode(jsonString) as List<dynamic>;
    return jsonDecoded
        .map((dynamic item) => BRecepie.fromJSON(item as Map<String, dynamic>))
        .toList();
  }
}
