import 'package:flutter/material.dart';
import 'main.dart';
import 'rothIRALegal.dart';
import '401kLegal.dart';

class LegalSelector extends StatelessWidget {
  const LegalSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Legal',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: UI_APPBAR,
      ),
      backgroundColor: UI_BLACK,
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: const Text(
                  'Roth IRA Legal',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  // Navigate to Roth IRA Legal page
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const RothIRALegalConsulting()), // Replace once page is created
                  );
                },
              ),
              const Divider(color: Colors.white),
              ListTile(
                title: const Text(
                  '401(k) Legal',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LegalInvestmentConsulting()),
                  );
                },
              ),
            ],
          ),
      ),
    );
  }
}