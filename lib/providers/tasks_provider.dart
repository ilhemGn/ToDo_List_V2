import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_list_v2/models/task_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserTasksNotifier extends StateNotifier<List<Task>> {
  UserTasksNotifier() : super([]);

  void addTask(Task task) {
    state = [task, ...state];
  }

  void loadUserTasks(QuerySnapshot<Map<String, dynamic>> tasksLoaded) {
    List<Task> tasks = tasksLoaded.docs
        .map((task) => Task(
            id: task['id'],
            title: task['title'],
            description: task['description'],
            startTime: task['start time'],
            endTime: task['end time'],
            color: Color(int.parse(task['color']))))
        .toList();

    state = tasks;
  }

  void toggleTaskState(Task task) {
    //if task is completed, set it the paramater to false
    //if task is not completed, set it the paramater to true
    task.isCompleted = !task.isCompleted;
    state = state.map((tk) => tk.id == task.id ? task : tk).toList();
  }

  void deleteTask(Task task) {
    state = state.where((tk) => tk.id != task.id).toList();
  }

  void updateTask(Task task) {
    state = state.map((tk) => tk.id == task.id ? task : tk).toList();
  }
}

final userTasksProvider = StateNotifierProvider<UserTasksNotifier, List<Task>>(
  (ref) => UserTasksNotifier(),
);
