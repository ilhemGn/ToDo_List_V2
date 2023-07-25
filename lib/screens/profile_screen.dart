import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:todo_list_v2/constants.dart';
import 'package:todo_list_v2/providers/user_provider.dart';
import 'package:todo_list_v2/widgets/image_input.dart';
import 'package:todo_list_v2/widgets/input_field.dart';
import 'package:todo_list_v2/screens/setting_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:io';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  var _enteredName = '';
  var _enteredEmail = '';
  var _enteredPhone = '';
  File? _pickedImage;
  final _formKey = GlobalKey<FormState>();

  _saveUserInfos() async {
    if (_formKey.currentState!.validate() && _pickedImage != null) {
      _formKey.currentState!.save();
      print(_enteredName);

      try {
        final storageRef = FirebaseStorage.instance
            .ref()
            .child('user_images')
            .child('$_enteredName.jpg');

        await storageRef.putFile(_pickedImage!);
        final urlImage = await storageRef.getDownloadURL();
      } catch (error) {
        print(error);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kFieldColor,
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              size: 20,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          centerTitle: true,
          title: const Text(
            'Profile',
            style: kStyleAppBarTitle,
          ),
          actions: [
            IconButton(
              onPressed: _saveUserInfos,
              icon: const Icon(Icons.save_alt_rounded),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              ImageInput(
                onPickImage: (selectedImage) {
                  _pickedImage = selectedImage;
                },
                firstImage: ref.watch(userProvider).image,
              ),
              const SizedBox(height: 20),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30)),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Your Name',
                            style: TextStyle(
                                fontSize: 16, color: Color(0xFF5F5F5F)),
                          ),
                          const SizedBox(height: 5),
                          InputFormField(
                            initialValue: ref.watch(userProvider).name,
                            hint: 'User name',
                            prefixIcon: const Icon(
                              Icons.person,
                              color: Colors.white,
                              size: 28,
                            ),
                            textInputType: TextInputType.name,
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  value.trim().length <= 1 ||
                                  value.trim().length >= 30) {
                                return 'Please enter a valid name';
                              }
                              return null;
                            },
                            onSave: (value) {
                              _enteredName = value!;
                            },
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'Email',
                            style: TextStyle(
                                fontSize: 16, color: Color(0xFF5F5F5F)),
                          ),
                          const SizedBox(height: 5),
                          InputFormField(
                            initialValue: ref.watch(userProvider).email,
                            hint: 'User@gmail.com',
                            prefixIcon: const Icon(
                              Icons.email,
                              color: Colors.white,
                              size: 26,
                            ),
                            textInputType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  !value.contains('@') ||
                                  value.trim().length >= 50) {
                                return 'Please enter a valid email address';
                              }
                              return null;
                            },
                            onSave: (value) {
                              _enteredEmail = value!;
                            },
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'Phone',
                            style: TextStyle(
                                fontSize: 16, color: Color(0xFF5F5F5F)),
                          ),
                          InputFormField(
                            initialValue:
                                ref.watch(userProvider).phone.toString(),
                            hint: '201204999542',
                            prefixIcon: const Icon(
                              Icons.phone,
                              color: Colors.white,
                              size: 26,
                            ),
                            textInputType: TextInputType.number,
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  value.length < 10 ||
                                  value.length > 10) {
                                return 'Please enter a valid number';
                              }
                              return null;
                            },
                            onSave: (value) {
                              _enteredPhone = value!;
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.09),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SettingScreen()));
                      },
                      child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
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
        ),
      ),
    );
  }
}
