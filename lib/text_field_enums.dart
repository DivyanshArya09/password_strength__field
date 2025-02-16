import 'package:flutter/material.dart';

enum PasswordValidationStatus { WEAK, MEDIUM, STRONG, SHORT }

extension PasswordValidationStatusExtension on PasswordValidationStatus {
  String get value {
    switch (this) {
      case PasswordValidationStatus.WEAK:
        return 'Weak';
      case PasswordValidationStatus.MEDIUM:
        return 'Medium';
      case PasswordValidationStatus.STRONG:
        return 'Strong';
      case PasswordValidationStatus.SHORT:
        return 'Short Password';
    }
  }

  double get score {
    switch (this) {
      case PasswordValidationStatus.WEAK:
        return 0.3;
      case PasswordValidationStatus.MEDIUM:
        return 0.75;
      case PasswordValidationStatus.STRONG:
        return 1.0;
      case PasswordValidationStatus.SHORT:
        return 0.15;
    }
  }

  Color get color {
    switch (this) {
      case PasswordValidationStatus.WEAK:
        return Color.fromARGB(255, 248, 19, 3);
      case PasswordValidationStatus.MEDIUM:
        return Color.fromARGB(255, 219, 198, 6);
      case PasswordValidationStatus.STRONG:
        return Colors.green;
      case PasswordValidationStatus.SHORT:
        return Color.fromARGB(255, 248, 19, 3);
    }
  }

  String get message {
    switch (this) {
      case PasswordValidationStatus.WEAK:
        return 'Password is too weak';
      case PasswordValidationStatus.MEDIUM:
        return 'Please use special characters or numbers';
      case PasswordValidationStatus.STRONG:
        return 'You are good to go!';
      case PasswordValidationStatus.SHORT:
        return 'Password is too short';
    }
  }

  Icon get icon {
    switch (this) {
      case PasswordValidationStatus.WEAK:
        return const Icon(
          Icons.error,
          color: Colors.red,
        );

      case PasswordValidationStatus.MEDIUM:
        return const Icon(
          Icons.info,
          color: Color.fromARGB(255, 219, 198, 6),
        );

      case PasswordValidationStatus.STRONG:
        return const Icon(
          Icons.check_circle,
          color: Colors.green,
        );

      default:
        return const Icon(
          Icons.error,
          color: Colors.red,
        );
    }
  }
}
