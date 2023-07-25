import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_list_v2/models/user_model.dart';

class UserNotifier extends StateNotifier<User> {
  UserNotifier() : super(User(name: '', email: '', phone: 0, image: ''));

  void changeName(String name) {
    state = state.copyWith(name: name);
  }

  void changeEmail(String email) {
    state = state.copyWith(email: email);
  }

  void changePhone(int phone) {
    state = state.copyWith(phone: phone);
  }

  void changeImage(String image) {
    state = state.copyWith(image: image);
  }

  void changeAllUserData(String name, String email, int phone, String image) {
    state = state.copyWith(
      name: name,
      email: email,
      phone: phone,
      image: image,
    );
  }
}

final userProvider =
    StateNotifierProvider<UserNotifier, User>((ref) => UserNotifier());
