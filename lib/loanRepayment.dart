import 'package:path/path.dart';

import 'main.dart';
import 'dart:math';
import 'package:flutter/material.dart';

class LoanRepayment extends StatelessWidget {
  const LoanRepayment({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Loan Repayment Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoanRepaymentModel(),
    );
  }
}

class LoanRepaymentModel extends StatefulWidget {
  const LoanRepaymentModel({super.key});

  @override
  LoanRepaymentScreen createState() => LoanRepaymentScreen();
}

class LoanRepaymentScreen extends State<LoanRepaymentModel> {
  double interestRate = 0.0;
  double loanBalance = 0.0;
  double monthlyPayment = 0.0;

  String repaymentTime = "";

  int years = 0;
  int months = 0;

  final TextEditingController loanBalanceController = TextEditingController();
  final TextEditingController monthlyPaymentController = TextEditingController();
  final TextEditingController interestRateController = TextEditingController();

  void calculateLoanRepayment() {
    if (interestRate == 0 || loanBalance == 0 || monthlyPayment == 0) {
      setState(() {
        repaymentTime = "Please enter valid values for all fields.";
      });
      return;
    }

    double r = interestRate / 100 / 12; // Convert annual rate to monthly decimal
    double P = loanBalance;
    double A = monthlyPayment;

    if (A <= P * r) {
      setState(() {
        repaymentTime = "Monthly payment is too low to repay the loan.";
      });
      return;
    }

    int n = (log(A / (A - P * r)) / log(1 + r)).ceil(); // Number of months

    if (n > 600) { // Limit to practical repayment period
      setState(() {
        repaymentTime = "The repayment period is too long to calculate reliably.";
      });
      return;
    }

    // Update global state variables
    setState(() {
      years = n ~/ 12;
      months = n % 12;
      //repaymentTime = "It will take approximately $years years and $months months to repay the loan.";
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Loan Repayment Calculator",
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
              controller: loanBalanceController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                labelText: 'Loan Balance',
                labelStyle: TextStyle(color: Colors.white),
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  loanBalance = double.tryParse(value) ?? 0.0;
                });
              },
            ),
            TextField(
              controller: monthlyPaymentController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                labelText: 'Monthly Payment',
                labelStyle: TextStyle(color: Colors.white),
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  monthlyPayment = double.tryParse(value) ?? 0.0;
                });
              },
            ),
            TextField(
              controller: interestRateController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                labelText: 'Interest Rate (Annual %)',
                labelStyle: TextStyle(color: Colors.white),
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  interestRate = double.tryParse(value) ?? 0.0;
                });
              },
            ),
            const SizedBox(height: 20),
            Text(
              repaymentTime,
              style: const TextStyle(color: Colors.white, fontSize: 18),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: calculateLoanRepayment,
              child: const Text("Calculate Repayment Time"),
            ),
            Text(
              'Estimated Loan Repayment Time: $years years and $months months',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
