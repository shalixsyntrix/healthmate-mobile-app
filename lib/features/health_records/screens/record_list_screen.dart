import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/date_formatter.dart';
import '../models/health_record.dart';
import '../providers/health_record_provider.dart';
import 'add_record_screen.dart';

class RecordListScreen extends StatefulWidget {
  static const routeName = '/record-list';

  const RecordListScreen({super.key});

  @override
  State<RecordListScreen> createState() => _RecordListScreenState();
}

class _RecordListScreenState extends State<RecordListScreen> {
  DateTime? _filterDate;
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Load records when screen is first displayed
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<HealthRecordProvider>(context, listen: false).loadRecords();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _selectDateFilter(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _filterDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        _filterDate = picked;
      });
      Provider.of<HealthRecordProvider>(
        context,
        listen: false,
      ).filterByDate(picked);
    }
  }

  void _clearFilter() {
    setState(() {
      _filterDate = null;
      _searchController.clear();
    });
    Provider.of<HealthRecordProvider>(context, listen: false).clearFilter();
  }

  void _editRecord(HealthRecord record) {
    Navigator.of(context)
        .push(
          MaterialPageRoute(
            builder: (context) => AddRecordScreen(recordToEdit: record),
          ),
        )
        .then((_) {
          // Reload records after returning from edit screen
          Provider.of<HealthRecordProvider>(
            context,
            listen: false,
          ).loadRecords();
        });
  }

  Future<void> _deleteRecord(HealthRecord record) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Record'),
        content: Text(
          'Are you sure you want to delete the record from ${DateFormatter.formatForDisplay(record.date)}?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: TextButton.styleFrom(foregroundColor: AppColors.error),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed == true && record.id != null) {
      final success = await Provider.of<HealthRecordProvider>(
        context,
        listen: false,
      ).deleteRecord(record.id!);

      if (success && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Record deleted successfully'),
            backgroundColor: AppColors.success,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Health Records'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          if (_filterDate != null)
            IconButton(
              icon: const Icon(Icons.clear),
              onPressed: _clearFilter,
              tooltip: 'Clear filter',
            ),
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () => _selectDateFilter(context),
            tooltip: 'Filter by date',
          ),
        ],
      ),
      body: Column(
        children: [
          // Filter indicator
          if (_filterDate != null)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              color: AppColors.primaryLight,
              child: Row(
                children: [
                  const Icon(Icons.filter_list, size: 20, color: Colors.white),
                  const SizedBox(width: 8),
                  Text(
                    'Showing: ${DateFormatter.formatForDisplay(_filterDate!)}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

          // Records list
          Expanded(
            child: Consumer<HealthRecordProvider>(
              builder: (context, provider, child) {
                if (provider.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (provider.error != null) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.error_outline,
                          size: 64,
                          color: AppColors.error,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          provider.error!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: AppColors.error),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: provider.loadRecords,
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  );
                }

                if (provider.records.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.inbox, size: 80, color: Colors.grey[400]),
                        const SizedBox(height: 16),
                        Text(
                          _filterDate != null
                              ? 'No records found for this date'
                              : 'No health records yet',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Tap + to add your first record',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[500],
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return RefreshIndicator(
                  onRefresh: provider.loadRecords,
                  child: ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: provider.records.length,
                    itemBuilder: (context, index) {
                      final record = provider.records[index];
                      return _buildRecordCard(record);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(
                MaterialPageRoute(
                  builder: (context) => const AddRecordScreen(),
                ),
              )
              .then((_) {
                // Reload records after returning from add screen
                Provider.of<HealthRecordProvider>(
                  context,
                  listen: false,
                ).loadRecords();
              });
        },
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildRecordCard(HealthRecord record) {
    final isToday = DateFormatter.isToday(record.date);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Dismissible(
        key: Key(record.id.toString()),
        direction: DismissDirection.endToStart,
        background: Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 20),
          decoration: BoxDecoration(
            color: AppColors.error,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(Icons.delete, color: Colors.white, size: 32),
        ),
        confirmDismiss: (direction) async {
          await _deleteRecord(record);
          return false; // We handle deletion manually
        },
        child: InkWell(
          onTap: () => _editRecord(record),
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Date Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_today,
                          size: 18,
                          color: isToday
                              ? AppColors.primary
                              : AppColors.textSecondary,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          DateFormatter.formatForDisplay(record.date),
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: isToday
                                ? AppColors.primary
                                : AppColors.textPrimary,
                          ),
                        ),
                        if (isToday) ...[
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Text(
                              'Today',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    const Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: AppColors.textSecondary,
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Health Metrics
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildMetric(
                      icon: Icons.directions_walk,
                      label: 'Steps',
                      value: record.steps.toString(),
                      color: AppColors.stepsGreen,
                    ),
                    _buildMetric(
                      icon: Icons.local_fire_department,
                      label: 'Calories',
                      value: record.calories.toString(),
                      color: AppColors.caloriesOrange,
                    ),
                    _buildMetric(
                      icon: Icons.water_drop,
                      label: 'Water',
                      value: '${record.water} ml',
                      color: AppColors.waterBlue,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMetric({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Column(
      children: [
        Icon(icon, color: color, size: 28),
        const SizedBox(height: 4),
        Text(label, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
        const SizedBox(height: 2),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }
}
