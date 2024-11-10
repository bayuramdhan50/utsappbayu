import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(UtsAppBayu());
}

class UtsAppBayu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Math Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashScreen(),
    );
  }
}
