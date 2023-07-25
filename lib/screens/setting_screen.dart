import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todo_list_v2/constants.dart';
import 'package:flutter/cupertino.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool _switchValueAdd = false;
  bool _switchValueTime = false;
  String? selectedMenu;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kFieldColor,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
              size: 18,
            )),
        centerTitle: true,
        title: const Text('Setting', style: kStyleAppBarTitle),
      ),
      body: ListView(
        children: [
          Column(children: [
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color: Colors.white,
              ),
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Push Notifications',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                      height: 20,
                      child: Divider(
                        height: 10,
                        color: Colors.grey[50],
                      )),
                  ListTile(
                    contentPadding: const EdgeInsets.all(0),
                    leading: Icon(FontAwesomeIcons.circlePlus,
                        color: kIconColor, size: 18),
                    title: const Text('Add List Notification'),
                    trailing: CupertinoSwitch(
                      value: _switchValueAdd,
                      onChanged: (value) {
                        setState(() {
                          _switchValueAdd = value;
                        });
                      },
                    ),
                  ),
                  SizedBox(
                      height: 20,
                      child: Divider(
                        height: 10,
                        color: Colors.grey[50],
                      )),
                  ListTile(
                    contentPadding: const EdgeInsets.all(0),
                    leading: Icon(FontAwesomeIcons.solidCircleCheck,
                        color: kIconColor, size: 18),
                    title: const Text('Time List Notification'),
                    trailing: CupertinoSwitch(
                      value: _switchValueTime,
                      onChanged: (value) {
                        setState(() {
                          _switchValueTime = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color: Colors.white,
              ),
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: ListTile(
                contentPadding: const EdgeInsets.all(0),
                leading:
                    Icon(Icons.language_outlined, color: kIconColor, size: 20),
                title: const Text('Add List Notification'),
                trailing: PopupMenuButton<String>(
                  surfaceTintColor: Colors.white,

                  icon: Icon(Icons.arrow_drop_down_rounded,
                      color: kIconColor, size: 30),
                  initialValue: selectedMenu,
                  // Callback that sets the selected popup menu item.
                  onSelected: (String item) {
                    setState(() {
                      selectedMenu = item;
                    });
                  },
                  itemBuilder: (BuildContext context) =>
                      <PopupMenuEntry<String>>[
                    const PopupMenuItem<String>(
                      value: 'English',
                      child: Text('English'),
                    ),
                    const PopupMenuItem<String>(
                      value: 'French',
                      child: Text('French'),
                    ),
                    const PopupMenuItem<String>(
                      value: 'Arabic',
                      child: Text('Arabic'),
                    ),
                  ],
                ),
              ),
            ),
          ]),
          SizedBox(height: MediaQuery.of(context).size.height * 0.37),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 48),
                backgroundColor: Colors.white,
                shape: const RoundedRectangleBorder(
                    side: BorderSide(
                      color: Color(0xffE31C1C),
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
              ),
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.logout, color: Colors.red, size: 20),
                  SizedBox(width: 20),
                  Text(
                    'Log Out',
                    style: TextStyle(color: Color(0xffE31C1C), fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
