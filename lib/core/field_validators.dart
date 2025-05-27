import 'package:activ/utils/widgets/core_widgets/phone_textfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:phone_numbers_parser/phone_numbers_parser.dart';
import 'package:activ/l10n/localization_service.dart';

class FieldValidators {
  static String? phoneNumberValidator(String? value, IsoCode? isoCode) {
    if (value == null || value.isEmpty) {
      return Localization.enterPhoneNumber;
    }

    try {
      final phoneNumber = PhoneNumber.parse(
        value,
        callerCountry: isoCode,
      );

      if (!phoneNumber.isValid()) {
        return Localization.enterValidPhoneNumber;
      }

      if (!phoneNumber.isValidLength()) {
        return Localization.enterCompletePhoneNumber;
      }

      return null;
    } catch (e) {
      return Localization.enterValidPhoneNumber;
    }
  }

  static String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return Localization.enterEmail;
    }
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return Localization.enterValidEmail;
    }
    return null;
  }

  static String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return Localization.enterPassword;
    }
    if (value.length < 6) {
      return Localization.passwordTooShortMessage;
    }
    if (value.length > 100) {
      return Localization.passwordTooLongMessage;
    }
    return null;
  }

  static String? confirmPasswordValidator(
    String? value,
    TextEditingController passwordController,
  ) {
    if (value == null || value.isEmpty) {
      return Localization.confirmYourPassword;
    }
    if (value != passwordController.text) {
      return Localization.passwordsDoNotMatch;
    }

    return null;
  }

  static String? nameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return Localization.enterName;
    }
    if (!RegExp(r"^[a-zA-Z\s'-]+$").hasMatch(value)) {
      return Localization.invalidNameFormat;
    }
    if (value.length < 2) {
      return Localization.nameTooShort;
    }
    if (value.length > 30) {
      return Localization.nameTooLong;
    }
    return null;
  }

  static String? textValidator(String? value) {
    if (value == null || value.isEmpty) {
      return Localization.enterText;
    }
    return null;
  }

  static String? numberValidator(
    String? value, {
    int? min,
    int? max,
  }) {
    if (value == null || value.isEmpty) {
      return Localization.enterNumber;
    }

    final number = int.tryParse(value);
    if (number == null) {
      return Localization.enterValidNumber;
    }

    if (min != null && number < min) {
      return Localization.numberMustBeGreaterThan(min);
    }

    if (max != null && number > max) {
      return Localization.numberMustBeLessThan(max);
    }

    return null;
  }

  static String? dateValidator(String? value) {
    if (value == null || value.isEmpty) {
      return Localization.enterDate;
    }

    final date = DateFormat('dd/MM/yyyy').tryParse(value);
    if (date == null) {
      return Localization.enterValidDateFormat;
    }

    if (date.isAfter(DateTime.now())) {
      return Localization.dateMustBeInPast;
    }

    return null;
  }

  static String? timeValidator(String? value, DateTime? date) {
    if (value == null || value.isEmpty) {
      return 'Please enter a time';
    }

    final timeParts = value.split(':');
    if (timeParts.length != 2) {
      return 'Please enter a valid time in format';
    }

    final hour = int.tryParse(timeParts[0]);
    final minute = int.tryParse(timeParts[1]);

    if (hour == null ||
        minute == null ||
        hour < 0 ||
        hour > 23 ||
        minute < 0 ||
        minute > 59) {
      return 'Please enter a valid time';
    }

    if (date != null) {
      final enteredDateTime =
          DateTime(date.year, date.month, date.day, hour, minute);
      final now = DateTime.now();
      if (enteredDateTime.isBefore(now)) {
        return 'Time must be greater than or equal to now';
      }
    }

    return null;
  }
}
