import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:camera/camera.dart';
import 'package:flutter/services.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  
  int _selectedIndex = 0;
  String extractedText = '';
  final GenerativeModel _model = GenerativeModel(
    model: 'gemini-1.5-flash-latest',
    apiKey: 'AIzaSyDa4JxMPc1b1eDQV2-TAnTznxa9LGKSZLI',
  );

  Future<void> generateStory(String prompt) async {
    final content = [Content.text(prompt)];
    final response = await _model.generateContent(content);
    setState(() {
      extractedText = response.text.toString();
    });
  }

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

  late XFile? pickImage;
  late String resultText;

  Future<void> getImage(ImageSource imgSource) async {
    try {
      pickImage = (await ImagePicker().pickImage(source: imgSource))!;
      if (pickImage != null) {
        final inputImage = InputImage.fromFilePath(pickImage!.path);
        final textRecognizer = TextRecognizer();
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        );       
        final RecognizedText recognizedText = await textRecognizer.processImage(inputImage);
        await generateStory("Summarize thia: ${recognizedText.text}");
        Navigator.of(context).pop();
              Navigator.pushNamed(context, '/summarized', arguments: {'extractedText': extractedText});
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {

    logout() {
      FirebaseAuth.instance.signOut();
    }

    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/images/ECHO.png', // Replace with your image path
          height: 40.0, // Adjust the height as needed
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: logout,
          ),
        ],
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
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 200.0, // Set the height to 200
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10.0), // Add rounded edges with a radius of 10
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0), // Add padding if needed
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Good day, User!',
                          style: GoogleFonts.dmSans(
                            fontWeight: FontWeight.bold,
                            color: Colors.white, // Adjust the color to make it visible on the image
                            fontSize: 24.0,
                          ),
                        ),
                        Text(
                          'Welcome back!',
                          style: GoogleFonts.dmSans(
                            fontWeight: FontWeight.normal,
                            color: Colors.white, // Adjust the color to make it visible on the image
                            fontSize: 18.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30.0),
            Text(
              'Popular',
              style: GoogleFonts.dmSans(
                fontWeight: FontWeight.bold,
                color: Color(0xFF455A64),
                fontSize: 20.0,
              ),
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
        onPressed: () async {
          await getImage(ImageSource.camera);
          if (pickImage != null) {
         
          }
        },
        child: Icon(Icons.document_scanner_outlined),
        backgroundColor: Color(0xFF1E88E5),
        shape: CircleBorder(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
