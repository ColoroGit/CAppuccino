import 'package:cappuccino/models/coffee_school.dart';
import 'package:cappuccino/models/comment.dart';
import 'package:cappuccino/models/product.dart';
import 'package:cappuccino/models/user.dart';

class Recepie {
  final int id;
  final String caption;
  final String title;
  final bool like;
  final double rating;
  final int timeOfPrep;
  final int servings;
  final String details;
  List<Product> productsNeeded = List.empty(growable: true);
  final List<String> steps;
  late final User creator;
  final DateTime dateOfCreation;
  List<CoffeeSchool> coffeeSchools = List.empty(growable: true);
  List<Comment> comments = List.empty(growable: true);

  Recepie({
    required this.id,
    required this.caption,
    required this.title,
    required this.like,
    required this.rating,
    required this.timeOfPrep,
    required this.servings,
    required this.details,
    required this.steps,
    required this.dateOfCreation,
  });
}
