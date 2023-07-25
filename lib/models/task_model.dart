import 'package:flutter/material.dart';
import 'package:todo_list_v2/models/user_model.dart';

class Task {
  final String id;
  final String title;
  final String description;
  final String startTime;
  final String endTime;
  final Color color;
  bool isCompleted;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.startTime,
    required this.endTime,
    required this.color,
    this.isCompleted = false,
  });
}
