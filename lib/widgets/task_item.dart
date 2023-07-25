import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TaskItem extends StatelessWidget {
  final Color coulour;
  final bool isChecked;
  final String title;
  final String startTime;
  final String endTime;
  final void Function() pressFunct;
  final void Function(bool?) checkboxCallback;
  final void Function() deleteFunct;

  const TaskItem(
      {super.key,
      required this.coulour,
      required this.isChecked,
      required this.title,
      required this.startTime,
      required this.endTime,
      required this.pressFunct,
      required this.checkboxCallback,
      required this.deleteFunct});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: pressFunct,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 13,
              width: 70,
              decoration: BoxDecoration(
                  color: coulour, borderRadius: BorderRadius.circular(10)),
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      decoration:
                          isChecked ? TextDecoration.lineThrough : null),
                ),
                IconButton(
                    padding: const EdgeInsets.only(left: 24),
                    onPressed: deleteFunct,
                    icon: const Icon(FontAwesomeIcons.trashCan,
                        size: 20, color: Color(0xFFFD4747)))
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.sort_outlined,
                      color: Color(0xFFE2E2E2),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text('$startTime - $endTime'),
                  ],
                ),
                Checkbox(
                  value: isChecked,
                  visualDensity:
                      const VisualDensity(horizontal: -4, vertical: -4),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  fillColor:
                      MaterialStateProperty.all(Colors.blueGrey.shade400),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4)),
                  onChanged: checkboxCallback,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
