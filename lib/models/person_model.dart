import 'dart:io';

class Person {
  final String id;
  final String name;
  final String email;
  final int phone;
  final File image;

  Person({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.image,
  });
}
