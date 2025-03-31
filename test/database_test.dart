import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
/*
void main() {
  late DatabaseHelper databaseHelper;
  databaseHelper = DatabaseHelper._privateConstructor();
  // Set up a test database for each test case
  setUp(() async {



    // Use a temporary directory for testing the database
    Directory tempDir = await getTemporaryDirectory();
    String path = join(tempDir.path, 'test_database.db');

    // Initialize database
    databaseHelper._database = await openDatabase(
      path,
      version: 1,
      onCreate: databaseHelper._onCreate,
    );
  });

  // Close the database after each test
  tearDown(() async {
    if (databaseHelper._database != null) {
      await databaseHelper._database?.close();
      databaseHelper._database = null;
    }
  });

  test('Insert value into database', () async {
    // Insert a value and check if it was inserted
    double value = 100.5;
    int id = await databaseHelper.insert(value);

    expect(id, isNonZero); // Expecting the id to be non-zero (valid)

    // Verify that the inserted value is present
    List<Map<String, dynamic>> rows = await databaseHelper.queryAllRows();
    expect(rows.isNotEmpty, true);
    expect(rows[0]['value'], value);
  });

  test('Retrieve values from database', () async {
    // Insert a value first
    double value = 200.0;
    await databaseHelper.insert(value);

    // Query all rows and check if the value is retrieved
    List<Map<String, dynamic>> rows = await databaseHelper.queryAllRows();
    expect(rows.isNotEmpty, true);
    expect(rows[0]['value'], value);
  });

  test('Delete value from database', () async {
    // Insert a value
    double value = 300.0;
    int id = await databaseHelper.insert(value);

    // Delete the inserted value
    int rowsDeleted = await databaseHelper.delete(id);

    expect(rowsDeleted, 1); // One row should be deleted

    // Verify that the table is empty
    List<Map<String, dynamic>> rows = await databaseHelper.queryAllRows();
    expect(rows.isEmpty, true);
  });

  test('Query on empty database returns empty list', () async {
    // Query the table when it's empty
    List<Map<String, dynamic>> rows = await databaseHelper.queryAllRows();
    expect(rows.isEmpty, true); // Expecting an empty list
  });

  test('Inserting multiple values', () async {
    // Insert multiple values
    double value1 = 50.0;
    double value2 = 75.0;
    await databaseHelper.insert(value1);
    await databaseHelper.insert(value2);

    // Query all rows
    List<Map<String, dynamic>> rows = await databaseHelper.queryAllRows();
    expect(rows.length, 2); // Expecting two rows

    // Check if the values match
    expect(rows[0]['value'], value1);
    expect(rows[1]['value'], value2);
  });
}
*/