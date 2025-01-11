import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Record extends StatefulWidget {
  const Record({super.key});

  @override
  State<Record> createState() => _RecordState();
}

class _RecordState extends State<Record> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'RECORD VOICE',
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

      body: Column(
        children: [
          SizedBox(height: 50.0),
          Center(
            child: Text(
              '00:00:00',
              style: GoogleFonts.dmSans(
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E88E5),
                fontSize: 40.0,
              ),
            ),
          )
        ],
      ),
      
    );
  }
}