import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todo_list_v2/constants.dart';
import 'package:todo_list_v2/screens/login_screen.dart';
import 'package:todo_list_v2/widgets/image_input.dart';
import 'package:todo_list_v2/widgets/round_button.dart';
import 'package:todo_list_v2/widgets/input_field.dart';
import 'dart:io';

final _firebase = FirebaseAuth.instance;

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  var _enteredEmail = '';
  var _enteredName = '';
  var _enteredPhone = '';
  var _enteredPassword = '';
  File? _pickedImage;

  void _register() async {
    if (_pickedImage == null) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Please pick an image for your profile')));
      return;
    }

    if (_formKey.currentState!.validate() && _pickedImage != null) {
      _formKey.currentState!.save();

      try {
        final userCredentials = await _firebase.createUserWithEmailAndPassword(
            email: _enteredEmail, password: _enteredPassword);
        //to strore the user image
        final storageRef = FirebaseStorage.instance
            .ref()
            .child('user_images')
            .child('${userCredentials.user!.uid}.jpg');

        await storageRef.putFile(_pickedImage!);
        //get the url where the image was stored
        final urlImage = await storageRef.getDownloadURL();

        //store user infos in firestore database
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredentials.user!.uid)
            .set({
          'username': _enteredName,
          'email': _enteredEmail,
          'phone': _enteredPhone,
          'image': urlImage,
        });
      } on FirebaseAuthException catch (error) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(error.message ?? 'Athentication failed')));
      }
    }
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(300),
                bottomRight: Radius.circular(300),
              ),
              child: Container(
                  color: kStartColor,
                  child: Center(
                      child: Image.asset(
                    'assets/images/ToDo_List.png',
                    width: 300,
                  ))),
            ),
            const SizedBox(height: 10.0),
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Register Now',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: kTextColor,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20.0),
                  ImageInput(
                    onPickImage: (selectedImage) {
                      _pickedImage = selectedImage;
                    },
                    backgroundColor: kFieldColor,
                  ),
                  Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          InputFormField(
                            initialValue: '',
                            hint: 'Usermail@example.com',
                            textInputType: TextInputType.emailAddress,
                            prefixIcon: const Icon(
                              Icons.email,
                              size: 20,
                              color: Colors.white,
                            ),
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  !value.contains('@') ||
                                  value.length >= 50) {
                                return 'Please enter a valid email address';
                              }
                              return null;
                            },
                            onSave: (value) {
                              _enteredEmail = value!;
                            },
                          ),
                          const SizedBox(height: 10.0),
                          InputFormField(
                            initialValue: '',
                            hint: 'UserName',
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
                                  value.trim().length >= 50) {
                                return 'Please enter a valid name';
                              }
                              return null;
                            },
                            onSave: (value) {
                              _enteredName = value!;
                            },
                          ),
                          const SizedBox(height: 10.0),
                          InputFormField(
                            initialValue: '',
                            hint: 'Phone Number',
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
                          const SizedBox(height: 10.0),
                          InputFormField(
                            initialValue: '',
                            hint: 'Password',
                            obscureText: true,
                            textInputType: TextInputType.text,
                            prefixIcon: const Icon(
                              FontAwesomeIcons.lock,
                              size: 20,
                              color: Colors.white,
                            ),
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  value.trim().length < 6) {
                                return 'Please enter a password at least 6 characters long';
                              }
                              return null;
                            },
                            onSave: (value) {
                              _enteredPassword = value!;
                            },
                          ),
                        ],
                      )),
                  const SizedBox(height: 40.0),
                  RoundButton(
                    text: 'Register',
                    backgroundColor: kStartColor,
                    colorText: const Color(0xFF524E48),
                    onPress: _register,
                  ),
                ],
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Already have Account!"),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) {
                        return const LogInScreen();
                      }));
                    },
                    child: const Text(
                      "Login",
                      style: TextStyle(color: kStartColor),
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
