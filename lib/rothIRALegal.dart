import 'main.dart';
import 'package:flutter/material.dart';

class RothIRALegalConsulting extends StatelessWidget {
  const RothIRALegalConsulting({super.key});

  @override
  Widget build(BuildContext context) {
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                  'Roth IRA Legal Consulting Page',
              style: TextStyle(color: Colors.white),
              ),
              backgroundColor: UI_APPBAR,
            ),
            backgroundColor: UI_BLACK,
            body: const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                '''Investments made with a Roth IRA should be frequently consulted with a legal financial consultant/advisor.
Be sure to familiarize yourself with terminology and jargon that is often associated with this practice.''',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
          ),
        ),
      ),
    );
  }
}