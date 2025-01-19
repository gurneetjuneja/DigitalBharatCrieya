import 'dart:math'; // For generating random statuses
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart'; // Importing to get writable directory

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  // Getter for the database instance
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  // Initialize the database
  Future<Database> _initDatabase() async {
    final directory = await getApplicationDocumentsDirectory(); // Getting writable directory
    final path = join(directory.path, 'lodge_data.db'); // Using path to the writable directory

    return await openDatabase(
      path,
      version: 2, // Increment version for schema changes
      onCreate: (db, version) async {
        await db.execute(''' 
          CREATE TABLE lodge_data (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            image_path TEXT,
            date TEXT,
            time TEXT,
            location TEXT,
            floor TEXT,
            room TEXT,
            note TEXT,
            status TEXT,
            issue_type TEXT
          )
        ''');
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          await db.execute("ALTER TABLE lodge_data ADD COLUMN status TEXT;");
          await db.execute("ALTER TABLE lodge_data ADD COLUMN issue_type TEXT;");
        }
      },
    );
  }

  // Insert data into the lodge_data table
  Future<void> insertLodgeData(Map<String, dynamic> data) async {
    final db = await database;

    // Ensuring required fields are not empty or null
    data['status'] = data['status'] ?? _generateRandomStatus();
    data['location'] = data['location'] ?? '';
    data['floor'] = data['floor'] ?? '';
    data['room'] = data['room'] ?? '';
    data['note'] = data['note'] ?? '';

    await db.insert('lodge_data', data, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // Fetch all data from the lodge_data table
  Future<List<Map<String, dynamic>>> getAllLodgeData() async {
    final db = await database;
    return await db.query('lodge_data', orderBy: 'date DESC'); // Sorting by date
  }

  // Fetch specific data by ID
  Future<Map<String, dynamic>?> getLodgeDataById(int id) async {
    final db = await database;
    final result = await db.query(
      'lodge_data',
      where: 'id = ?',
      whereArgs: [id],
    );
    return result.isNotEmpty ? result.first : null;
  }

  // Update data in the lodge_data table
  Future<void> updateLodgeData(int id, Map<String, dynamic> updatedData) async {
    final db = await database;
    // Ensure all fields are updated correctly
    updatedData['status'] = updatedData['status'] ?? _generateRandomStatus();
    updatedData['location'] = updatedData['location'] ?? '';
    updatedData['floor'] = updatedData['floor'] ?? '';
    updatedData['room'] = updatedData['room'] ?? '';
    updatedData['note'] = updatedData['note'] ?? '';

    await db.update(
      'lodge_data',
      updatedData,
      where: 'id = ?',
      whereArgs: [id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Delete data from the lodge_data table
  Future<void> deleteLodgeData(int id) async {
    final db = await database;
    await db.delete(
      'lodge_data',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Delete all data from the table (use with caution)
  Future<void> deleteAllLodgeData() async {
    final db = await database;
    await db.delete('lodge_data');
  }

  // Fetch all distinct issue types for dropdown or filtering
  Future<List<String>> getAllDistinctIssueTypes() async {
    final db = await database;
    final result = await db.rawQuery('SELECT DISTINCT issue_type FROM lodge_data');
    return result.map((row) => row['issue_type'] as String).toList();
  }

  // Helper method to generate a random status if not provided
  String _generateRandomStatus() {
    final random = Random();
    return random.nextBool() ? "submitted" : "resolved";
  }
}