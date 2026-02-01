import 'package:flutter/foundation.dart';
import '../../../core/database/database_helper.dart';
import '../../../core/utils/date_formatter.dart';
import '../models/health_summary.dart';
import '../../health_records/models/health_record.dart';

/// Provider for managing dashboard state
/// Calculates and provides summary of today's health activities
class DashboardProvider extends ChangeNotifier {
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  HealthSummary? _todaySummary;
  bool _isLoading = false;
  String? _error;

  HealthSummary? get todaySummary => _todaySummary;
  bool get isLoading => _isLoading;
  String? get error => _error;

  /// Load today's health summary
  Future<void> loadTodaySummary() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final today = DateFormatter.getToday();
      final todayRecords = await _dbHelper.getTodayRecords();

      if (todayRecords.isEmpty) {
        _todaySummary = HealthSummary(
          date: today,
          totalSteps: 0,
          totalCalories: 0,
          totalWater: 0,
        );
      } else {
        // Calculate totals from all records for today
        int totalSteps = 0;
        int totalCalories = 0;
        int totalWater = 0;

        for (var recordMap in todayRecords) {
          final record = HealthRecord.fromMap(recordMap);
          totalSteps += record.steps;
          totalCalories += record.calories;
          totalWater += record.water;
        }

        _todaySummary = HealthSummary(
          date: today,
          totalSteps: totalSteps,
          totalCalories: totalCalories,
          totalWater: totalWater,
        );
      }

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = 'Failed to load today\'s summary: $e';
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Refresh the dashboard data
  Future<void> refresh() async {
    await loadTodaySummary();
  }
}
