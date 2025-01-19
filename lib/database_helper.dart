import 'dart:math'; // For generating random statuses
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart'; // For writable directory

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
    final directory = await getApplicationDocumentsDirectory();
    final path = join(directory.path, 'lodge_data.db');

    return await openDatabase(
      path,
      version: 2,
      onOpen: (db) {
        print("Database opened successfully: $path");
      },
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

    // Validate image_path
    if (data['image_path'] == null || data['image_path'].toString().isEmpty) {
      print("Error: Invalid image_path: ${data['image_path']}");
      throw Exception("image_path is missing or invalid. Data not inserted.");
    }

    // Validate other required fields
    data['status'] = data['status'] ?? _generateRandomStatus(); // Default status
    data['location'] = data['location'] ?? 'Unknown';          // Default location
    data['floor'] = data['floor'] ?? 'Unknown';                // Default floor
    data['room'] = data['room'] ?? 'Unknown';                  // Default room
    data['note'] = data['note'] ?? '';                         // Default note

    // Log the validated data for debugging
    print("Validated data for insertion: $data");

    // Insert into the database
    await db.insert('lodge_data', data, conflictAlgorithm: ConflictAlgorithm.replace);
    print("Data inserted successfully.");
  }

  // Fetch all data from the lodge_data table
  Future<List<Map<String, dynamic>>> getAllLodgeData() async {
    final db = await database;
    final data = await db.query('lodge_data', orderBy: 'date DESC');

    // Filter out entries with invalid image paths
    final validData = data.where((entry) {
      final imagePath = entry['image_path']?.toString() ?? '';
      if (imagePath.isEmpty || !imagePath.startsWith('/data/')) {
        print("Invalid image path found: $imagePath");
        return false; // Exclude invalid entries
      }
      return true;
    }).toList();

    print("Fetched valid data: $validData");
    return validData;
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

    // Validate updated fields
    if (updatedData['image_path'] == null || updatedData['image_path'].toString().isEmpty) {
      print("Error: Invalid image_path in update: ${updatedData['image_path']}");
      throw Exception("image_path is missing or invalid.");
    }
    updatedData['status'] = updatedData['status'] ?? _generateRandomStatus();
    updatedData['location'] = updatedData['location'] ?? 'Unknown';
    updatedData['floor'] = updatedData['floor'] ?? 'Unknown';
    updatedData['room'] = updatedData['room'] ?? 'Unknown';
    updatedData['note'] = updatedData['note'] ?? '';

    await db.update(
      'lodge_data',
      updatedData,
      where: 'id = ?',
      whereArgs: [id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print("Data updated successfully for ID: $id");
  }

  // Delete data from the lodge_data table
  Future<void> deleteLodgeData(int id) async {
    final db = await database;
    await db.delete(
      'lodge_data',
      where: 'id = ?',
      whereArgs: [id],
    );
    print("Data deleted successfully for ID: $id");
  }

  // Delete all data from the table
  Future<void> deleteAllLodgeData() async {
    final db = await database;
    await db.delete('lodge_data');
    print("All data deleted successfully.");
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
