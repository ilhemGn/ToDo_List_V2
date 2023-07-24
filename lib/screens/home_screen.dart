import 'package:flutter/material.dart';
import 'package:todo_list_v2/constants.dart';
import 'package:todo_list_v2/screens/profile_screen.dart';
import 'package:todo_list_v2/screens/task_details.dart';
import 'package:todo_list_v2/widgets/tasks_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? name;

  @override
  void initState() {
    super.initState();
  }

  // refreshTodos() async {
  //   //todos = await DatabaseService.instance.readAllNotes();
  //   setState(() async {
  //     Provider.of<TaskData>(context).todos =
  //         await DatabaseService.instance.readAllNotes();

  //   });
  // }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFEDEFF2),
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              GestureDetector(
                onTap: () async {
                  var userName = await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ProfileScreen()));
                  if (userName != null) {
                    setState(() {
                      name = userName;
                    });
                  }
                },
                child: Container(
                  height: 90,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  padding: const EdgeInsets.all(6),
                  child: Center(
                    child: ListTile(
                      leading: const CircleAvatar(
                        backgroundColor: Color(0xFFF5E2CA),
                        child: Icon(Icons.person, color: Colors.white),
                      ),
                      title: Text('Hi ${name ?? 'no name'}',
                          style: kStyleAppBarTitle),
                      subtitle: name != null
                          ? const Text('Good Morning')
                          : const Text(
                              "please complete your profile",
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold),
                            ),
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        size: 18,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(left: 16, right: 16),
                  hintText: 'Search.....',
                  suffixIcon: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.search, color: Colors.grey.shade400)),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide.none,
                  ),
                  hintStyle: TextStyle(color: Colors.grey.shade400),
                  filled: true,
                  isDense: true,
                  fillColor: Colors.white,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    color: Colors.white,
                    height: 1.4,
                    width: 150,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(
                      icon: const Icon(Icons.add_circle),
                      color: Colors.white,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const TaskDetails()),
                        );
                      },
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    height: 1.4,
                    width: 150,
                  ),
                ],
              ),
              const Expanded(
                child: TasksList(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
