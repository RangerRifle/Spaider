import 'package:flutter/material.dart';
import 'package:finance_tracker/main.dart';

class TaxCalculatorApp extends StatelessWidget {
  const TaxCalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
            'Tax Services',
          style: TextStyle(color: Colors.blue),
        ),
        backgroundColor: UI_APPBAR,
      ),
      backgroundColor: UI_BLACK,
      body: const TaxCalculatorScreen(),
    );
  }
}

class TaxCalculatorScreen extends StatefulWidget {
  const TaxCalculatorScreen({super.key});

  @override
  _TaxCalculatorScreenState createState() => _TaxCalculatorScreenState();
}

class _TaxCalculatorScreenState extends State<TaxCalculatorScreen> {
  final TextEditingController _incomeController = TextEditingController();
  final TextEditingController _deductionsController = TextEditingController();
  final TextEditingController _studentLoanController = TextEditingController();
  final TextEditingController _mortgageController = TextEditingController();
  final TextEditingController _medicalController = TextEditingController();
  final TextEditingController _otherDeductionsController = TextEditingController();

  double _taxOwed = 0.0;
  double _totalDeductions = 0.0;

  void _calculateDeductions() {
    double studentLoan = double.tryParse(_studentLoanController.text) ?? 0.0;
    double mortgage = double.tryParse(_mortgageController.text) ?? 0.0;
    double medical = double.tryParse(_medicalController.text) ?? 0.0;
    double other = double.tryParse(_otherDeductionsController.text) ?? 0.0;

    setState(() {
      _totalDeductions = studentLoan + mortgage + medical + other;
    });
  }

  void _calculateTax() {
    double income = double.tryParse(_incomeController.text) ?? 0.0;
    double deductions = double.tryParse(_deductionsController.text) ?? 0.0;
    double taxableIncome = (income - deductions).clamp(0, double.infinity);

    setState(() {
      _taxOwed = _computeTax(taxableIncome);
    });
  }

  double _computeTax(double taxableIncome) {
    if (taxableIncome <= 10275) {
      return taxableIncome * 0.10;
    } else if (taxableIncome <= 41775) {
      return 1027.5 + (taxableIncome - 10275) * 0.12;
    } else if (taxableIncome <= 89075) {
      return 4807.5 + (taxableIncome - 41775) * 0.22;
    } else if (taxableIncome <= 170050) {
      return 15213.5 + (taxableIncome - 89075) * 0.24;
    } else {
      return 34647.5 + (taxableIncome - 170050) * 0.32; // Higher brackets omitted
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UI_BLACK,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _incomeController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                  labelText: 'Enter Income',
                  labelStyle: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _studentLoanController,
              keyboardType: TextInputType.number,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                  labelText: 'Enter Student Loan Deductions',
                  labelStyle: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _medicalController,
              keyboardType: TextInputType.number,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                  labelText: 'Enter Medical Deductions',
                  labelStyle: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _mortgageController,
              keyboardType: TextInputType.number,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                  labelText: 'Enter Mortgage Deductions',
                  labelStyle: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _otherDeductionsController,
              keyboardType: TextInputType.number,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                  labelText: 'Enter Remaining Deductions',
                  labelStyle: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _calculateTax,
              child: const Text('Calculate Tax'),
            ),
            const SizedBox(height: 20),
            Text(
              'Total Deductions: \$${_taxOwed.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}