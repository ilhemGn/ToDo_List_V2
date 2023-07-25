import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_list_v2/constants.dart';
import 'package:todo_list_v2/models/task_model.dart';
import 'package:todo_list_v2/widgets/input_field.dart';
import 'package:todo_list_v2/widgets/round_button.dart';
import 'package:todo_list_v2/providers/tasks_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_list_v2/widgets/task_color.dart';

final userId = FirebaseAuth.instance.currentUser!.uid;

class TaskDetails extends ConsumerStatefulWidget {
  const TaskDetails({
    super.key,
    this.task,
  });
  final Task? task;

  @override
  ConsumerState<TaskDetails> createState() => _TaskDetailsState();
}

class _TaskDetailsState extends ConsumerState<TaskDetails> {
  final _formKey = GlobalKey<FormState>();
  String _taskTitle = '';
  //accept hour and minute
  String _taskStartTime = '18:00';
  String _taskEndTime = '19:00';
  String _taskDescript = '';

  int selectedIndex = 0;
  void _addTask() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Navigator.pop(context);
      Color taskColor = colors.elementAt(selectedIndex);
      String hexColor = taskColor
          .toString()
          .replaceAll('Color', "")
          .replaceAll("(", "")
          .replaceAll(")", "");
      Task newTask = Task(
          id: userId + _taskTitle,
          title: _taskTitle,
          description: _taskDescript,
          startTime: _taskStartTime,
          endTime: _taskEndTime,
          color: taskColor);

      ref.read(userTasksProvider.notifier).addTask(newTask);
      try {
        //store new task in firestore
        FirebaseFirestore.instance.collection('tasks').add({
          'id': userId + _taskTitle,
          'title': _taskTitle,
          'description': _taskDescript,
          'start time': _taskStartTime,
          'end time': _taskEndTime,
          'color': hexColor,
          'isCompleted': false,
          'userId': userId,
        });
      } catch (error) {
        print(error);
      }
    }
    return;
  }

  List<Color> colors = const [
    Color(0xFFFAD2D2),
    Color(0xFFF2C552),
    Color(0xFF5486E9),
    Color(0xFF81DF96),
    Color(0xFFE0BBF8)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kStartColor,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.keyboard_arrow_left_outlined,
                color: Colors.white, size: 28)),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Add Task',
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.fromLTRB(20, 40, 20, 10),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(55),
                      topLeft: Radius.circular(55)),
                  color: Colors.white,
                ),
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InputFormField(
                          initialValue: widget.task?.title ?? '',
                          hint: 'Workout for 30min',
                          prefixIcon: null,
                          textInputType: TextInputType.text,
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                value.trim().length <= 1 ||
                                value.trim().length >= 16) {
                              return 'Please enter a valid title';
                            }
                            return null;
                          },
                          onSave: (value) {
                            _taskTitle = value!;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: InputFormField(
                                initialValue: widget.task?.startTime ?? '',
                                hint: '16:00',
                                prefixIcon: null,
                                textInputType: TextInputType.text,
                                suffixIcon: Icon(Icons.watch_later_outlined,
                                    color: Colors.grey.shade700, size: 20),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter a start time';
                                  }
                                  return null;
                                },
                                onSave: (value) {
                                  _taskStartTime = value!;
                                },
                              ),
                            ),
                            const SizedBox(width: 16),
                            Flexible(
                              child: InputFormField(
                                initialValue: widget.task?.endTime ?? '',
                                hint: '17:00',
                                prefixIcon: null,
                                textInputType: TextInputType.text,
                                suffixIcon: Icon(Icons.watch_later_outlined,
                                    color: Colors.grey.shade700, size: 20),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter a end time';
                                  }
                                  return null;
                                },
                                onSave: (value) {
                                  _taskEndTime = value!;
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        InputFormField(
                          initialValue:
                              widget.task?.description ?? 'tiktak.....',
                          maxLines: 6,
                          hint: 'Content....',
                          prefixIcon: null,
                          textInputType: TextInputType.text,
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                value.trim().length <= 1 ||
                                value.trim().length >= 50) {
                              return 'Please enter a discription';
                            }
                            return null;
                          },
                          onSave: (value) {
                            _taskDescript = value!;
                          },
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'Color',
                          style:
                              TextStyle(color: Color(0xFF5F5F5F), fontSize: 16),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 60,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: colors.length,
                              itemBuilder: (context, index) {
                                return TaskColor(
                                  isSelected:
                                      widget.task?.color == colors[index]
                                          ? true
                                          : selectedIndex == index &&
                                                  widget.task == null
                                              ? true
                                              : false,
                                  color: colors[index],
                                  pressFunct: () {
                                    setState(() {
                                      selectedIndex = index;
                                    });
                                  },
                                );
                              }),
                        ),
                        const SizedBox(height: 40),
                        Align(
                            alignment: Alignment.bottomRight,
                            child: RoundButton(text: 'Add', onPress: _addTask)),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
