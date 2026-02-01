import 'package:intl/intl.dart';

/// Utility class for date formatting and manipulation
class DateFormatter {
  /// Format date as 'yyyy-MM-dd' for database storage
  static String formatForDatabase(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }

  /// Format date as 'MMM dd, yyyy' for display (e.g., "Jan 15, 2024")
  static String formatForDisplay(DateTime date) {
    return DateFormat('MMM dd, yyyy').format(date);
  }

  /// Format date as 'EEEE, MMM dd' for display (e.g., "Monday, Jan 15")
  static String formatWithDay(DateTime date) {
    return DateFormat('EEEE, MMM dd').format(date);
  }

  /// Parse date string from database format 'yyyy-MM-dd'
  static DateTime parseFromDatabase(String dateStr) {
    return DateFormat('yyyy-MM-dd').parse(dateStr);
  }

  /// Check if a date is today
  static bool isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  /// Get today's date with time set to midnight
  static DateTime getToday() {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day);
  }
}
