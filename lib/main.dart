import 'package:flutter/material.dart';
import 'package:todo_list_v2/constants.dart';
import 'package:todo_list_v2/screens/welcome_screen.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To Do List',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: kStartColor),
      ),
      home: const WelcomeScreen(),
    );
  }
}
