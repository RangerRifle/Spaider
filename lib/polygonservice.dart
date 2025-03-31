import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class PolygonService {
  static const String _apiKey = '0dLqDOMRsDIcmWUB7kT_r2rzo4or6j_V';
  static const String _baseUrl = 'https://api.polygon.io/v2/aggs/ticker';

  final DateFormat _dateFormat = DateFormat('yyyy-MM-dd'); // Format dates
  final DateTime now = DateTime.now();
  final DateTime startOfYear = DateTime(DateTime.now().year, 1, 1);

  Future<List<dynamic>> fetchStockData(String ticker) async {
    String formattedStart = _dateFormat.format(startOfYear);
    String formattedNow = _dateFormat.format(now);

    final String url = '$_baseUrl/$ticker/range/1/day/$formattedStart/$formattedNow?adjusted=true&sort=asc&limit=5000&apiKey=$_apiKey';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        if (data.containsKey('results') && data['results'] != null) {
          return List.from(data['results']); // Explicitly return a List
        } else {
          throw Exception('No stock data available for $ticker.');
        }
      } else {
        throw Exception('Failed to load stock data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching stock data: $e');
    }
  }
}
