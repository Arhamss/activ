import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// Helper class to combine separate date and time controllers
///
/// Example usage:
/// ```dart
/// final dateController = TextEditingController();
/// final timeController = TextEditingController();
///
/// // After user selects date and time via ActivTextField
/// final isoDateTime = DateTimeHelper.combineToIsoString(
///   dateController: dateController,
///   timeController: timeController,
/// );
///
/// if (isoDateTime != null) {
///   // Send to API: "2025-06-15T14:00:00.000Z"
///   print('Combined DateTime: $isoDateTime');
/// }
/// ```
class DateTimeHelper {
  /// Combines separate date and time controllers into an ISO datetime string
  ///
  /// [dateController] - Controller containing date in "dd/MM/yyyy" format
  /// [timeController] - Controller containing time in "hh:mm AM/PM" format
  ///
  /// Returns: ISO datetime string like "2025-06-15T14:00:00.000Z"
  /// Returns null if either controller is empty or contains invalid data
  static String? combineToIsoString({
    required TextEditingController dateController,
    required TextEditingController timeController,
  }) {
    try {
      final dateText = dateController.text.trim();
      final timeText = timeController.text.trim();

      if (dateText.isEmpty || timeText.isEmpty) {
        return null;
      }

      // Parse date from "dd/MM/yyyy" format
      final dateFormat = DateFormat('dd/MM/yyyy');
      final date = dateFormat.parse(dateText);

      // Parse time from "hh:mm AM/PM" format
      final timeFormat = DateFormat('hh:mm a');
      final time = timeFormat.parse(timeText);

      // Combine date and time
      final combinedDateTime = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );

      // Convert to UTC and return ISO string
      return combinedDateTime.toIso8601String();
    } catch (e) {
      // Return null if parsing fails
      return null;
    }
  }

  /// Combines date and time controllers into a DateTime object
  ///
  /// [dateController] - Controller containing date in "dd/MM/yyyy" format
  /// [timeController] - Controller containing time in "hh:mm AM/PM" format
  ///
  /// Returns: DateTime object or null if parsing fails
  static DateTime? combineToDateTime({
    required TextEditingController dateController,
    required TextEditingController timeController,
  }) {
    try {
      final dateText = dateController.text.trim();
      final timeText = timeController.text.trim();

      if (dateText.isEmpty || timeText.isEmpty) {
        return null;
      }

      // Parse date from "dd/MM/yyyy" format
      final dateFormat = DateFormat('dd/MM/yyyy');
      final date = dateFormat.parse(dateText);

      // Parse time from "hh:mm AM/PM" format
      final timeFormat = DateFormat('hh:mm a');
      final time = timeFormat.parse(timeText);

      // Combine date and time
      return DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );
    } catch (e) {
      // Return null if parsing fails
      return null;
    }
  }

  /// Sets separate date and time controllers from an ISO datetime string
  ///
  /// [isoString] - ISO datetime string like "2025-06-15T14:00:00.000Z"
  /// [dateController] - Controller to set date in "dd/MM/yyyy" format
  /// [timeController] - Controller to set time in "hh:mm AM/PM" format
  static void setFromIsoString({
    required String isoString,
    required TextEditingController dateController,
    required TextEditingController timeController,
  }) {
    try {
      final dateTime = DateTime.parse(isoString).toLocal();

      // Set date controller
      final dateFormat = DateFormat('dd/MM/yyyy');
      dateController.text = dateFormat.format(dateTime);

      // Set time controller
      final timeFormat = DateFormat('hh:mm a');
      timeController.text = timeFormat.format(dateTime);
    } catch (e) {
      // Clear controllers if parsing fails
      dateController.clear();
      timeController.clear();
    }
  }

  /// Validates if both date and time controllers have valid values
  ///
  /// [dateController] - Controller containing date
  /// [timeController] - Controller containing time
  ///
  /// Returns: true if both controllers have valid values
  static bool isValidDateTimeInput({
    required TextEditingController dateController,
    required TextEditingController timeController,
  }) {
    return combineToDateTime(
          dateController: dateController,
          timeController: timeController,
        ) !=
        null;
  }
}
