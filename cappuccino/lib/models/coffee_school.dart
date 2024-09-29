import 'package:cappuccino/models/recepie.dart';

class CoffeeSchool {
  final int id;
  final String name;
  final String caption;
  final bool like;
  final String description;
  List<Recepie> lessons = List.empty(growable: true);

  CoffeeSchool({
    required this.id,
    required this.name,
    required this.caption,
    required this.like,
    required this.description,
  });
}
