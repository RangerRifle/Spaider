import 'dart:async';
import 'package:finance_tracker/main.dart';
import 'package:finance_tracker/ticker.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import 'polygonservice.dart';
import 'package:finance_tracker/database1.dart';

class StockScreen extends StatefulWidget {
  const StockScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _StockScreenState createState() => _StockScreenState();
}

class _StockScreenState extends State<StockScreen> {
  final PolygonService _polygonService = PolygonService();
  final Map<String, List<FlSpot>> _stockChartData = {};
  final Map<String, List<String>> _dateLabels = {};
  String? _errorMessage;
  final TextEditingController _tickerChoiceController = TextEditingController();

  final DatabaseHelper dbHelper = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    _fetchStockData('AMZN');
    _fetchStockData('TSLA');
    _fetchStockData('NVDA');
  }

  /// Fetch stock data for a given ticker
  Future<void> _fetchStockData(String ticker) async {
    setState(() {
      _errorMessage = null; // Reset error message
    });

    try {
      final data = await _polygonService.fetchStockData(ticker);
      if (data.isEmpty) {
        throw Exception("No data available for $ticker");
      }
      setState(() {
        _stockChartData[ticker] = _convertToChartData(data, ticker);
        _dateLabels[ticker] = _extractDateLabels(data);
      });
    } catch (e) {
      setState(() {
        _errorMessage = "Failed to load stock information for $ticker: ${e.toString()} try refreshing the page";
      });
    }
  }


  /// Convert stock data to chart points
  List<FlSpot> _convertToChartData(List<dynamic> data, String ticker) {
    return data.asMap().entries.map((entry) {
      int index = entry.key;
      var stockPoint = entry.value;
      double price = stockPoint['c']?.toDouble() ?? 0.0; // Closing price
      return FlSpot(index.toDouble(), price); // Use index for x-axis
    }).toList();
  }

  /// Extract date labels for x-axis
  List<String> _extractDateLabels(List<dynamic> data) {
    return data.map((entry) {
      return DateFormat('MM/dd').format(
          DateTime.fromMillisecondsSinceEpoch(entry['t']));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
              'Stock Data Chart',
            style: TextStyle(color: Colors.white),
          ),
        backgroundColor: UI_APPBAR,
      ),
      backgroundColor: UI_BLACK,
      body: Center(
        child: _errorMessage != null
            ? Text('Error: $_errorMessage', style: const TextStyle(color: Colors.red))
            : _stockChartData.isEmpty
            ? const CircularProgressIndicator()
            : Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _tickerChoiceController,
                keyboardType: TextInputType.text,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                    labelText: 'Enter Ticker ID: ',
                    labelStyle: TextStyle(color: Colors.white),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                String tickerText = _tickerChoiceController.text;
                Ticker ticker = Ticker(ticker: tickerText);
                await dbHelper.insertTicker(ticker);
                await _fetchStockData(tickerText);
              },
              child: const Text("Add Ticker"),
            ),
            Expanded(
              child: ListView(
                children: _stockChartData.entries.map((entry) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          '${entry.key} Stock Prices',
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                      SizedBox(
                        height: 300,
                        child: LineChart(
                          _buildLineChart(entry.value, _dateLabels[entry.key]!),
                        ),
                      ),
                      const Divider(),
                    ],
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Generate the LineChart UI
  LineChartData _buildLineChart(List<FlSpot> spots, List<String> dateLabels) {
    return LineChartData(
      titlesData: FlTitlesData(
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 40,
            getTitlesWidget: (value, meta) {
              return Text('\$${value.toStringAsFixed(2)}', style: const TextStyle(fontSize: 12));
            },
          ),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
            reservedSize: 22,
            interval: (dateLabels.length / 5).ceilToDouble(), // Show only 5 labels
            getTitlesWidget: (value, meta) {
              int index = value.toInt();
              if (index >= 0 && index < dateLabels.length) {
                return Text(dateLabels[index], style: const TextStyle(fontSize: 10));
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
      gridData: const FlGridData(show: true, drawHorizontalLine: true, horizontalInterval: 10),
      borderData: FlBorderData(show: true),
      lineBarsData: [
        LineChartBarData(
          spots: spots,
          isCurved: true,
          color: Colors.blue,
          barWidth: 3,
          belowBarData: BarAreaData(show: false),
          dotData: const FlDotData(show: false),
        ),
      ],
    );
  }
}
