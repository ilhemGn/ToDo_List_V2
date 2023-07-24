import 'package:flutter/material.dart';

class TaskColor extends StatefulWidget {
  final void Function() pressFunct;
  final bool isSelected;
  final Color color;

  const TaskColor(
      {super.key,
      required this.pressFunct,
      required this.color,
      required this.isSelected});

  @override
  State<TaskColor> createState() => _TaskColorState();
}

class _TaskColorState extends State<TaskColor> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          // setState(() {
          //   widget.isSelected = !widget.isSelected;
          // });
          // //widget.pressFunct();
        },
        child: CircleAvatar(
          backgroundColor:
              widget.isSelected ? Colors.grey.shade200 : Colors.white,
          radius: 20,
          child: CircleAvatar(backgroundColor: widget.color, radius: 15),
        ));
  }
}
