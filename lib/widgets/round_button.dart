import 'package:flutter/material.dart';
import 'package:todo_list_v2/constants.dart';

class RoundButton extends StatelessWidget {
  final String text;
  final Color? colorText;
  final Color? backgroundColor;
  final Function() onPress;
  final Widget? widget;

  const RoundButton({
    super.key,
    required this.text,
    this.colorText = Colors.white,
    required this.onPress,
    this.backgroundColor = kStartColor,
    this.widget,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPress,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
          backgroundColor: backgroundColor,
          shadowColor: kStartColor,
        ),
        child:widget?? Text(
          text,
          style: TextStyle(
            color: colorText,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ));
  }
}
