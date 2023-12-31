import 'package:flutter/material.dart';

const Color kStartColor = Color(0xFFEDDBC3);
const Color kTextColor = Color(0xFF545454);
const Color kFieldColor = Color(0xFFEDEFF2);
Color kIconColor = Colors.blueGrey.shade400;

const TextStyle kStyleAppBarTitle = TextStyle(
  color: Colors.black87,
  fontSize: 17,
  fontWeight: FontWeight.w500,
);

const InputDecoration kAreaDecoration = InputDecoration(
  hintText: '',
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(20)),
    borderSide: BorderSide.none,
  ),
  filled: true,
  isDense: true,
  fillColor: Color(0xFFEDEFF2),
);
