import 'package:flutter/material.dart';
import 'package:todo_list_v2/widgets/input_field.dart';
//import 'package:to_do_list/widgets/round_button.dart';

import 'package:todo_list_v2/widgets/task_color.dart';

class TaskDetails extends StatefulWidget {
  // final TodoModel? todoModel;
  const TaskDetails({
    super.key,
    //this.todoModel,
  });

  @override
  State<TaskDetails> createState() => _TaskDetailsState();
}

class _TaskDetailsState extends State<TaskDetails> {
  TextEditingController taskNameController = TextEditingController();
  TextEditingController taskDescriptionControllr = TextEditingController();
  TextEditingController startTaskController = TextEditingController();
  TextEditingController endTaskController = TextEditingController();

  @override
  void initState() {
    // if (widget.todoModel != null) {
    //   taskNameController.text = widget.todoModel!.title;
    //   taskDescriptionControllr.text = widget.todoModel!.description;
    //   //cast startTaskController.text equal to string  widget.todoModel!.starting;
    //cast endTaskController.text equal to string  widget.todoModel!.ending;
    // }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Color> colors = const [
      Color(0xFFFAD2D2),
      Color(0xFFF2C552),
      Color(0xFF5486E9),
      Color(0xFF81DF96),
      Color(0xFFE0BBF8)
    ];
    bool isSelected = true;

    return Scaffold(
      backgroundColor: const Color(0xFFF5E2CA),
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: const Color(0xFFF5E2CA),
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
            Expanded(
              child: ListView(
                shrinkWrap: true,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(20),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Add',
                        style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(20, 40, 20, 10),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(55),
                          topLeft: Radius.circular(55)),
                      color: Colors.white,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InputFormField(
                          label: 'Task Name',
                          hint: 'Workout for 30min',
                          prefixIcon: null,
                          textInputType: TextInputType.text,
                          validator: (value) {},
                          onSave: (value) {},
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: InputFormField(
                                label: 'Start Time',
                                hint: '16:00',
                                prefixIcon: null,
                                textInputType: TextInputType.datetime,
                                suffixIcon: Icon(Icons.watch_later_outlined,
                                    color: Colors.grey.shade700, size: 20),
                                validator: (value) {},
                                onSave: (value) {},
                              ),
                            ),
                            const SizedBox(width: 16),
                            Flexible(
                              child: InputFormField(
                                label: 'End Time',
                                hint: '17:00',
                                prefixIcon: null,
                                textInputType: TextInputType.datetime,
                                suffixIcon: Icon(Icons.watch_later_outlined,
                                    color: Colors.grey.shade700, size: 20),
                                validator: (value) {},
                                onSave: (value) {},
                              ),
                            ),
                          ],
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
                                  isSelected: isSelected,
                                  color: colors[index],
                                  pressFunct: () {
                                    setState(() {
                                      //selected color
                                      // for (int i = 0; i < colors.length; i++) {
                                      //   if (i != index) {
                                      //     isSelected = false;
                                      //   }
                                      // }
                                    });
                                  },
                                );
                              }),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        InputFormField(
                          label: 'Description',
                          hint: 'Content....',
                          prefixIcon: null,
                          textInputType: TextInputType.text,
                          validator: (value) {},
                          onSave: (value) {},
                        ),
                        const SizedBox(height: 20),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Container(
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15.0)),
                              color: Color(0xFFF5E2CA),
                            ),
                            height: 50.0,
                            width: 110.0,
                            child: TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text(
                                'Add',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.1,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
