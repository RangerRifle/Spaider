import 'package:finance_tracker/studentDebtSimple.dart';
import 'package:flutter/material.dart';
import 'main.dart';
import '401k.dart';
import 'rothIRA.dart';
import 'loanRepayment.dart';


class CalculatorSelector extends StatelessWidget {
  const CalculatorSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
            'Financial Calculators',
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
              title: const Text('Roth IRA Calculator', style: TextStyle(color: Colors.white)),
              onTap: () {
                // Navigate to Roth IRA Calculator
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RothIRACalculator()),
                );
              },
            ),
            const Divider(color: Colors.white),
            ListTile(
              title: const Text('401k Calculator', style: TextStyle(color: Colors.white)),
              onTap: () {
                // Navigate to Loan Calculator
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CalculatorModel401k()),
                );
              },
            ),
            const Divider(color: Colors.white),
            ListTile(
              title: const Text('Student Debt Calculator', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const StudentDebtModel()),
                );
              },
            ),
            const Divider(color: Colors.white),
            ListTile(
              title: const Text('Loan Repayment Calculator', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoanRepaymentModel()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

