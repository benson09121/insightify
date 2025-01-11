import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Inputtext2 extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  const Inputtext2(
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
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            // style: BorderStyle.none,
            width: 0,
            color: Colors.grey,
          ),
        ),
        hintText: hintText,
        hintStyle: GoogleFonts.dmSans(
          fontWeight: FontWeight.normal,
          color: Colors.grey[400],
          fontSize: 16.0,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            // style: BorderStyle.none,
            color: Colors.grey,
            width: 0,
          ),
        ),
      ),
      validator: validator,
    );
  }
}
