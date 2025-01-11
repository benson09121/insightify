import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rcbg_real/components/inputText.dart';

class LoginForm extends StatefulWidget {
  final bool register;
  const LoginForm({super.key, required this.register});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  @override
  Widget build(BuildContext context) {
    var formkey = GlobalKey<FormState>();
    TextEditingController emailCon = TextEditingController();
    TextEditingController passCon = TextEditingController();

    login() async {
      if (formkey.currentState!.validate()) {
        try {
          await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: emailCon.text,
            password: passCon.text,
          );
        } on FirebaseAuthException catch (e) {
          if (e.code == 'user-not-found') {
            print('No user found for that email.');
          } else if (e.code == 'wrong-password') {
            print('Wrong password provided for that user.');
          } else {
            print('Error: ${e.message}');
          }
        }
      }
    }

    return Form(
      key: formkey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Column(
          children: [
            Text(
              'Login',
              textAlign: TextAlign.start,
              style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 30),
            ),
            SizedBox(
              height: 20,
            ),
            Inputtext(
              hintText: 'Email',
              obscureText: false,
              controller: emailCon,
              validator: (val) {
                if (val == null || val.isEmpty) {
                  return 'Please enter your email';
                }
                return null;
              },
            ),
            SizedBox(
              height: 10,
            ),
            Inputtext(
              hintText: 'Password',
              obscureText: true,
              controller: passCon,
              validator: (val) {
                if (val == null || val.isEmpty) {
                  return 'Please enter your password';
                }
                return null;
              },
            ),
            SizedBox(
              height: 20,
            ),
            MaterialButton(
              onPressed: login,
              color: Theme.of(context).colorScheme.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
