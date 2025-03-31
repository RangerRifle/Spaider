import 'package:finance_tracker/stocktracker.dart';
import 'package:finance_tracker/taxfiling.dart';
import 'package:flutter/material.dart';
import 'calculator.dart';
import 'loginScreen.dart';
import 'package:finance_tracker/legal.dart';
// ignore: depend_on_referenced_packages
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

// Define the custom MaterialColor
// ignore: constant_identifier_names
const MaterialColor UI_BLACK = MaterialColor(
  0xAA444444,
  <int, Color>{
    500: Color(0xAA444444),
  },
);

// ignore: constant_identifier_names
const MaterialColor UI_APPBAR = MaterialColor(
  0x88444444,
  <int, Color>{
    500: Color(0x88444444),
  },
);

void main() {
  // Initialize sqflite for FFI
  sqfliteFfiInit();

  // Set the database factory for FFI
  databaseFactory = databaseFactoryFfi;

  runApp(const MyApp());
}


// Welcome screen
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Spaider',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const LoginScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: UI_APPBAR,
        title: const Text(
          'Spaider',
          style: TextStyle(color: Colors.white),
        ),
      ),
      backgroundColor: UI_BLACK[500],
      body: Center(
          child: TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.blue,
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => Dialog(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
//                  mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Text('Menu'),
                          const SizedBox(height: 15),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LegalSelector()),
                              );
                            },
                            child: const Text('Legal'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const CalculatorSelector()),
                              );
                            },
                            child: const Text('Calculate'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const TaxCalculatorApp()),
                              );
                            },
                            child: const Text('Tax'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const StockScreen()),
                              );
                            },
                            child: const Text('Stock Tracker')
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('Cancel'),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              child: const Text('Menu')
          )
      ),
    );
  }
}