# HealthMate - Personal Health Tracker App 🏥

A comprehensive Flutter-based mobile application for tracking daily health activities including steps walked, calories burned, and water intake. Built with clean architecture, state management, and modern UI/UX principles.

## 📱 Features

- **Dashboard**: View today's health summary with color-coded metrics
- **Add Records**: Create health records with date selection and validated inputs
- **View History**: Browse all past records with filtering by date
- **Edit & Delete**: Update or remove existing records with swipe gestures
- **Search**: Filter records by specific dates
- **Offline Storage**: All data stored locally using SQLite
- **Material Design**: Clean, modern UI following Material Design 3 guidelines

## 🏗️ Architecture

### Feature-Based Structure

```
lib/
├── core/                    # Core utilities and constants
│   ├── constants/          # App-wide constants (colors, etc.)
│   ├── database/           # Database helper (SQLite)
│   └── utils/              # Utility functions
├── features/               # Feature modules
│   ├── dashboard/          # Dashboard feature
│   └── health_records/     # Health records feature
└── widgets/                # Reusable widgets
```

### State Management

- **Provider**: Official Flutter state management solution
- **ChangeNotifier**: For reactive state updates
- **Separation of Concerns**: Business logic in providers, UI in screens

### Database

- **SQLite** (via sqflite package)
- **Table**: `health_records` (id, date, steps, calories, water)
- **CRUD Operations**: Full Create, Read, Update, Delete support
- **Dummy Data**: Pre-populated test data for demonstration

## 🎨 UI/UX Design

### Color Scheme

- **Primary**: Teal (#00897B) - Health theme
- **Steps**: Green (#4CAF50)
- **Calories**: Orange (#FF5722)
- **Water**: Blue (#2196F3)

### Screens

1. **Dashboard Screen**

   - Today's aggregated health metrics
   - Quick action buttons
   - Pull-to-refresh

2. **Add/Edit Record Screen**

   - Date picker
   - Validated input fields
   - Color-coded metrics

3. **Record List Screen**
   - Chronological list
   - Date filter
   - Swipe-to-delete
   - Tap-to-edit

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (^3.10.1)
- Dart SDK
- Android Studio / VS Code
- Android SDK for building APK

### Installation

1. **Clone the repository**

   ```bash
   git clone <repository-url>
   cd health mate
   ```

2. **Install dependencies**

   ```bash
   flutter pub get
   ```

3. **Run the app**

   ```bash
   # On connected device/emulator
   flutter run

   # On specific device
   flutter run -d <device-id>

   # On Chrome (for web)
   flutter run -d chrome

   # On Windows
   flutter run -d windows
   ```

### Building for Production

#### Android APK

```bash
# Build release APK
flutter build apk --release

# APK location: build/app/outputs/flutter-apk/app-release.apk
```

#### Android App Bundle (for Play Store)

```bash
flutter build appbundle --release
```

#### iOS

```bash
flutter build ios --release
```

## 📦 Dependencies

| Package  | Version | Purpose           |
| -------- | ------- | ----------------- |
| provider | ^6.1.1  | State management  |
| sqflite  | ^2.3.0  | SQLite database   |
| path     | ^1.8.3  | Path manipulation |
| intl     | ^0.18.1 | Date formatting   |

## 🗄️ Database Schema

**Table: health_records**

```sql
CREATE TABLE health_records (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  date TEXT NOT NULL,
  steps INTEGER NOT NULL,
  calories INTEGER NOT NULL,
  water INTEGER NOT NULL
);
```

## ✅ Testing

### Run Tests

```bash
# Run all tests
flutter test

# Run with coverage
flutter test --coverage
```

### Test Coverage

- Widget tests for dashboard screen
- Unit tests for database operations (can be added)
- Integration tests for CRUD flows (can be added)

## 📖 Documentation

- **[ARCHITECTURE.md](ARCHITECTURE.md)**: Detailed architecture and design decisions
- **Code Comments**: Inline documentation in source files
- **API Reference**: Generated using dartdoc

## 🎯 Coursework Requirements

This project fulfills the following coursework criteria:

### Part A - Software Implementation (70%)

- ✅ **Application Architecture (25%)**: Feature-based folder structure, Provider state management
- ✅ **UI/UX Design (15%)**: Material Design, color-coded metrics, validated forms
- ✅ **Database Integration (30%)**: SQLite with full CRUD operations

### Part B - Documentation & Testing (30%)

- ✅ **Technical Documentation (20%)**: README, ARCHITECTURE.md, code comments
- ✅ **Deliverables (10%)**: APK, source code, demo video

## 🐛 Known Issues & Fixes

| Issue                                  | Fix                                                  |
| -------------------------------------- | ---------------------------------------------------- |
| Deprecation warnings for `withOpacity` | Cosmetic only, doesn't affect functionality          |
| Database path on iOS                   | Uses `getDatabasesPath()` for platform compatibility |

## 📄 License

This project is submitted as coursework for Mobile Application Development.

## 👨‍💻 Developer

- **Course**: Mobile Application Development Coursework 1
- **Theme**: HealthMate – Personal Health Tracker App
- **Developed with**: Flutter & Dart

## 🙏 Acknowledgments

- Flutter Team for excellent documentation
- Material Design guidelines
- sqflite package maintainers
- Provider package by Remi Rousselet
