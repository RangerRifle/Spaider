import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'main.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UI_BLACK,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const AnimatedDefaultTextStyle(
              style: TextStyle(
                  fontSize: 40.0,
                  fontFamily: 'Horizon',
                  color: Colors.white,
                ),
                duration: Duration(milliseconds: 200),
              child: Text('Welcome to'),
            ),
            const AnimatedDefaultTextStyle(
              style: TextStyle(
                fontSize: 40.0,
                fontFamily: 'Horizon',
                color: Colors.blue,
              ),
              duration: Duration(milliseconds: 200),
              child: Text('SPAIDER'),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const MyHomePage(title: 'Spaider')),
                );
              },
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
