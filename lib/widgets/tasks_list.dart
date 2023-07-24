import 'package:flutter/material.dart';
import 'package:todo_list_v2/widgets/task_item.dart';
import 'package:todo_list_v2/screens/task_details.dart';

class TasksList extends StatefulWidget {
  const TasksList({
    Key? key,
  }) : super(key: key);

  @override
  State<TasksList> createState() => _TasksListState();
}

class _TasksListState extends State<TasksList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 3,
        itemBuilder: (context, index) {
          return TaskItem(
            coulour: Colors.green,
            isChecked: true,
            title: 'title',
            time: '01:00',
            checkboxCallback: (bool? checkboxState) {
              //taskData.updateTaskState(taskData.todos[index]);
            },
            pressFunct: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const TaskDetails()));
            },
            deleteFunct: () {
              // taskData.deleteTask(index);
            },
          );
        });
  }
}
