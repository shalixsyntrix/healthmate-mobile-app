# HealthMate - Coursework Compliance Report

This document maps every requirement from the coursework specification to the specific implementation in the HealthMate application.

## 1. Coursework Overview

| Requirement                                         | Status | Implementation Details                               |
| --------------------------------------------------- | ------ | ---------------------------------------------------- |
| **Theme**: HealthMate – Personal Health Tracker App | ✅     | App named "HealthMate", tracks health metrics.       |
| **Tech**: Flutter-based mobile mini application     | ✅     | Built with Flutter SDK, runnable on Android/Windows. |
| **Goal**: Track daily health activities             | ✅     | Tracks Steps, Calories, and Water intake.            |
| **Cross-platform**: Mobile development              | ✅     | Flutter codebase supports Android & iOS.             |
| **Database**: Embedded database handling            | ✅     | Uses `sqflite` (SQLite) for local storage.           |
| **UI/UX**: Good practices                           | ✅     | Material Design 3, responsive layout, feedback.      |

## 2. Core Features

| Requirement                   | Status | Implementation Details                                     |
| ----------------------------- | ------ | ---------------------------------------------------------- |
| **Add daily health entries**  | ✅     | `AddRecordScreen` allows inputting Steps, Calories, Water. |
| **View list of past records** | ✅     | `RecordListScreen` displays chronological history.         |
| **Update records**            | ✅     | Tap any record in the list to edit it.                     |
| **Delete records**            | ✅     | Swipe left on any record to delete it.                     |
| **Search/filter by date**     | ✅     | Filter icon in `RecordListScreen` allows date selection.   |
| **Summary Dashboard**         | ✅     | `DashboardScreen` shows today's aggregated totals.         |

## 3. Part A – Software Implementation (70%)

### Application Architecture (25 marks)

| Requirement                        | Status | Implementation Details                                                   |
| ---------------------------------- | ------ | ------------------------------------------------------------------------ |
| **Feature-based folder structure** | ✅     | `lib/features/dashboard`, `lib/features/health_records`, `lib/core`.     |
| **State Management**               | ✅     | **Provider** package used (`DashboardProvider`, `HealthRecordProvider`). |
| **Architecture Diagram**           | ✅     | Included in `ARCHITECTURE.md` and `walkthrough.md`.                      |

### UI/UX Design (15 marks)

| Requirement                    | Status | Implementation Details                                      |
| ------------------------------ | ------ | ----------------------------------------------------------- |
| **Add Record screen**          | ✅     | Form with validation for numeric inputs and ranges.         |
| **Health Record List screen**  | ✅     | Scrollable list, search functionality, empty states.        |
| **Dashboard screen**           | ✅     | Summary cards for today's activities.                       |
| **Material Design guidelines** | ✅     | Uses `ThemeData`, `Card`, `FloatingActionButton`, `AppBar`. |
| **Color schemes & icons**      | ✅     | Water=Blue, Calories=Orange, Steps=Green. Consistent icons. |
| **Wireframes/screenshots**     | ✅     | Included in `WIREFRAMES.md` (Professional Style).           |

### Database Integration (30 marks)

| Requirement                  | Status | Implementation Details                                           |
| ---------------------------- | ------ | ---------------------------------------------------------------- |
| **Use sqflite database**     | ✅     | `sqflite: ^2.3.0` dependency used.                               |
| **Table `health_records`**   | ✅     | Created in `DatabaseHelper._createDB`.                           |
| **Field: `id` (PK)**         | ✅     | `id INTEGER PRIMARY KEY AUTOINCREMENT`.                          |
| **Field: `date` (text)**     | ✅     | `date TEXT NOT NULL`.                                            |
| **Field: `steps` (int)**     | ✅     | `steps INTEGER NOT NULL`.                                        |
| **Field: `calories` (int)**  | ✅     | `calories INTEGER NOT NULL`.                                     |
| **Field: `water` (int, ml)** | ✅     | `water INTEGER NOT NULL`.                                        |
| **Full CRUD operations**     | ✅     | `insertRecord`, `getAllRecords`, `updateRecord`, `deleteRecord`. |
| **Dummy records**            | ✅     | 5 test records inserted on database creation.                    |

## 4. Part B – Documentation & Testing (30%)

### Technical Documentation (20 marks)

| Requirement                 | Status | Implementation Details                                      |
| --------------------------- | ------ | ----------------------------------------------------------- |
| **Project Overview**        | ✅     | See `README.md` (Project Overview section).                 |
| **Architecture & Design**   | ✅     | See `ARCHITECTURE.md` (Diagrams, structure, schema).        |
| **Implementation**          | ✅     | Code is fully commented; CRUD detailed in `walkthrough.md`. |
| **Third-party Libraries**   | ✅     | Documented in `README.md` and `walkthrough.md`.             |
| **UI/UX (Wireframes)**      | ✅     | See `WIREFRAMES.md` (ASCII art & Mermaid flows).            |
| **Test Cases (at least 3)** | ✅     | 8 Test Cases documented in `TEST_CASES.md`.                 |
| **Issues/Errors & Fixes**   | ✅     | Documented in `walkthrough.md`.                             |
| **References**              | ✅     | Provided in `QUICK_START.md` (Harvard format).              |

### Deliverables (10 marks)

| Requirement               | Status | Action Required by Student                                     |
| ------------------------- | ------ | -------------------------------------------------------------- |
| **Release APK file**      | ✅     | Built at `build/app/outputs/flutter-apk/app-release.apk`.      |
| **Source code on GitHub** | ⏳     | **YOU MUST DO THIS**. Follow instructions in `QUICK_START.md`. |
| **Demo video (≤25 MB)**   | ⏳     | **YOU MUST DO THIS**. Record screen showing features.          |

## Final Verification

**Compliance Score: 100%** (for all implemented parts)

The application code and generated documentation meet **ALL** specified requirements for the coursework. The only remaining steps are for you to:

1. Push the code to GitHub.
2. Record the demo video.
3. Compile the provided markdown files into your final PDF report.
