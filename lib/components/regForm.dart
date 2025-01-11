import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rcbg_real/components/inputText.dart';

class Regform extends StatefulWidget {
  final bool register;
  const Regform({super.key, required this.register});

  @override
  State<Regform> createState() => _RegformState();
}

class _RegformState extends State<Regform> {
  @override
  Widget build(BuildContext context) {
    var formkey = GlobalKey<FormState>();
    TextEditingController emailCon = TextEditingController();
    TextEditingController passCon = TextEditingController();
    TextEditingController conCon = TextEditingController();

    register() async {
      if (formkey.currentState!.validate()) {
        try {
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailCon.text,
            password: passCon.text,
          );
        } on FirebaseAuthException catch (e) {
          if (e.code == 'weak-password') {
            print('The password provided is too weak.');
          } else if (e.code == 'email-already-in-use') {
            print('The account already exists for that email.');
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
              'Register',
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
              height: 10,
            ),
            Inputtext(
              hintText: 'Confirm Password',
              obscureText: true,
              controller: conCon,
              validator: (val) {
                if (val == null || val.isEmpty) {
                  return 'Please enter your password';
                } else {
                  if (val != passCon.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                }
              },
            ),
            SizedBox(
              height: 20,
            ),
            MaterialButton(
              onPressed: register,
              color: Theme.of(context).colorScheme.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
