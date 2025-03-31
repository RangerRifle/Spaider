import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'ticker.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._instance();
  static Database? _database;
  DatabaseHelper();

  DatabaseHelper._instance();

  Future<Database> get db async {
    _database ??= await initDB();
    return _database!;
  }

  Future<Database> initDB() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'tickers.db');

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE tickers (
      id INTEGER PRIMARY KEY,
      tickerid TEXT
      )
    ''');
  }

  Future<int> insertTicker(Ticker ticker) async {
    Database db = await instance.db;
    return await db.insert('tickers', {
      'tickerid': ticker.ticker,
    });
  }


  Future<List<Map<String, dynamic>>> queryAllTickers() async {
    Database db = await instance.db;
    return await db.query('tickers');
  }

  Future<int> updateUser(Ticker ticker) async {
    Database db = await instance.db;
    return await db.update('tickers', ticker.toMap(), where: 'id = ?', whereArgs: [ticker.id]);
  }

  Future<int> deleteUser(int id) async {
    Database db = await instance.db;
    return await db.delete('tickers', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> initializeTickers() async {
    List<Ticker> tickersToAdd = [
      Ticker(ticker: 'AAPL'),
      Ticker(ticker: 'NDAQ'),
    ];

    for(Ticker ticker in tickersToAdd) {
      await insertTicker(ticker);
    }
  }
}

