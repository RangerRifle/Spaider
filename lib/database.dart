import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

Future<Database> initializeDB() async {
  String path = join(await getDatabasesPath(), 'ticker.db');
  return openDatabase(
    path,
    onCreate: (database, version) async {
      await database.execute(
        "CREATE TABLE items(id INTEGER PRIMARY KEY AUTOINCREMENT, ticker TEXT UNIQUE)",
      );
    },
    version: 1,
  );
}

Future<void> insertItem(String ticker) async {
  final Database db = await initializeDB();
  await db.insert(
      'items',
      {'ticker': ticker},
    conflictAlgorithm: ConflictAlgorithm.replace
  );
}

Future<List<String>> retrieveItems() async {
  final Database db = await initializeDB();
  final List<Map<String, dynamic>> maps = await db.query('items');

  // Ensure 'ticker' is not null before converting to a list
  return maps
      .map((map) => map['ticker'])
      .where((ticker) => ticker != null) // Filter out null values
      .map((ticker) => ticker as String) // Safely cast to String
      .toList();
}

Future<void> deleteItem(int id) async {
  final Database db = await initializeDB();
  await db.delete(
    'items',
    where: "id = ? ",
    whereArgs: [id],
  );
}