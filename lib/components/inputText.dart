import 'package:flutter/material.dart';

class Inputtext extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  const Inputtext(
      {super.key,
      required this.hintText,
      required this.obscureText,
      required this.controller,
      this.validator});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(
          // color: Theme.of(context).colorScheme.primary,
          ),
      obscureText: obscureText,
      controller: controller,
      decoration: InputDecoration(
        // labelText: 'Email',

        hintText: hintText,
        fillColor: Theme.of(context).colorScheme.tertiary,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            style: BorderStyle.none,
            width: 0,
          ),
        ),
      ),
      validator: validator,
    );
  }
}
