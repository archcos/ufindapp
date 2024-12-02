import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'display/landing-page.dart';
import 'display/signin-page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'U-Find',
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.green[600], // Use the green[600] color here
      ),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkFirstTime();
  }

  Future<void> checkFirstTime() async {
    final prefs = await SharedPreferences.getInstance();
    final isFirstTime = prefs.getBool('first_time') ?? true;

    if (isFirstTime) {
      await prefs.setBool('first_time', false);Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LandingPage()),);
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SigninPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Placeholder while the app determines the navigation logic
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
