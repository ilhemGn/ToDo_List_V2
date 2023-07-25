import 'package:flutter/material.dart';
import 'package:todo_list_v2/widgets/task_item.dart';
import 'package:todo_list_v2/screens/task_details.dart';
import 'package:todo_list_v2/providers/tasks_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_list_v2/models/task_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//get the user id
final userId = FirebaseAuth.instance.currentUser!.uid;

class TasksList extends ConsumerStatefulWidget {
  const TasksList({
    Key? key,
    required this.todos,
  }) : super(key: key);

  final List<Task> todos;

  @override
  ConsumerState<TasksList> createState() => _TasksListState();
}

class _TasksListState extends ConsumerState<TasksList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.todos.length,
        itemBuilder: (context, index) {
          return TaskItem(
            coulour: widget.todos[index].color,
            isChecked: widget.todos[index].isCompleted,
            title: widget.todos[index].title,
            startTime: widget.todos[index].startTime,
            endTime: widget.todos[index].endTime,
            checkboxCallback: (bool? checkboxState) async {
              ref
                  .read(userTasksProvider.notifier)
                  .toggleTaskState(widget.todos[index]);

              try {
                var taskRef = FirebaseFirestore.instance
                    .collection('tasks')
                    .where('userId', isEqualTo: userId)
                    .get();

                for (var task in (await taskRef).docs) {
                  if (task['id'] == widget.todos[index].id) {
                    task.reference.update({'isCompleted': checkboxState});
                  }
                }
              } catch (error) {
                print(error);
              }
            },
            pressFunct: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      TaskDetails(task: widget.todos[index])));
            },
            deleteFunct: () async {
              //delete the task from firestore
              try {
                var taskRef = FirebaseFirestore.instance
                    .collection('tasks')
                    .where('userId', isEqualTo: userId)
                    .get();

                for (var task in (await taskRef).docs) {
                  if (task['id'] == widget.todos[index].id) {
                    task.reference.delete();
                  }
                }
              } catch (error) {
                print(error);
              }
              //delete the task from provider
              ref
                  .read(userTasksProvider.notifier)
                  .deleteTask(widget.todos[index]);
            },
          );
        });
  }
}
