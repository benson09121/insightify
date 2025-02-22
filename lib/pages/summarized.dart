import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rcbg_real/global.dart';

class Summarized extends StatefulWidget {
  const Summarized({super.key});

  @override
  State<Summarized> createState() => _SummarizedState();
}

class _SummarizedState extends State<Summarized> {
  bool isSaved = false;
  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)!.settings.arguments as Map;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'SUMMARIZED TEXT',
          style: GoogleFonts.dmSans(
            fontWeight: FontWeight.bold,
            color: Color(0xFF455A64),
            fontSize: 16.0,
          ),
        ),
        iconTheme: IconThemeData(
          color: Color(0xFF455A64), // Change this to your desired color
        ),
        actions: [],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(4.0),
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xFFD9D9D9),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            height: 1.0,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: ListView(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(
                  color: Color(0xFFD9D9D9),
                  width: 1.0,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              padding: const EdgeInsets.all(16.0),
              child: Text(
                arg['extractedText'],
                style: GoogleFonts.dmSans(
                  fontWeight: FontWeight.normal,
                  color: Color(0xFF455A64),
                  fontSize: 16.0,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text(
                        'Confirmation',
                        style: GoogleFonts.dmSans(
                          fontWeight: FontWeight.bold,
                          color: Color(
                              0xFF455A64), // Change this to your desired color
                        ),
                      ),
                      content: Text(
                        'Do you want to proceed?',
                        style: GoogleFonts.dmSans(
                          fontWeight: FontWeight.normal,
                          color: Color(
                              0xFF455A64), // Change this to your desired color
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            'Cancel',
                            style: GoogleFonts.dmSans(
                              fontWeight: FontWeight.bold,
                              color: Colors
                                  .red, // Change this to your desired color
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            // var uid = FirebaseAuth.instance.currentUser!.uid;
                            summarized = arg['extractedText'];
                            // FirebaseFirestore.instance
                            //     .collection('summarized')
                            //     .add({
                            //   'uid': uid,
                            //   'email': FirebaseAuth.instance.currentUser!.email,
                            //   'sumText': arg['extractedText'],
                            //   'date_created': DateTime.now()
                            // });
                            Navigator.pop(context);
                            Navigator.pushNamed(context, '/record');
                          },
                          child: Text(
                            'Proceed',
                            style: GoogleFonts.dmSans(
                              fontWeight: FontWeight.bold,
                              color: Colors
                                  .green, // Change this to your desired color
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF1E88E5),
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(10.0), // Add rounded edges
                ),
              ),
              child: Text(
                'TEACH',
                style: GoogleFonts.dmSans(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 16.0,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: isSaved
                  ? () {}
                  : () {
                      var uid = FirebaseAuth.instance.currentUser!.uid;
                      summarized = arg['extractedText'];
                      FirebaseFirestore.instance.collection('summarized').add({
                        'uid': uid,
                        'email': FirebaseAuth.instance.currentUser!.email,
                        'sumText': arg['extractedText'],
                        'date_created': DateTime.now()
                      });
                      setState(() {
                        isSaved = true;
                      });
                    },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 14, 69, 117),
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(10.0), // Add rounded edges
                ),
              ),
              child: Text(
                isSaved ? 'SAVED TO HISTORY' : 'SAVE',
                style: GoogleFonts.dmSans(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 16.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
