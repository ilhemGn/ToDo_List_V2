import 'package:flutter/material.dart';
import 'package:todo_list_v2/constants.dart';

class RoundButton extends StatelessWidget {
  final String text;
  final Color colorText;
  final Color backgroundColor;

  /// To verifyyy
  final Function() onPress;

  const RoundButton(
      {super.key,
      required this.text,
      required this.colorText,
      required this.backgroundColor,
      required this.onPress});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPress,
        style: ElevatedButton.styleFrom(
          backgroundColor: kStartColor,
          shadowColor: kStartColor,
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ));
  }
}
