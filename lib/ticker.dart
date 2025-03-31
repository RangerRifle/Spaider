class Ticker {
  final int? id;
  final String ticker;

  Ticker({this.id, required this.ticker});

  Map<String, dynamic> toMap() {
    return {'id': id, 'ticker': ticker};
  }

  factory Ticker.fromMap(Map<String, dynamic> map) {
    return Ticker(
      id: map['id'],
      ticker: map['ticker'],
    );
  }
}