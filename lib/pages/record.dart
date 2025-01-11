import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Record extends StatefulWidget {
  @override
  _RecordPageState createState() => _RecordPageState();
}

class _RecordPageState extends State<Record> {
  bool isRecording = false;
  double progress = 0.0;
  final List<double> _waveformData = [];

  void _toggleRecording() {
    setState(() {
      isRecording = !isRecording;
      if (isRecording) {
        // Start recording and update progress
        progress = 0.5; // Example progress value
        // Add your recording logic here
      } else {
        // Stop recording
        progress = 0.0;
        // Add your stop recording logic here
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Record'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
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
          ),
          SizedBox(height: 20.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.grey[300],
              color: Color(0xFF1E88E5),
              minHeight: 10.0,
            ),
          ),
          SizedBox(height: 20.0),
          // Container(
          //   height: 100.0,
          //   width: double.infinity,
          //   child: AudioWaveforms(
          //     waveData: _waveformData,
          //     size: Size(double.infinity, 100.0),
          //     waveStyle: WaveStyle(
          //       waveColor: Color(0xFF1E88E5),
          //       extendWaveform: true,
          //       showMiddleLine: false,
          //     ),
          //   ),
          // ),
          SizedBox(height: 20.0),
          IconButton(
            icon: CircleAvatar(
              radius: 30, // Adjust the radius to make it circular
              backgroundColor: isRecording ? Colors.red : Color(0xFF1E88E5),
              child: Icon(
                isRecording ? Icons.stop : Icons.mic,
                color: Colors.white,
                size: 30, // Adjust the size of the icon
              ),
            ),
            iconSize: 60, // Adjust the size of the IconButton
            onPressed: _toggleRecording,
          ),
        ],
      ),
    );
  }
}