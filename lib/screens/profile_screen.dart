import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:todo_list_v2/constants.dart';
import 'package:todo_list_v2/widgets/input_field.dart';
import 'package:todo_list_v2/screens/setting_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late String? name, email, phone;
  bool editingMode = false;

  @override
  void initState() {
    if (kDebugMode) {
      print("$name $email $phone");
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController =
        TextEditingController(text: name ?? 'not set yet');
    TextEditingController emailController =
        TextEditingController(text: email ?? 'not set yet');
    TextEditingController phoneController =
        TextEditingController(text: phone ?? 'not set yet');

    return SafeArea(
      child: Scaffold(
        backgroundColor: kFieldColor,
        appBar: _buildBar(nameController),
        body: _buildBody(nameController, emailController, phoneController),
        resizeToAvoidBottomInset: true,
      ),
    );
  }

  AppBar _buildBar(TextEditingController nameController) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios,
          size: 20,
        ),
        onPressed: () {
          Navigator.pop(context, nameController.text);
        },
      ),
      centerTitle: true,
      title: const Text(
        'Profile',
        style: kStyleAppBarTitle,
      ),
      actions: [
        IconButton(
            onPressed: () {
              if (editingMode) {
                setState(() {
                  editingMode = false;
                });

                if (kDebugMode) {
                  print("$name $email $phone");
                }
              }
            },
            icon: editingMode ? const Icon(Icons.save) : const Icon(Icons.menu))
      ],
    );
  }

  Widget _buildBody(
      TextEditingController nameController,
      TextEditingController emailController,
      TextEditingController phoneController) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 50.0),
            child: Center(child: _ProfileIconWidget()),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30)),
              color: Colors.white,
            ),
            child: Column(
              children: [
                InputFormField(
                  label: 'Your Name',
                  hint: 'Ahmed Salem',
                  prefixIcon: const Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 28,
                  ),
                  textInputType: TextInputType.name,
                  validator: (value) {},
                  onSave: (value) {},
                ),
                const SizedBox(height: 10),
                InputFormField(
                  label: 'Email',
                  hint: 'Ahmed@gmail.com',
                  prefixIcon: const Icon(
                    Icons.email,
                    color: Colors.white,
                    size: 26,
                  ),
                  textInputType: TextInputType.emailAddress,
                  validator: (value) {},
                  onSave: (value) {},
                ),
                const SizedBox(
                  height: 10,
                ),
                InputFormField(
                  label: 'Phone',
                  hint: '201204999542',
                  prefixIcon: const Icon(
                    Icons.phone,
                    color: Colors.white,
                    size: 26,
                  ),
                  textInputType: TextInputType.number,
                  validator: (value) {},
                  onSave: (value) {},
                ),
                const SizedBox(
                  height: 100,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SettingScreen()));
                  },
                  child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                        color: kFieldColor,
                      ),
                      child: const ListTile(
                        leading: Icon(Icons.settings, color: Colors.white),
                        title: Text(
                          'Settings',
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                        ),
                      )),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileIconWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const CircleAvatar(
      radius: 50,
      backgroundColor: Colors.white,
      child: Icon(
        Icons.person,
        size: 60,
        color: Color.fromARGB(255, 210, 210, 210),
      ),
    );
  }
}
