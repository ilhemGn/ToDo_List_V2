import 'package:flutter/material.dart';

class Task {
  final String title;
  final String description;
  final DateTime startTime;
  final DateTime endTime;
  final Color color;
  final bool isCompleted;

  Task({
    required this.title,
    required this.description,
    required this.startTime,
    required this.endTime,
    required this.color,
    this.isCompleted = false,
  });
}
