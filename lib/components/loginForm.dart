import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
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

    // const List<String> scopes = <String>[
    //   'email',
    //   'https://www.googleapis.com/auth/contacts.readonly',
    // ];

    // GoogleSignIn _googleSignIn = GoogleSignIn(
    //   // Optional clientId
    //   // clientId: 'your-client_id.apps.googleusercontent.com',
    //   scopes: scopes,
    // );

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

    // googleLogin() {}

    googleLogin() async {
      final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

      // pag nag cancel si user
      if (gUser == null) return;

      final GoogleSignInAuthentication gAuth = await gUser.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken,
        idToken: gAuth.idToken,
      );

      // Sign in to Firebase with the Google [UserCredential]

      await FirebaseAuth.instance.signInWithCredential(credential);
    }

    return Form(
      key: formkey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            Text(
              'Login',
              textAlign: TextAlign.start,
              style: GoogleFonts.dmSans(
                color: Color(0xFF455A64),
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
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
            MaterialButton(
              onPressed: login,
              color: Color(0xFF1E88E5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                'Login',
                style: GoogleFonts.dmSans(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Divider(
              color: Colors.grey,
            ),
            // MaterialButton(
            //   padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
            //   onPressed: googleLogin,
            //   color: Color(0xFF1E88E5),
            //   shape: RoundedRectangleBorder(
            //     borderRadius: BorderRadius.circular(10),
            //   ),
            //   child: Row(
            //     mainAxisSize: MainAxisSize.min,
            //     children: [
            //       Image.asset(
            //         'assets/icon/google.png',
            //         height: 20,
            //       ),
            //       SizedBox(
            //         width: 10,
            //       ),
            //       Text(
            //         'Login with Google',
            //         style: GoogleFonts.dmSans(
            //           color: Colors.white,
            //           fontWeight: FontWeight.bold,
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            // TextButton(
            //   onPressed: () {},
            //   child: Text(
            //     'Register here',
            //     style: TextStyle(
            //         color: Theme.of(context).colorScheme.primary,
            //         fontWeight: FontWeight.bold),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
