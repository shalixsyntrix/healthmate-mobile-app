# HealthMate Test Cases

## Test Case 1: Add Health Record

**Objective**: Verify that a user can add a new health record with valid data

**Preconditions**: App is installed and running

**Steps**:

1. Launch the app
2. Tap on "Add Health Record" button
3. Select a date using the date picker
4. Enter steps: 5000
5. Enter calories: 250
6. Enter water: 1500
7. Tap "Save Record" button

**Expected Result**:

- Record is saved successfully
- User is navigated back to dashboard
- Dashboard shows updated totals (if date is today)
- Record appears in the list when viewing all records

**Actual Result**: ✅ Pass

---

## Test Case 2: Search/Filter by Date

**Objective**: Verify that users can filter health records by a specific date

**Preconditions**:

- App is running
- At least 3 health records exist with different dates

**Steps**:

1. Navigate to "View All Records" screen
2. Tap the filter icon in the app bar
   3.Select a specific date from the date picker
3. Confirm the selection

**Expected Result**:

- Only records matching the selected date are displayed
- Filter indicator shows the selected date
- Clear filter button is visible
- Empty state is shown if no records exist for that date

**Actual Result**: ✅ Pass

---

## Test Case 3: Delete Health Record

**Objective**: Verify that a user can delete an existing health record

**Preconditions**:

- App is running
- At least one health record exists in the database

**Steps**:

1. Navigate to "View All Records" screen
2. Find a record to delete
3. Swipe the record card from right to left
4. Confirm deletion in the dialog (or dismiss gesture completes)

**Expected Result**:

- Confirmation dialog appears
- After confirming, the record is removed from the list
- Success message is displayed
- Database no longer contains the deleted record
- Dashboard totals update if deleted record was for today

**Actual Result**: ✅ Pass

---

## Test Case 4: Form Validation - Invalid Input

**Objective**: Verify that form validation works correctly for invalid inputs

**Preconditions**: App is running

**Steps**:

1. Navigate to "Add Health Record" screen
2. Leave steps field empty
3. Enter negative value in calories: -100
4. Enter unrealistic value in water: 50000
5. Tap "Save Record" button

**Expected Result**:

- Error message for empty steps field: "Please enter steps"
- Error message for negative calories: "Calories cannot be negative"
- Error message for unrealistic water: "Value seems too high (max 20,000 ml)"
- Record is not saved
- User remains on the form screen

**Actual Result**: ✅ Pass

---

## Test Case 5: Edit Existing Record

**Objective**: Verify that a user can edit an existing health record

**Preconditions**:

- App is running
- At least one health record exists

**Steps**:

1. Navigate to "View All Records" screen
2. Tap on a record card to edit
3. Modify the steps value to 7000
4. Modify the water value to 2000
5. Tap "Update Record" button

**Expected Result**:

- Edit screen opens with pre-filled values
- Changes are saved to database
- User is navigated back to list screen
- Updated values are displayed in the record card
- Dashboard reflects changes if record was for today

**Actual Result**: ✅ Pass

---

## Test Case 6: Dashboard Summary Display

**Objective**: Verify that the dashboard correctly displays today's health summary

**Preconditions**:

- App is running
- At least 2 health records exist for today's date

**Steps**:

1. Add first record: steps=3000, calories=150, water=800
2. Add second record: steps=2000, calories=100, water=700
3. Navigate to Dashboard screen
4. Pull down to refresh

**Expected Result**:

- Dashboard displays:
  - Total steps: 5000
  - Total calories: 250
  - Total water: 1500 ml
- All metrics are color-coded correctly
- Date shows today's date
- Quick action buttons are functional

**Actual Result**: ✅ Pass

---

## Test Case 7: Empty State Handling

**Objective**: Verify that appropriate empty states are shown when no data exists

**Preconditions**:

- Fresh app installation (or database cleared)

**Steps**:

1. Launch the app
2. View the dashboard
3. Navigate to "View All Records"

**Expected Result**:

- Dashboard shows all metrics as 0
- Record list shows empty state with icon and message
- Empty state message: "No health records yet"
- Helpful text: "Tap + to add your first record"

**Actual Result**: ✅ Pass

---

## Test Case 8: Date Selector Past Dates Only

**Objective**: Verify that date picker doesn't allow future dates

**Preconditions**: App is running

**Steps**:

1. Navigate to "Add Health Record" screen
2. Tap on the date selector
3. Attempt to select a future date

**Expected Result**:

- Date picker shows dates up to today only
- Future dates are disabled/not selectable
- Maximum selectable date is today's date

**Actual Result**: ✅ Pass

---

## Summary

| Test Case             | Status  | Priority |
| --------------------- | ------- | -------- |
| Add Health Record     | ✅ Pass | High     |
| Search/Filter by Date | ✅ Pass | High     |
| Delete Health Record  | ✅ Pass | High     |
| Form Validation       | ✅ Pass | High     |
| Edit Existing Record  | ✅ Pass | Medium   |
| Dashboard Summary     | ✅ Pass | High     |
| Empty State Handling  | ✅ Pass | Medium   |
| Date Selector         | ✅ Pass | Medium   |

**Total**: 8/8 tests passed (100%)
