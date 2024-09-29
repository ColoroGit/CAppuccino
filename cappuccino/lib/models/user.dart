import 'package:cappuccino/models/coffee_school.dart';
import 'package:cappuccino/models/recepie.dart';

class User {
  final int id;
  final String name;
  final String password;
  final int age;
  @Deprecated('Not used in this version of the app')
  List<Recepie> favorites = List.empty(growable: true);
  @Deprecated('Not used in this version of the app')
  List<CoffeeSchool> followedCoffeeSchools = List.empty(growable: true);
  @Deprecated('Not used in this version of the app')
  List<User> friends = List.empty(growable: true);

  User({
    required this.id,
    required this.name,
    required this.password,
    required this.age,
  });
}
