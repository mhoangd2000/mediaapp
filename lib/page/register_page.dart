import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mediaapp/component/my_button.dart';
import 'package:mediaapp/component/my_textfield.dart';
import 'package:mediaapp/helper/helper_functions.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
//text controller
  final TextEditingController userNameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController confirmPwController = TextEditingController();

  //register method
  void registerUser() async {
    //show loading circle
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
    // password does not match
    if (passwordController.text.trim() != confirmPwController.text.trim()) {
      //pop the loading circle
      Navigator.pop(context);

      // show error message
      displayMessageToUser("password dont match", context);
    }
    //password do match
    else {
      // try register user
      try {
        UserCredential? userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: emailController.text, password: passwordController.text);

        // create a user document and add to firestore
        createUserDocument(userCredential);

        //pop the loading circle
        if (context.mounted) Navigator.pop(context);
      } on FirebaseAuthException catch (e) {
        //pop context
        Navigator.pop(context);
        // display errors
        displayMessageToUser(e.code, context);
      }
    }
  }

  // create a user document and collect them in firestore
  Future<void> createUserDocument(UserCredential? userCredential) async {
    if (userCredential != null && userCredential.user != null) {
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(userCredential.user!.email)
          .set({
        'email': userCredential.user!.email,
        'username': userNameController.text
      });
    }
  }
  // bool passwordConfirmed() {
  //   if (passwordController.text.trim() != confirmPwController.text.trim()) {
  //     return false;
  //   } else {
  //     return true;
  //   }
  // }

  @override
  void dispose() {
    userNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPwController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(
                25.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 120),
                  Text(
                    "M I N I M A L",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  // user name textfield
                  MyTextFieldd(
                      hintText: 'user name',
                      obscureText: false,
                      controller: userNameController),
                  const SizedBox(
                    height: 20,
                  ),
                  // email textField
                  MyTextFieldd(
                      hintText: 'email',
                      obscureText: false,
                      controller: emailController),
                  const SizedBox(
                    height: 20,
                  ),
                  // password
                  MyTextFieldd(
                      hintText: 'password ',
                      obscureText: true,
                      controller: passwordController),
                  const SizedBox(
                    height: 20,
                  ),
                  //confirm password
                  MyTextFieldd(
                      hintText: 'confirm password',
                      obscureText: true,
                      controller: confirmPwController),
                  const SizedBox(
                    height: 20,
                  ),
                  // register password
                  MyButton(
                    text: 'Register',
                    onTap: registerUser,
                  ),
                  const SizedBox(
                    height: 25,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Already have an account '),
                      GestureDetector(
                        onTap: widget.onTap,
                        child: const Text(
                          'Login here',
                          style: TextStyle(
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
