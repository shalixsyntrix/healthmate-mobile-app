import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/constants/app_colors.dart';
import 'features/dashboard/providers/dashboard_provider.dart';
import 'features/dashboard/screens/dashboard_screen.dart';
import 'features/health_records/providers/health_record_provider.dart';
import 'features/health_records/screens/add_record_screen.dart';
import 'features/health_records/screens/record_list_screen.dart';
import 'features/splash/screens/splash_screen.dart';

void main() {
  runApp(const HealthMateApp());
}

class HealthMateApp extends StatelessWidget {
  const HealthMateApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HealthRecordProvider()),
        ChangeNotifierProvider(create: (_) => DashboardProvider()),
      ],
      child: MaterialApp(
        title: 'HealthMate',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.teal,
          primaryColor: AppColors.primary,
          scaffoldBackgroundColor: AppColors.background,
          colorScheme: ColorScheme.fromSeed(
            seedColor: AppColors.primary,
            primary: AppColors.primary,
            secondary: AppColors.primaryLight,
          ),
          appBarTheme: const AppBarTheme(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            elevation: 0,
            centerTitle: true,
          ),
          cardTheme: const CardThemeData(
            color: AppColors.cardBackground,
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
          ),
          inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.primary, width: 2),
            ),
          ),
          useMaterial3: true,
        ),
        home: const SplashScreen(),
        routes: {
          SplashScreen.routeName: (context) => const SplashScreen(),
          DashboardScreen.routeName: (context) => const DashboardScreen(),
          AddRecordScreen.routeName: (context) => const AddRecordScreen(),
          RecordListScreen.routeName: (context) => const RecordListScreen(),
        },
      ),
    );
  }
}
