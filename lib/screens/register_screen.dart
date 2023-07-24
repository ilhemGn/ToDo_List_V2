import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todo_list_v2/constants.dart';
import 'package:todo_list_v2/screens/login_screen.dart';
import 'package:todo_list_v2/widgets/round_button.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    emailController.clear();
    passwordController.clear();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
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
              children: [
                const SizedBox(height: 10.0),
                Center(
                  child: Text(
                    'Register Now',
                    style: TextStyle(
                        color: kTextColor,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 50.0),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                      hintText: "Usermail@example.com",
                      hintStyle: const TextStyle(
                          color: Colors.black54, fontSize: 14.5),
                      border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          borderSide: BorderSide.none),
                      prefixIcon: const Icon(
                        Icons.email,
                        color: Colors.white,
                        size: 20,
                      ),
                      filled: true,
                      isDense: true,
                      fillColor: kFieldColor),
                ),
                const SizedBox(height: 10.0),
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: "Password",
                    hintStyle:
                        const TextStyle(color: Colors.black54, fontSize: 14.5),
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide: BorderSide.none),
                    prefixIcon: const Icon(
                      FontAwesomeIcons.lock,
                      color: Colors.white,
                      size: 20,
                    ),
                    filled: true,
                    isDense: true,
                    fillColor: kFieldColor,
                  ),
                ),
                const SizedBox(height: 40.0),
                RoundButton(
                  text: 'Register!',
                  backgroundColor: kStartColor,
                  colorText: const Color(0xFF524E48),
                  onPress: () {},
                ),
              ],
            ),
          ),
          Row(
            children: [
              const Spacer(),
              const Text("Already have Account! "),
              TextButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushReplacement(MaterialPageRoute(builder: (context) {
                      return const LogInScreen();
                    }));
                  },
                  child: const Text(
                    "login",
                    style: TextStyle(color: Color(0xFFE4B476)),
                  )),
              const Spacer(),
            ],
          )
        ],
      ),
    );
  }
}
