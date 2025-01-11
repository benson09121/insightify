import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:rcbg_real/firebase_options.dart';
import 'package:rcbg_real/pages/auth.dart';
import 'package:rcbg_real/pages/home.dart';
import 'package:rcbg_real/pages/login.dart';

void main() async {
  await dotenv.load(fileName: ".env");

  String apiKey = dotenv.env['GOOGLE_SERVICES_API_KEY'] ?? '';

  File googleServicesFile = File('android/app/google-services.json');
  String content = await googleServicesFile.readAsString();

  content = content.replaceAll('GOOGLE_SERVICES_API_KEY_PLACEHOLDER', apiKey);
  await googleServicesFile.writeAsString(content);

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ThemeData lightmode = ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.grey.shade100,
        colorScheme: ColorScheme.light(
            primary: Colors.grey.shade200,
            secondary: Colors.grey.shade400,
            tertiary: Colors.grey.shade500,
            inversePrimary: Colors.grey.shade800),
        textTheme: ThemeData.light().textTheme.apply(
            bodyColor: Colors.grey[800],
            displayColor: Colors.black,
            fontFamily: 'Montserrat'));

    ThemeData darkmode = ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.grey.shade700,
        colorScheme: ColorScheme.dark(
            primary: Colors.grey.shade800,
            secondary: Colors.grey.shade900,
            tertiary: Colors.grey.shade500,
            inversePrimary: Colors.grey.shade300),
        textTheme: ThemeData.dark().textTheme.apply(
            bodyColor: Colors.grey[300],
            displayColor: Colors.white,
            fontFamily: 'Montserrat'));

    return MaterialApp(
      title: 'Flutter Demo',
      theme: lightmode,
      darkTheme: darkmode,
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
      initialRoute: '/auth',
      routes: {
        '/auth': (context) => const Auth(),
        '/login': (context) => const Login(),
        '/home': (context) => const Home(),
      },
    );
  }
}
