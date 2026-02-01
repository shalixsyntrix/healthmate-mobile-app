import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/date_formatter.dart';
import '../models/health_record.dart';
import '../providers/health_record_provider.dart';

class AddRecordScreen extends StatefulWidget {
  static const routeName = '/add-record';
  final HealthRecord? recordToEdit;

  const AddRecordScreen({super.key, this.recordToEdit});

  @override
  State<AddRecordScreen> createState() => _AddRecordScreenState();
}

class _AddRecordScreenState extends State<AddRecordScreen> {
  final _formKey = GlobalKey<FormState>();
  late DateTime _selectedDate;
  final _stepsController = TextEditingController();
  final _caloriesController = TextEditingController();
  final _waterController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.recordToEdit != null) {
      _selectedDate = widget.recordToEdit!.date;
      _stepsController.text = widget.recordToEdit!.steps.toString();
      _caloriesController.text = widget.recordToEdit!.calories.toString();
      _waterController.text = widget.recordToEdit!.water.toString();
    } else {
      _selectedDate = DateFormatter.getToday();
    }
  }

  @override
  void dispose() {
    _stepsController.dispose();
    _caloriesController.dispose();
    _waterController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _saveRecord() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final record = HealthRecord(
      id: widget.recordToEdit?.id,
      date: _selectedDate,
      steps: int.parse(_stepsController.text),
      calories: int.parse(_caloriesController.text),
      water: int.parse(_waterController.text),
    );

    final provider = Provider.of<HealthRecordProvider>(context, listen: false);
    bool success;

    if (widget.recordToEdit != null) {
      success = await provider.updateRecord(record);
    } else {
      success = await provider.addRecord(record);
    }

    if (success && mounted) {
      Navigator.of(context).pop();
    } else if (mounted && provider.error != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(provider.error!),
          backgroundColor: AppColors.error,
        ),
      );
      provider.clearError();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.recordToEdit != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Edit Record' : 'Add Health Record'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Date Selector
              Card(
                elevation: 2,
                child: ListTile(
                  leading: const Icon(
                    Icons.calendar_today,
                    color: AppColors.primary,
                  ),
                  title: const Text('Date'),
                  subtitle: Text(DateFormatter.formatForDisplay(_selectedDate)),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () => _selectDate(context),
                ),
              ),
              const SizedBox(height: 24),

              // Steps Input
              _buildInputField(
                controller: _stepsController,
                label: 'Steps Walked',
                icon: Icons.directions_walk,
                color: AppColors.stepsGreen,
                hint: 'e.g., 5000',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter steps';
                  }
                  final steps = int.tryParse(value);
                  if (steps == null) {
                    return 'Please enter a valid number';
                  }
                  if (steps < 0) {
                    return 'Steps cannot be negative';
                  }
                  if (steps > 100000) {
                    return 'Value seems too high (max 100,000)';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Calories Input
              _buildInputField(
                controller: _caloriesController,
                label: 'Calories Burned',
                icon: Icons.local_fire_department,
                color: AppColors.caloriesOrange,
                hint: 'e.g., 250',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter calories';
                  }
                  final calories = int.tryParse(value);
                  if (calories == null) {
                    return 'Please enter a valid number';
                  }
                  if (calories < 0) {
                    return 'Calories cannot be negative';
                  }
                  if (calories > 10000) {
                    return 'Value seems too high (max 10,000)';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Water Input
              _buildInputField(
                controller: _waterController,
                label: 'Water Intake (ml)',
                icon: Icons.water_drop,
                color: AppColors.waterBlue,
                hint: 'e.g., 1500',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter water intake';
                  }
                  final water = int.tryParse(value);
                  if (water == null) {
                    return 'Please enter a valid number';
                  }
                  if (water < 0) {
                    return 'Water intake cannot be negative';
                  }
                  if (water > 20000) {
                    return 'Value seems too high (max 20,000 ml)';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32),

              // Save Button
              Consumer<HealthRecordProvider>(
                builder: (context, provider, child) {
                  return ElevatedButton(
                    onPressed: provider.isLoading ? null : _saveRecord,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: provider.isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.white,
                              ),
                            ),
                          )
                        : Text(
                            isEditing ? 'Update Record' : 'Save Record',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required Color color,
    required String hint,
    required String? Function(String?) validator,
  }) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: color, size: 28),
                const SizedBox(width: 12),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: hint,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: color, width: 2),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
              validator: validator,
            ),
          ],
        ),
      ),
    );
  }
}
