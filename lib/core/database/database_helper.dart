import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../utils/date_formatter.dart';

/// Database helper class using Singleton pattern
/// Handles SQLite database operations for health records
class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  /// Get database instance, create if doesn't exist
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('healthmate.db');
    return _database!;
  }

  /// Initialize database
  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  /// Create database tables
  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE health_records (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        date TEXT NOT NULL,
        steps INTEGER NOT NULL,
        calories INTEGER NOT NULL,
        water INTEGER NOT NULL
      )
    ''');

    // Insert dummy data for testing
    await _insertDummyData(db);
  }

  /// Insert dummy data for initial testing
  Future<void> _insertDummyData(Database db) async {
    final today = DateFormatter.getToday();

    final dummyRecords = [
      {
        'date': DateFormatter.formatForDatabase(today),
        'steps': 5000,
        'calories': 250,
        'water': 1500,
      },
      {
        'date': DateFormatter.formatForDatabase(
          today.subtract(const Duration(days: 1)),
        ),
        'steps': 8000,
        'calories': 400,
        'water': 2000,
      },
      {
        'date': DateFormatter.formatForDatabase(
          today.subtract(const Duration(days: 2)),
        ),
        'steps': 6500,
        'calories': 325,
        'water': 1800,
      },
      {
        'date': DateFormatter.formatForDatabase(
          today.subtract(const Duration(days: 3)),
        ),
        'steps': 7200,
        'calories': 360,
        'water': 2200,
      },
      {
        'date': DateFormatter.formatForDatabase(
          today.subtract(const Duration(days: 4)),
        ),
        'steps': 4500,
        'calories': 225,
        'water': 1200,
      },
    ];

    for (var record in dummyRecords) {
      await db.insert('health_records', record);
    }
  }

  /// CREATE - Insert a new health record
  Future<int> insertRecord(Map<String, dynamic> record) async {
    final db = await database;
    return await db.insert('health_records', record);
  }

  /// READ - Get all health records
  Future<List<Map<String, dynamic>>> getAllRecords() async {
    final db = await database;
    return await db.query('health_records', orderBy: 'date DESC');
  }

  /// READ - Get records by date
  Future<List<Map<String, dynamic>>> getRecordsByDate(String date) async {
    final db = await database;
    return await db.query(
      'health_records',
      where: 'date = ?',
      whereArgs: [date],
    );
  }

  /// READ - Get a single record by ID
  Future<Map<String, dynamic>?> getRecordById(int id) async {
    final db = await database;
    final results = await db.query(
      'health_records',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    }
    return null;
  }

  /// UPDATE - Update an existing health record
  Future<int> updateRecord(int id, Map<String, dynamic> record) async {
    final db = await database;
    return await db.update(
      'health_records',
      record,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  /// DELETE - Delete a health record
  Future<int> deleteRecord(int id) async {
    final db = await database;
    return await db.delete('health_records', where: 'id = ?', whereArgs: [id]);
  }

  /// Get records for today
  Future<List<Map<String, dynamic>>> getTodayRecords() async {
    final today = DateFormatter.formatForDatabase(DateFormatter.getToday());
    return await getRecordsByDate(today);
  }

  /// Search records by date range
  Future<List<Map<String, dynamic>>> searchRecordsByDateRange(
    String startDate,
    String endDate,
  ) async {
    final db = await database;
    return await db.query(
      'health_records',
      where: 'date BETWEEN ? AND ?',
      whereArgs: [startDate, endDate],
      orderBy: 'date DESC',
    );
  }

  /// Close database
  Future<void> close() async {
    final db = await database;
    await db.close();
  }
}
