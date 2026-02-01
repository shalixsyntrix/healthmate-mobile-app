import '../../../core/utils/date_formatter.dart';

/// Health Record Model
/// Represents a single health record entry with daily health metrics
class HealthRecord {
  final int? id;
  final DateTime date;
  final int steps;
  final int calories;
  final int water; // in milliliters

  HealthRecord({
    this.id,
    required this.date,
    required this.steps,
    required this.calories,
    required this.water,
  });

  /// Create HealthRecord from database map
  factory HealthRecord.fromMap(Map<String, dynamic> map) {
    return HealthRecord(
      id: map['id'] as int?,
      date: DateFormatter.parseFromDatabase(map['date'] as String),
      steps: map['steps'] as int,
      calories: map['calories'] as int,
      water: map['water'] as int,
    );
  }

  /// Convert HealthRecord to database map
  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'date': DateFormatter.formatForDatabase(date),
      'steps': steps,
      'calories': calories,
      'water': water,
    };
  }

  /// Create a copy of this record with optional field updates
  HealthRecord copyWith({
    int? id,
    DateTime? date,
    int? steps,
    int? calories,
    int? water,
  }) {
    return HealthRecord(
      id: id ?? this.id,
      date: date ?? this.date,
      steps: steps ?? this.steps,
      calories: calories ?? this.calories,
      water: water ?? this.water,
    );
  }

  /// Validate health record values
  String? validate() {
    if (steps < 0) return 'Steps cannot be negative';
    if (steps > 100000) return 'Steps value seems unrealistic (max 100,000)';

    if (calories < 0) return 'Calories cannot be negative';
    if (calories > 10000) {
      return 'Calories value seems unrealistic (max 10,000)';
    }

    if (water < 0) return 'Water intake cannot be negative';
    if (water > 20000) return 'Water intake seems unrealistic (max 20,000 ml)';

    return null; // No errors
  }

  @override
  String toString() {
    return 'HealthRecord(id: $id, date: ${DateFormatter.formatForDisplay(date)}, '
        'steps: $steps, calories: $calories, water: $water ml)';
  }
}
