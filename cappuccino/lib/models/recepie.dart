// import 'dart:convert';
import 'package:cappuccino/models/caption.dart';
import 'package:cappuccino/models/date.dart';
// import 'package:flutter/services.dart';

class Recepie {
  int id;
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
    required this.timesPrepared,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'timeOfPrep': timeOfPrep,
      'ingredients': ingredients,
      'products': products,
      'steps': steps,
      'timesPrepared': timesPrepared,
    };
  }

  //Este es para traer una receta desde la base de datos
  static Recepie fromDB(Map map, Map d, List<Map> cs) {
    List<Caption> captions = List.empty(growable: true);

    for (var c in cs) {
      captions.add(Caption.fromDB(c));
    }

    return Recepie(
      id: map['id'],
      title: map['title'],
      timeOfPrep: map['timeOfPrep'],
      dateOfCreation: Date.fromDB(d),
      ingredients: map['ingredients'],
      products: map['products'],
      steps: map['steps'],
      timesPrepared: map['timesPrepared'],
      captions: captions,
    );
  }
}
