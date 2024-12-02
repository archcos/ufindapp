import 'package:flutter/material.dart';
import 'package:ufindapp/display/signin-page.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            children: [
              SlidePage(image: 'assets/images/ss1.png'),
              SlidePage(image: 'assets/images/ss2.png'),
              SlidePage(
                image: 'assets/images/ss3.png',
                isLast: true,
                onFinish: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => SigninPage()),
                  );
                },
              ),
            ],
          ),
          Positioned(
            top: 40,
            right: 20,
            child: TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => SigninPage()),
                );
              },
              child: Text(
                'Skip',
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SlidePage extends StatelessWidget {
  final String image;
  final bool isLast;
  final VoidCallback? onFinish;

  const SlidePage({
    Key? key,
    required this.image,
    this.isLast = false,
    this.onFinish,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          image,
          fit: BoxFit.cover,
        ),
        if (isLast)
          Positioned(
            bottom: 0,
            left: 150,
            child: Center(
              child: ElevatedButton(
                onPressed: onFinish,
                child: Text('Get Started'),
              ),
            ),
          ),
      ],
    );
  }
}
