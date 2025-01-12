// import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:rcbg_real/components/appBar.dart';
import 'package:rcbg_real/components/inputText2.dart';
import 'package:rcbg_real/global.dart';

class Assessment extends StatefulWidget {
  const Assessment({super.key});

  @override
  State<Assessment> createState() => _AssessmentState();
}

class _AssessmentState extends State<Assessment> {
  @override
  Widget build(BuildContext context) {
    // var per = result!.substring(1, result!.length - 2).split(',')[2];
    // var finalRes = jsonDecode(result);
    print(result);
    double percent = double.parse(result) / 100;
    bool isPublic = false;

    TextEditingController nameController = TextEditingController();
    var formkey = GlobalKey<FormState>();

    saveDialog() {
      saveRecording() {
        if (formkey.currentState!.validate()) {
          // good
          // clse dialog
          Navigator.pop(context);
        }
      }

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                actionsAlignment: MainAxisAlignment.center,
                title: Text(
                  'SAVE VOICE RECORDING',
                  style: GoogleFonts.dmSans(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF455A64),
                    fontSize: 16.0,
                  ),
                  textAlign: TextAlign.center,
                ),
                content: Form(
                  key: formkey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Inputtext2(
                          hintText: 'Name',
                          obscureText: false,
                          controller: nameController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a name';
                            }
                            return null;
                          }),
                      SizedBox(height: 20.0),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Public sharing',
                            style: GoogleFonts.dmSans(
                              fontWeight: FontWeight.normal,
                              color: Color(0xFF455A64),
                              fontSize: 16.0,
                            )),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: [
                            Switch(
                                value: isPublic,
                                onChanged: (val) {
                                  setState(() {
                                    isPublic = val;
                                  });
                                }),
                            SizedBox(width: 10.0),
                            Text(
                              isPublic ? 'Yes' : 'No',
                              style: GoogleFonts.dmSans(
                                fontWeight: FontWeight.normal,
                                color: Color(0xFF455A64),
                                fontSize: 16.0,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                actions: [
                  MaterialButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    color: Color.fromRGBO(203, 31, 19, 1),
                    child: Text('CANCEL',
                        style: GoogleFonts.dmSans(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 16.0,
                        )),
                  ),
                  MaterialButton(
                    onPressed: saveRecording,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    color: Color.fromRGBO(30, 136, 229, 1),
                    child: Text('OKAY',
                        style: GoogleFonts.dmSans(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 16.0,
                        )),
                  ),
                ],
              );
            },
          );
        },
      );
    }

    return Scaffold(
      appBar: const Appbar(title: 'ASSESSMENT'),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'YOUR RESULTS ARE',
                style: GoogleFonts.dmSans(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF455A64),
                  fontSize: 16.0,
                ),
              ),
              SizedBox(height: 50.0),
              CircularPercentIndicator(
                  radius: 120.0,
                  lineWidth: 20.0,
                  percent: percent,
                  progressColor: percent > .7
                      ? Color.fromRGBO(67, 160, 71, 1)
                      : Color.fromRGBO(203, 31, 19, 1),
                  circularStrokeCap: CircularStrokeCap.round,
                  center: Text(
                    '${percent * 100}%',
                    style: GoogleFonts.dmSans(
                      fontWeight: FontWeight.bold,
                      color: percent > .7
                          ? Color.fromRGBO(67, 160, 71, 1)
                          : Color.fromRGBO(203, 31, 19, 1),
                      fontSize: 50.0,
                    ),
                  )),
              SizedBox(height: 20.0),
              Text(
                percent > .7 ? 'Congratulations!' : 'You need to improve.',
                style: GoogleFonts.dmSans(
                  fontWeight: FontWeight.normal,
                  color: Color(0xFF455A64),
                  fontSize: 16.0,
                ),
              ),
              SizedBox(height: 20.0),
              Text(
                percent > .7
                    ? "It looks like you have a great mastery on the topic."
                    : "You likely need to spend more time on studying the concept of the text",
                textAlign: TextAlign.center,
                style: GoogleFonts.dmSans(
                  fontWeight: FontWeight.normal,
                  color: Color(0xFF455A64),
                  fontSize: 16.0,
                ),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: saveDialog,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF1E88E5),
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(10.0), // Add rounded edges
                  ),
                ),
                child: Text(
                  'SAVE',
                  style: GoogleFonts.dmSans(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF455A64),
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(10.0), // Add rounded edges
                  ),
                ),
                child: Text(
                  'HOME',
                  style: GoogleFonts.dmSans(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
