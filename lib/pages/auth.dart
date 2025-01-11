import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rcbg_real/pages/assessment.dart';
import 'package:rcbg_real/pages/home.dart';
import 'package:rcbg_real/pages/login.dart';
import 'package:rcbg_real/pages/summarized.dart';

class Auth extends StatelessWidget {
  const Auth({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snapshot.hasData) {
              return const Home();
            }

            return const Login();
          }),
    );
  }
}
