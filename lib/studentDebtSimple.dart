import 'package:flutter/material.dart';
import 'main.dart';

class StudentDebtCalculator extends StatelessWidget {
  const StudentDebtCalculator({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student Debt Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const StudentDebtModel(),
    );
  }
}

class StudentDebtModel extends StatefulWidget {
  const StudentDebtModel({super.key});

  @override
  StudentDebtScreen createState() => StudentDebtScreen();
}

class StudentDebtScreen extends State<StudentDebtModel> {

  final TextEditingController initialDebtController = TextEditingController();
  final TextEditingController annualContributionController = TextEditingController();
  final TextEditingController interestRateController = TextEditingController();

  double initialDebt = 0.0;
  double annualContribution = 0.0;
  int months = 0;
  double loanBalance = 0.0;
  double interestRate = 0.0;
  double remainingBalance = 0.0; // New variable to store calculated balance

  void calculateReliefSimple() {
    setState(() {
      // Reset values
      loanBalance = double.tryParse(initialDebtController.text) ?? 0.0;
      double annualInterestRate = double.tryParse(interestRateController.text) ?? 0.0;
      double monthlyInterestRate = (annualInterestRate / 100) / 12; // Convert annual % to monthly decimal
      double monthlyContribution = (double.tryParse(annualContributionController.text) ?? 0.0) / 12; // Convert annual to monthly

      months = 0; // Reset counter

      // Check if loan can ever be paid off
      if (monthlyContribution <= loanBalance * monthlyInterestRate) {
        months = -1; // Indicate impossible payoff
        remainingBalance = loanBalance;
        return;
      }

      // Loan repayment calculation loop
      while (loanBalance > 0) {
        loanBalance += loanBalance * monthlyInterestRate; // Apply interest
        loanBalance -= monthlyContribution; // Subtract monthly payment
        months++;

        if (loanBalance <= 0) {
          loanBalance = 0; // Prevent negative values
          break;
        }
      }

      remainingBalance = loanBalance; // Store final balance
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Student Debt Calculator',
          style: TextStyle(color: Colors.white  ),
        ),
        backgroundColor: UI_APPBAR,
      ),
      backgroundColor: UI_BLACK,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: initialDebtController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                  labelText: 'Initial Debt',
                  labelStyle: TextStyle(color: Colors.white),
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) => initialDebt = double.tryParse(value) ?? 0.0,
            ),
            TextField(
              controller: annualContributionController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                  labelText: 'Annual Contribution',
                  labelStyle: TextStyle(color: Colors.white),
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) => annualContribution = double.tryParse(value) ?? 0.0,
            ),
            TextField(
              controller: interestRateController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                  labelText: 'Interest Rate (Annual %)',
                  labelStyle: TextStyle(color: Colors.white),
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) => interestRate = double.tryParse(value) ?? 0.0,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: calculateReliefSimple,
              child: const Text('Calculate Debt Relief'),
            ),
            const SizedBox(height: 20),
            Text(
              'Loan Paid Off in: $months months',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
            Text(
              'Remaining Balance: \$${remainingBalance.toStringAsFixed(2)}',
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
