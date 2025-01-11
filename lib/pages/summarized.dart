import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Summarized extends StatefulWidget {
  const Summarized({super.key});

  @override
  State<Summarized> createState() => _SummarizedState();
}

class _SummarizedState extends State<Summarized> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    logout() {
      FirebaseAuth.instance.signOut();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('SUMMARIZED TEXT',
          style: GoogleFonts.dmSans(
            fontWeight: FontWeight.bold,
            color: Color(0xFF455A64),
          ),
        ),
        actions: [
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(4.0), 
          child: Container(
            color: Color(0xFFD9D9D9), 
            height: 1.0,
          ),
        ),
      ),
    );
  }
}