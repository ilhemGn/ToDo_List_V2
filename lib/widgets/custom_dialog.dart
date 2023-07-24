import 'package:flutter/material.dart';

Future<dynamic> customDialog(BuildContext context,
    {required String title, required String content}) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
        );
      });
}
