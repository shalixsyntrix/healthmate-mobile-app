import '../../../core/utils/date_formatter.dart';

/// Health Summary Model
/// Represents aggregated health data for a specific day
class HealthSummary {
  final DateTime date;
  final int totalSteps;
  final int totalCalories;
  final int totalWater;

  HealthSummary({
    required this.date,
    required this.totalSteps,
    required this.totalCalories,
    required this.totalWater,
  });

  /// Check if this is today's summary
  bool get isToday => DateFormatter.isToday(date);

  /// Get formatted date string
  String get formattedDate => DateFormatter.formatForDisplay(date);
}
