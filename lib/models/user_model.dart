import 'package:uuid/uuid.dart';

const uuid = Uuid();

class User {
  String? id;
  final String name;
  final String email;
  final int phone;
  final String image;

  User({
    required this.name,
    required this.email,
    required this.phone,
    required this.image,
  }) : id = uuid.v4();

  User copyWith({
    String? id,
    String? name,
    String? email,
    int? phone,
    String? image,
  }) {
    return User(
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      image: image ?? this.image,
    );
  }
}
