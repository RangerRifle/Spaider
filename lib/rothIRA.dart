import 'package:finance_tracker/main.dart';
import 'package:flutter/material.dart';

class RothIRACalculatorApp extends StatelessWidget {
  const RothIRACalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Roth IRA Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const RothIRACalculator(),
    );
  }
}

class RothIRACalculator extends StatefulWidget {
  const RothIRACalculator({super.key});

  @override
  _RothIRACalculatorState createState() => _RothIRACalculatorState();
}

class _RothIRACalculatorState extends State<RothIRACalculator> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _initialAmountController = TextEditingController();
  final TextEditingController _annualContributionController = TextEditingController();
  final TextEditingController _yearsController = TextEditingController();
  final TextEditingController _annualReturnController = TextEditingController();

  late double _futureValue = 0.0;

  void _calculateFutureValue() {
    if (_formKey.currentState!.validate()) {
      final double initialAmount = double.parse(_initialAmountController.text);
      final double annualContribution = double.parse(_annualContributionController.text);
      final int years = int.parse(_yearsController.text);
      final double annualReturn = double.parse(_annualReturnController.text) / 100;

      double futureValue = initialAmount;
      for (int i = 0; i < years; ++i) {
        futureValue += annualContribution;
        futureValue *= (1 + annualReturn);
      }

      setState(() {
        _futureValue = futureValue;
      });
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
            'Roth IRA Projection',
        style: TextStyle(color: Colors.white),
        ),
        backgroundColor: UI_APPBAR,
      ),
      backgroundColor: UI_BLACK,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _initialAmountController,
                keyboardType: TextInputType.number,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                    labelText: 'Initial Amount',
                    labelStyle: TextStyle(color: Colors.white),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an initial amount';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _annualContributionController,
                keyboardType: TextInputType.number,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                    labelText: 'Annual Contribution',
                    labelStyle: TextStyle(color: Colors.white),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an annual contribution';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _yearsController,
                keyboardType: TextInputType.number,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                    labelText: 'Years',
                    labelStyle: TextStyle(color: Colors.white),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the number of years';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _annualReturnController,
                keyboardType: TextInputType.number,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                    labelText: 'Annual Return (%)',
                    labelStyle: TextStyle(color: Colors.white),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the expected annual return';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _calculateFutureValue,
                child: const Text('Calculate'),
              ),
              const SizedBox(height: 20),
              Text(
                'Estimated Roth IRA Projection: \$${_futureValue.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 18, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}