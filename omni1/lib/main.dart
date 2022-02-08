import 'package:flutter/material.dart';
import 'package:omni1/screens/output_screen.dart';
import 'package:omni1/screens/subject_screen.dart';
import './screens/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          textTheme: const TextTheme(
            headline1: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          )),
      home: const SplashScreen(),
      routes: {
        '/subject': (context) => SubjectScreen(),
        '/output': (context) => const ImageOutput(),
      },
    );
  }
}
