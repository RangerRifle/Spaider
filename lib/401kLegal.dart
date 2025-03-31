import 'main.dart';
import 'package:flutter/material.dart';

class LegalInvestmentConsulting extends StatelessWidget {
  const LegalInvestmentConsulting({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '401(k) Legal Consulting Page',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: UI_APPBAR,
      ),
      backgroundColor: UI_BLACK,
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(
          '''Investments made with a 401(k) should be frequently consulted with by your employer and a legal financial consultant/advisor.
Be sure to familiarize yourself with the terminology and jargon that is often associated with this practice.''',
          style: TextStyle(
          color: Colors.white,
          fontSize: 16.0,
          ),
        ),
      ),
    );
  }
}