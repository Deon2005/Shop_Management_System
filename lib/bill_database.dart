import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:path/path.dart';
import 'dart:convert';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._();
  static Database? _database;

  DatabaseHelper._();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    // Important: Initialize ffi and set databaseFactory
    sqfliteFfiInit(); // Only needed once, but safe here
    databaseFactory = databaseFactoryFfi;

    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'bills.db');
    return openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute(''' 
      CREATE TABLE bills(
        id TEXT PRIMARY KEY,
        customerName TEXT,
        phoneNumber TEXT,
        items TEXT,
        discount REAL,
        totalAmount REAL,
        billDate TEXT,
        billTime TEXT
      )
    ''');
  }

  // Function to insert a bill into the database
  Future<void> insertBill(Map<String, dynamic> bill) async {
    final db = await instance.database;

    // Convert the 'items' list to a JSON string before saving
    bill['items'] = jsonEncode(bill['items']);

    // Insert the bill into the 'bills' table
    await db.insert(
      'bills',
      bill,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Function to fetch all bills from the database
  Future<List<Map<String, dynamic>>> fetchBills() async {
    final db = await instance.database;
    final result = await db.query('bills');

    // Create a new modifiable list
    List<Map<String, dynamic>> decodedResult = [];

    for (var bill in result) {
      // Create a copy of the bill map
      final modifiableBill = Map<String, dynamic>.from(bill);

      if (modifiableBill['items'] is String) {
        try {
          final decoded = jsonDecode(modifiableBill['items'] as String);
          if (decoded is List) {
            modifiableBill['items'] = decoded.cast<Map<String, dynamic>>();
          } else {
            modifiableBill['items'] = [];
          }
        } catch (e) {
          modifiableBill['items'] = [];
        }
      }

      decodedResult.add(modifiableBill);
    }

    return decodedResult;
  }

  // Function to delete a bill from the database by ID
  Future<void> deleteBill(String id) async {
    final db = await instance.database;
    await db.delete('bills', where: 'id = ?', whereArgs: [id]);
  }
}
