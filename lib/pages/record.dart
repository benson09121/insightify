import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:rcbg_real/global.dart';
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
bool isClicked = false;

class _RecordPageState extends State<Record> {
  final GenerativeModel _model = GenerativeModel(
    model: 'gemini-1.5-flash-latest',
    apiKey: 'AIzaSyDa4JxMPc1b1eDQV2-TAnTznxa9LGKSZLI',
  );
  Future<void> generateStory(String prompt) async {
    final content = [Content.text(prompt)];
    final response = await _model.generateContent(content);
    print(response.text);
    setState(() {
      result = response.text!;
    });
  }

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
    setState(() {
      isClicked = true;
    });

    await speechToText.listen(
      onResult: onSpeechResult,
    );
  }

  stopListening() async {
    await speechToText.stop();
  }

  onSpeechResult(result) {
    setState(() {
      wordsSpoken = "${result.recognizedWords}";
      confiLevel = result.confidence;
    });
  }

  submit() async {
    // code gemini here
    // commpare wordspoken to summarized

    // String promt =
    //     "Compare the content of the text \"$summarized\" to the text \"$wordsSpoken\". Give a short comment and a rating from 0% - 100% about how close they are. Return a reponse in this json format, {'comment':'', 'rating':''}. The 'comment' and 'rating' must be a string";

    String prompt2 =
        "im studying by trying to discuss what i've learned from this text, '$summarized'. My discussion is \"$wordsSpoken\". Rate the content of my discussion from 0% - 100%, but give me a higher rating. return a single numerical value.";

    await generateStory(prompt2);

    // print(wordsSpoken);
    // print(confiLevel);
    setState(() {
      wordsSpoken = '';
      confiLevel = 0;
    });
    Navigator.pushNamed(context, '/assessment');
  }

  String getImagePath() {
    if (!speechToText.isListening && wordsSpoken == '') {
      return 'assets/images/default.png';
    }
    if (speechToText.isListening) {
      return 'assets/images/listening.png';
    }
    if (!speechToText.isListening && wordsSpoken != '' && confiLevel > 70) {
      return 'assets/images/lowConfi.png';
    }
    if (!speechToText.isListening && wordsSpoken != '' && confiLevel < 70) {
      return 'assets/images/highConfi.png';
    } else {
      return 'assets/images/default.png';
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
    if (isClicked) {
      // Timer.periodic(Duration(seconds: 1), (timer) {
      //   if (!mounted) {
      //     timer.cancel();
      //   } else {
      //     setState(() {
      //       isListening = speechToText.isListening;
      //     });
      //   }
      //   print('jdjjdd');
      // });
    }

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
                      text: 'Echo: ',
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
