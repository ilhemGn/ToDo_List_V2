import 'package:flutter/material.dart';
import 'package:todo_list_v2/constants.dart';

import 'package:todo_list_v2/screens/register_screen.dart';
import 'package:todo_list_v2/widgets/input_field.dart';
import 'package:todo_list_v2/widgets/round_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';

final _firebase = FirebaseAuth.instance;

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final _formKey = GlobalKey<FormState>();
  var _enteredEmail = '';
  var _enteredPassword = '';

  void _signIn() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      try {
        final userCredential = await _firebase.signInWithEmailAndPassword(
            email: _enteredEmail, password: _enteredPassword);
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
                const SizedBox(height: 10.0),
                Center(
                  child: Text(
                    'Sign In',
                    style: TextStyle(
                        color: kTextColor,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 50.0),
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        InputFormField(
                          label: '',
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
                          label: '',
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
                const SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          value: true,
                          activeColor: kFieldColor,
                          checkColor: Colors.grey,
                          focusColor: Colors.grey,
                          onChanged: (newValue) {},
                        ),
                        const Text("Remember Me")
                      ],
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        "Forget Password",
                        style: TextStyle(fontSize: 13, color: kStartColor),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30.0),
                RoundButton(
                  text: 'Sign In!',
                  backgroundColor: kStartColor,
                  colorText: const Color(0xFF524E48),
                  onPress: _signIn,
                ),
              ],
            ),
          ),
          Row(
            children: [
              const Spacer(),
              IconButton(
                onPressed: () {},
                icon: const CircleAvatar(
                    backgroundColor: kFieldColor,
                    child: Icon(
                      FontAwesomeIcons.google,
                      color: Colors.red,
                      size: 18,
                    )),
              ),
              const SizedBox(width: 20.0),
              IconButton(
                onPressed: () {},
                icon: const CircleAvatar(
                    backgroundColor: kFieldColor,
                    child: Icon(
                      FontAwesomeIcons.facebookF,
                      color: Colors.blue,
                      size: 18,
                    )),
              ),
              const Spacer()
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.07),
          Row(
            children: [
              const Spacer(),
              const Text("Don't have Account?"),
              TextButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushReplacement(MaterialPageRoute(builder: (context) {
                      return const RegisterScreen();
                    }));
                  },
                  child: const Text(
                    "Sign up",
                    style: TextStyle(color: Color(0xFFE4B476)),
                  )),
              const Spacer(),
            ],
          )
        ],
      ),
    ));
  }
}
