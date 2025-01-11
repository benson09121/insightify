import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class History extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<History> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushNamed(context, '/home'); // Replace with your home route
        break;
      case 1:
        Navigator.pushNamed(context, '/history'); // Replace with your timer route
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'HISTORY',
          style: GoogleFonts.dmSans(
            fontWeight: FontWeight.bold,
            color: Color(0xFF455A64), // Adjust the color as needed
            fontSize: 16.0, // Adjust the font size as needed
          ),
        ),
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
        padding: EdgeInsets.all(20.0),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end, // Align the icon to the right
              children: [
                IconButton(
                  icon: Icon(Icons.filter_list),
                  onPressed: () {
                    // Add your filter functionality here
                  },
                ),
                SizedBox(width: 5.0), // Add some space between the icon and the SizedBox
              ],
            ),
            SizedBox(height: 5.0),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 6, // Generate 6 cards
              itemBuilder: (context, index) {
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0), // Rounded edges
                    side: BorderSide(color: Color(0xFFD9D9D9)), // Add border
                  ),
                  elevation: 1, // Add shadow
                  margin: EdgeInsets.only(bottom: 16.0), // Space between cards
                  child: Padding(
                    padding: const EdgeInsets.all(16.0), // Add padding inside the card
                    child: Row(
                      children: [
                        // First column with two text widgets
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Advance Machine Learning',
                                style: GoogleFonts.dmSans(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0,
                                  color: Color(0xFF455A64),
                                ),
                              ),
                              SizedBox(height: 8.0), // Space between texts
                              Text(
                                'User',
                                style: GoogleFonts.dmSans(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 12.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Second column
                        Expanded(
                          flex: 1,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                '00:01:20',
                                style: GoogleFonts.dmSans(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 16.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Color(0xFFD9D9D9), // Replace with your desired color
              width: 1.0, // Adjust the width as needed
            ),
          ),
        ),
        child: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.timer),
              label: '',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Color(0xFF1E88E5), // Color when selected
          unselectedItemColor: Color(0xFF455A64), // Color when not selected
          onTap: _onItemTapped,
          showSelectedLabels: false,
          showUnselectedLabels: false,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/scan');
        },
        child: Icon(Icons.document_scanner_outlined),
        backgroundColor: Color(0xFF1E88E5),
        shape: CircleBorder(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}