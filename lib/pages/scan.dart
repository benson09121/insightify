import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class Scan extends StatefulWidget {
  const Scan({super.key});

  @override
  State<Scan> createState() => _ScanState();
}

class _ScanState extends State<Scan> {
  bool _isFlashOn = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 5), () {
      Navigator.pushNamed(context, '/summarized'); 
    });
  }

  void _toggleFlash() {
    setState(() {
      _isFlashOn = !_isFlashOn;
    });
    // Add your flash toggle functionality here
  }

  @override
  Widget build(BuildContext context) {
    logout() {
      FirebaseAuth.instance.signOut();
    }

    return Scaffold(
      body: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Colors.blue, 
              ),
            ),

            //top bar
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    icon: Icon(_isFlashOn ? Icons.flash_on : Icons.flash_off),
                    onPressed: _toggleFlash,
                    color: Colors.white,
                  ),
                  Text(
                    'SCAN',
                    style: GoogleFonts.dmSans(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 20.0, 
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      Navigator.pushNamed(context, '/home');
                    },
                    color: Colors.white,
                  ),
                ],
              ),
            ),

            //progress
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 50.0),
                child: Text('50%',
                  style: GoogleFonts.dmSans(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF455A64),
                    fontSize: 30.0,
                  ),
                ),
              ),
            )
            
          ],
        ),
    
    );
  }
}