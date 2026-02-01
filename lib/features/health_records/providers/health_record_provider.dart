import 'package:flutter/foundation.dart';
import '../../../core/database/database_helper.dart';
import '../models/health_record.dart';

/// Provider for managing health records state
/// Handles CRUD operations and communicates with database
class HealthRecordProvider extends ChangeNotifier {
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  List<HealthRecord> _records = [];
  List<HealthRecord> _filteredRecords = [];
  bool _isLoading = false;
  String? _error;

  List<HealthRecord> get records =>
      _filteredRecords.isEmpty ? _records : _filteredRecords;
  bool get isLoading => _isLoading;
  String? get error => _error;

  /// Load all health records from database
  Future<void> loadRecords() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final data = await _dbHelper.getAllRecords();
      _records = data.map((map) => HealthRecord.fromMap(map)).toList();
      _filteredRecords = [];
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = 'Failed to load records: $e';
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Add a new health record
  Future<bool> addRecord(HealthRecord record) async {
    // Validate the record
    final validationError = record.validate();
    if (validationError != null) {
      _error = validationError;
      notifyListeners();
      return false;
    }

    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final id = await _dbHelper.insertRecord(record.toMap());
      final newRecord = record.copyWith(id: id);
      _records.insert(0, newRecord);
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _error = 'Failed to add record: $e';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  /// Update an existing health record
  Future<bool> updateRecord(HealthRecord record) async {
    if (record.id == null) {
      _error = 'Cannot update record without ID';
      notifyListeners();
      return false;
    }

    // Validate the record
    final validationError = record.validate();
    if (validationError != null) {
      _error = validationError;
      notifyListeners();
      return false;
    }

    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await _dbHelper.updateRecord(record.id!, record.toMap());
      final index = _records.indexWhere((r) => r.id == record.id);
      if (index != -1) {
        _records[index] = record;
      }
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _error = 'Failed to update record: $e';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  /// Delete a health record
  Future<bool> deleteRecord(int id) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await _dbHelper.deleteRecord(id);
      _records.removeWhere((r) => r.id == id);
      _filteredRecords.removeWhere((r) => r.id == id);
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _error = 'Failed to delete record: $e';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  /// Filter records by date
  void filterByDate(DateTime date) {
    _filteredRecords = _records.where((record) {
      return record.date.year == date.year &&
          record.date.month == date.month &&
          record.date.day == date.day;
    }).toList();
    notifyListeners();
  }

  /// Clear filter and show all records
  void clearFilter() {
    _filteredRecords = [];
    notifyListeners();
  }

  /// Search records by date string
  void searchByDate(String query) {
    if (query.isEmpty) {
      clearFilter();
      return;
    }

    _filteredRecords = _records.where((record) {
      final dateStr = record.date.toString();
      return dateStr.contains(query);
    }).toList();
    notifyListeners();
  }

  /// Clear any error messages
  void clearError() {
    _error = null;
    notifyListeners();
  }
}
