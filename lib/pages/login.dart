import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rcbg_real/components/loginForm.dart';
import 'package:rcbg_real/components/regForm.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool register = false;

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomRight,
            end: Alignment.topLeft,
            colors: isDarkMode
                ? [Colors.black, Colors.grey.shade800]
                : [
                    Theme.of(context).colorScheme.secondary,
                    Theme.of(context).colorScheme.primary
                  ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/ECHO.png', // Replace with your image path
                height: 100.0, // Adjust the height as needed
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  color: Colors.white,
                  child: Column(
                    children: [
                      register
                          ? Regform(register: register)
                          : LoginForm(register: register),
                      RichText(
                        text: TextSpan(
                          text: !register
                              ? 'Don\'t have an account? '
                              : 'Already have an account? ',
                          style: GoogleFonts.dmSans(
                            fontSize: 10,
                            color: Color(0xFF455A64),
                          ),
                          children: [
                            TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  setState(() {
                                    register = !register;
                                  });
                                },
                              text: register ? 'Login here' : 'Register here',
                              style: GoogleFonts.dmSans(
                                decoration: TextDecoration.underline,
                                color: Color(0xFF455A64),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
