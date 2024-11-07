import 'dart:convert';
import 'package:cappuccino/models/caption.dart';
import 'package:cappuccino/models/date.dart';
import 'package:flutter/services.dart';

class Recepie {
  late int id;
  String title;
  int timeOfPrep;
  Date dateOfCreation;
  int timesPrepared;
  String ingredients;
  String products;
  String steps;
  List<Caption> captions;

  Recepie({
    required this.id,
    required this.title,
    required this.timeOfPrep,
    required this.dateOfCreation,
    required this.ingredients,
    required this.products,
    required this.steps,
    required this.captions,
    this.timesPrepared = 0,
  });

  Map<String, dynamic> toMap(int? dID) {
    return {
      // 'id': id, //is this necesary?
      'title': title,
      'timeOfPrep': timeOfPrep,
      'dateOfCreation': dID, //the database recieves the id of doc
      'ingredients': ingredients,
      'products': products,
      'steps': steps,
      'timesPrepared': timesPrepared,
    };
  }

  // Este es para crear una receta desde un JSON
  static Recepie fromJSON(Map map) {
    List<Caption> captions = List.empty(growable: true);

    captions.add(Caption.fromMap(map['caption']));

    Recepie recepie = Recepie(
      id: map['id'],
      title: map['title'],
      timeOfPrep: map['timeOfPrep'],
      dateOfCreation: Date.fromJSON(map['dateOfCreation']),
      ingredients: map['ingredients'],
      products: map['products'],
      steps: map['steps'],
      timesPrepared: map['timesPrepared'],
      captions: captions,
    );
    return recepie;
  }

  //Este es para traer una receta desde la base de datos
  static Recepie fromDB(Map map, Map d, List<Map> cs) {
    List<Caption> captions = List.empty(growable: true);

    for (var c in cs) {
      captions.add(Caption.fromMap(c));
    }

    return Recepie(
      id: map['id'],
      title: map['title'],
      timeOfPrep: map['timeOfPrep'],
      dateOfCreation: Date.fromJSON(d),
      ingredients: map['ingredients'],
      products: map['products'],
      steps: map['steps'],
      captions: captions,
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
