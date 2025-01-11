import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
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
              Icon(
                Icons.rocket_launch,
                size: 100,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  color: Theme.of(context).colorScheme.inversePrimary,
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
                          style: TextStyle(
                              fontSize: 10,
                              color: Theme.of(context).colorScheme.primary),
                          children: [
                            TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  setState(() {
                                    register = !register;
                                  });
                                },
                              text: register ? 'Login here' : 'Register here',
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: Theme.of(context).colorScheme.primary,
                                  fontWeight: FontWeight.bold),
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
