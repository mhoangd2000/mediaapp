import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mediaapp/component/my_button.dart';
import 'package:mediaapp/component/my_textfield.dart';

import '../helper/helper_functions.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  void register() {}

  void login() async {
    //show the circle loading
    showDialog(
        context: context,
        builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ));
    //try sign in
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text.trim());
      //pop the circle
      if (context.mounted) Navigator.pop(context);
    }
    //display errors
    on FirebaseAuthException catch (e) {
      //pop the circle
      Navigator.pop(context);
      displayMessageToUser(e.code, context);
    }
  }

// Text controller
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo
              Icon(
                Icons.person,
                size: 80,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
              const SizedBox(
                height: 20,
              ),
              // app name
              Text(
                'M I N I M A L',
                style: TextStyle(
                  fontSize: 20,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              // email text field
              MyTextFieldd(
                  hintText: 'email',
                  obscureText: false,
                  controller: emailController),
              const SizedBox(
                height: 20,
              ),
              // password text field
              MyTextFieldd(
                  hintText: 'password',
                  obscureText: true,
                  controller: passwordController),
              const SizedBox(
                height: 15,
              ),
              // Text forgot password
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Text(
                      "Forgot pasword",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              // sign in button
              MyButton(
                text: 'LOGIN',
                onTap: login,
              ),
              const SizedBox(
                height: 20,
              ),
              // Don't have an account? register here
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("don't have an account? "),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: const Text(
                      "Register here!",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
