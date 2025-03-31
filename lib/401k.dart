import 'package:flutter/material.dart';
import 'main.dart';

/// @class: calculator class
/// @brief: return investment projections

class Calculator401k extends StatelessWidget {
  const Calculator401k({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '401k Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CalculatorModel401k(),
    );
  }
}

class CalculatorModel401k extends StatefulWidget {
  const CalculatorModel401k({super.key});

  @override
  CalculatorScreen401k createState() => CalculatorScreen401k();
}

class CalculatorScreen401k extends State<CalculatorModel401k> {
  double initialBalance = 0.0;
  double annualContribution = 0.0;
  double employerMatch = 0.0;
  double annualReturnRate = 0.0;
  int years = 0;

  double finalBalance = 0.0;

  void calculate401k() {
    setState(() {
      double balance = initialBalance;
      double totalAnnualContribution = annualContribution + (annualContribution * (employerMatch / 100));

      for (int i = 0; i < years; ++i) {
        balance += totalAnnualContribution;
        balance += balance * (annualReturnRate / 100);
      }

      finalBalance = balance;
    });
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text(
            '401k Projection',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: UI_APPBAR,
      ),
      backgroundColor: UI_BLACK,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                  labelText: 'Initial Balance',
                  labelStyle: TextStyle(color: Colors.white),
              ),
              keyboardType: TextInputType.number,
              style: const TextStyle(color: Colors.white),
              onChanged: (value) => initialBalance = double.tryParse(value) ?? 0.0,
            ),
            TextField(
              decoration: const InputDecoration(
                  labelText: 'Annual Contribution',
                  labelStyle: TextStyle(color: Colors.white),
              ),
              keyboardType: TextInputType.number,
              style: const TextStyle(color: Colors.white),
              onChanged: (value) => annualContribution = double.tryParse(value) ?? 0.0,
            ),
            TextField(
              decoration: const InputDecoration(
                  labelText: 'Employer Match (%)',
                  labelStyle: TextStyle(color: Colors.white),
              ),
              keyboardType: TextInputType.number,
              style: const TextStyle(color: Colors.white),
              onChanged: (value) => employerMatch = double.tryParse(value) ?? 0.0,
            ),
            TextField(
              decoration: const InputDecoration(
                  labelText: 'Annual Return Rate (%)',
                  labelStyle: TextStyle(color: Colors.white),
              ),
              keyboardType: TextInputType.number,
              style: const TextStyle(color: Colors.white),
              onChanged: (value) => annualReturnRate = double.tryParse(value) ?? 0.0,
            ),
            TextField(
              decoration: const InputDecoration(
                  labelText: 'Number of Years',
                  labelStyle: TextStyle(color: Colors.white),
              ),
              keyboardType: TextInputType.number,
              style: const TextStyle(color: Colors.white),
              onChanged: (value) => years = int.tryParse(value) ?? 0,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: calculate401k,
              child: const Text('Calculate'),
            ),
            const SizedBox(height: 20),
            Text(
            'Estimated 401k Balance: \$${finalBalance.toStringAsFixed(2)}',
            style: const TextStyle(fontSize: 18, color: Colors.white),
          ),
          ],
        ),
      ),
    );
  }
}
