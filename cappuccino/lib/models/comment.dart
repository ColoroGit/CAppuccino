import 'package:cappuccino/models/user.dart';

class Comment {
  final int id;
  late final User owner;
  final String text;

  // The missing atributes of this model are not relevant for
  // this version of the app

  Comment({
    required this.id,
    required this.text,
  });
}
