import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Appbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const Appbar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
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
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
