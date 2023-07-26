import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:todo_list_v2/constants.dart';
import 'package:todo_list_v2/models/task_model.dart';
import 'package:todo_list_v2/providers/user_provider.dart';
import 'package:todo_list_v2/screens/profile_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_list_v2/screens/task_details.dart';
import 'package:todo_list_v2/widgets/tasks_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_list_v2/providers/tasks_provider.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  late List<Task> userTasks;

  void _setUpNotification() async {
    final fcm = FirebaseMessaging.instance;
    await fcm.requestPermission();
    final token = await fcm.getToken();
   // print(token);
    //notification text to add a new task
    await fcm.subscribeToTopic('addTask');
  }

  @override
  void initState() {
    _getUserData();
    _setUpNotification();
    super.initState();
  }

  void _getUserData() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    //get userData from firestore
    final userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser!.uid)
        .get();
    //update user data in provider
    ref.read(userProvider.notifier).updateUserData(
        userData.data()!['username'],
        userData.data()!['email'],
        int.parse(userData.data()!['phone']),
        userData.data()!['image']);

    //verify if the user has tasks or not
    final taskCol = FirebaseFirestore.instance
        .collection('tasks')
        .where('userId', isEqualTo: currentUser.uid);

    if ((await taskCol.get()).docs.isNotEmpty) {
      //get user tasks from firestore
      final userTasks = await taskCol.get();
      //update user tasks in provider
      ref.read(userTasksProvider.notifier).loadUserTasks(userTasks);
    }
  }

  @override
  Widget build(BuildContext context) {
    String username = ref.watch(userProvider).name;
    String userImage = ref.watch(userProvider).image;
    userTasks = ref.watch(userTasksProvider);
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFEDEFF2),
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ProfileScreen()));
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
                      leading: CircleAvatar(
                        backgroundColor: kStartColor,
                        backgroundImage: NetworkImage(userImage),
                        //child: const Icon(Icons.person, color: Colors.white),
                      ),
                      title: Text('Hi $username', style: kStyleAppBarTitle),
                      subtitle: const Text('Good Morning'),
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
              Expanded(
                child: userTasks.isEmpty
                    ? const Center(
                        child: Text(' Start adding some tasks ',
                            style: TextStyle(
                              // add style //
                              color: Colors.grey,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            )),
                      )
                    : TasksList(
                        todos: userTasks,
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
