import 'package:flutter/material.dart';
import 'dart:async';
import '../utils/height_and_width.dart';
import 'home_screen.dart';

/// Splash screen that appears when the app starts.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  /// Initialize the splash screen and navigate to HomeScreen after 3 seconds.
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // Get device screen height & width for responsive design
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black, // Splash screen background color
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /// App logo or icon
            Icon(Icons.check_circle, color: Colors.white, size: 80),

            SizedBox(height: 20), // Spacing

            /// App name or splash message
            Text(
              "To-Do App",
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
