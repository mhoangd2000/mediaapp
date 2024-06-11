import 'package:flutter/material.dart';

class MyTextFieldd extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final TextEditingController controller;
  const MyTextFieldd(
      {super.key,
      required this.hintText,
      required this.obscureText,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        hintText: hintText,
      ),
    );
  }
}
