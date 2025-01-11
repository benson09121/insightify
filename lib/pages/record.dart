import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:speech_to_text/speech_to_text.dart';

class Record extends StatefulWidget {
  @override
  _RecordPageState createState() => _RecordPageState();
}

final SpeechToText speechToText = SpeechToText();
bool speechEnabled = false;
String wordsSpoken = '';
double confiLevel = 0;
bool isListening = false;

class _RecordPageState extends State<Record> {
  bool isRecording = false;
  double progress = 0.0;
  String? recordedFilePath;

  // dddd
  // final SpeechToText speechToText = SpeechToText();
  // bool speechEnabled = false;
  // String wordsSpoken = '';
  // double confiLevel = 0;
  // bool isListening = false;

  @override
  void initState() {
    super.initState();
    initSpeech();
  }

  initSpeech() async {
    speechEnabled = await speechToText.initialize();
    setState(() {});
  }

  startListening() async {
    await speechToText.listen(onResult: onSpeechResult);
  }

  stopListening() async {
    await speechToText.stop();
  }

  onSpeechResult(result) {
    // if (speechToText.isNotListening) {
    setState(() {
      wordsSpoken = "${result.recognizedWords}";
      confiLevel = result.confidence;
    });
    // }
  }

  submit() {
    // code gemini here
    print(wordsSpoken);
    print(confiLevel);
    setState(() {
      wordsSpoken = '';
      confiLevel = 0;
    });
  }

  String getImagePath() {
    if (!speechToText.isListening && wordsSpoken == '') {
      return 'assets/images/default.jpg';
    }
    if (speechToText.isListening) {
      return 'assets/images/listening.jpg';
    }
    if (!speechToText.isListening && wordsSpoken != '' && confiLevel > 70) {
      return 'assets/images/lowConfi.jpg';
    }
    if (!speechToText.isListening && wordsSpoken != '' && confiLevel < 70) {
      return 'assets/images/highConfi.jpg';
    } else {
      return 'assets/images/default.jpg';
    }
  }

  String getComment() {
    if (!speechToText.isListening && wordsSpoken == '') {
      return 'Press the button and I will listen to your discussion';
    }
    if (speechToText.isListening) {
      return 'I\'m listening...';
    }
    if (!speechToText.isListening && wordsSpoken != '' && confiLevel > 70) {
      return 'I\'m only ${(confiLevel * 100).toStringAsFixed(0)}% that I understand what you said, but I\'m trying';
    }
    if (!speechToText.isListening && wordsSpoken != '' && confiLevel < 70) {
      return 'Your words are wording, shsashdhdad';
    } else {
      return 'Press the button and I will listen to your discussion';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('RECORD',
            style: GoogleFonts.dmSans(
              fontWeight: FontWeight.bold,
              color: Color(0xFF455A64),
              fontSize: 16.0,
            )),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 50.0),
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  getImagePath(),
                  height: 300,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                      text: 'Sana: ',
                      style: GoogleFonts.dmSans(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF455A64),
                        fontSize: 14.0,
                      ),
                      children: [
                        TextSpan(
                            text: getComment(),
                            style: GoogleFonts.dmSans(
                              fontWeight: FontWeight.normal,
                              color: Color(0xFF455A64),
                              fontSize: 14.0,
                            ))
                      ])),
              SizedBox(height: 60.0),
              IconButton(
                icon: CircleAvatar(
                  radius: 30, // Adjust the radius to make it circular
                  backgroundColor:
                      speechToText.isListening ? Color(0xFF1E88E5) : Colors.red,
                  child: Icon(
                    speechToText.isListening
                        ? Icons.mic_rounded
                        : Icons.mic_off_rounded,
                    color: Colors.white,
                    size: 30, // Adjust the size of the icon
                  ),
                ),
                iconSize: 60, // Adjust the size of the IconButton
                onPressed:
                    speechToText.isListening ? stopListening : startListening,
              ),
              SizedBox(height: 20.0),
              Visibility(
                visible: speechToText.isListening || wordsSpoken == ''
                    ? false
                    : true,
                child: MaterialButton(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  onPressed: submit,
                  color: Color(0xFF1E88E5),
                  child: Text('Submit',
                      style: GoogleFonts.dmSans(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 16.0,
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
