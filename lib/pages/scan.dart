import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:camera/camera.dart';
import 'package:flutter/services.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

class Scan extends StatefulWidget {
  const Scan({super.key});

  @override
  State<Scan> createState() => _ScanState();
}

class _ScanState extends State<Scan> {
  bool _isFlashOn = false;
  late XFile? pickImage;
  late String resultText;
  CameraController? _cameraController;
  List<CameraDescription>? cameras;
  late TextRecognizer textRecognizer;

  @override
  void initState() {
    super.initState();
    pickImage = null;
    resultText = '';
    _initializeCamera();
    textRecognizer = TextRecognizer();
  }

  Future<void> _initializeCamera() async {
    cameras = await availableCameras();
    _cameraController = CameraController(cameras![0], ResolutionPreset.max);
    await _cameraController?.initialize();
    if (mounted) {
      setState(() {});
    }
    await _cameraController?.lockCaptureOrientation(DeviceOrientation.portraitUp);
  }

  Future<void> _captureImage() async {
    if (_cameraController != null && _cameraController!.value.isInitialized) {
      try {
        final image = await _cameraController!.takePicture();
        setState(() {
          pickImage = image;
        });
      } catch (e) {
        print(e.toString());
      }
    }
  }

  @override
  void dispose() {
    textRecognizer.close();
    _cameraController?.dispose();
    super.dispose();
  }

  void _toggleFlash() {
    setState(() {
      _isFlashOn = !_isFlashOn;
    });
    // Add your flash toggle functionality here
  }

  Future<void> getImage(ImageSource imgSource) async {
    try {
      pickImage = (await ImagePicker().pickImage(source: imgSource))!;
      if (pickImage != null) {
        final inputImage = InputImage.fromFilePath(pickImage!.path);
        final RecognizedText recognizedText = await textRecognizer.processImage(inputImage);
        setState(() {
          resultText = recognizedText.text;
        });
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
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          if (_cameraController != null && _cameraController!.value.isInitialized)
            Positioned(
              top: 80.0, // Adjust this value as needed
              left: 0,
              right: 0,
              bottom: 100.0, // Adjust this value as needed
              child: GestureDetector(
                onTap: _captureImage,
                child: Container(
                  child: // Ensure the camera is in portrait mode
                   Transform.rotate(
                    angle:  1 * 3.14 / 2,
                    child: Transform.scale(
                      scale: _cameraController!.value.aspectRatio /
                          MediaQuery.of(context).size.aspectRatio,
                      child: Center(
                        child: AspectRatio(
                          aspectRatio: _cameraController!.value.aspectRatio,
                          child: CameraPreview(_cameraController!),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
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
                    Navigator.pushNamed(
                      context,
                      '/home',
                      arguments: {'extractedText': resultText},
                    );
                  },
                  color: Colors.white,
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 50.0),
              child: InkWell(
                onTap: () {
                  getImage(ImageSource.camera);
                },
                child: Container(
                  height: 50.0,
                  width: 50.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Icon(
                    Icons.image,
                    color: Colors.blue,
                  ),
                ),
              ),
            ), 
          ),
        ],
      ),
    );
  }
}