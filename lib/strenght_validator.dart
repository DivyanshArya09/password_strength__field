import 'package:password_strength__field/text_field_enums.dart';

class Validators {
  Validators._(); // private constructors
  static String? validateEmail(String? email) {
    final emailRegExp =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

    if (email == null || email.isEmpty) {
      return 'Email cannot be empty.';
    } else if (!emailRegExp.hasMatch(email)) {
      return 'Invalid email format.';
    }
    return null;
  }

  static String? validateName(String name) {
    if (name.isEmpty) {
      return 'Name cannot be empty.';
    }
    return null;
  }

  static String? validatePassword({String? password, String? confirmPassword}) {
    if (password == null || password.isEmpty) {
      return 'Password cannot be empty.';
    }
    if (confirmPassword == null) {
      return 'Confirm password cannot be empty.';
    }
    if (password != confirmPassword) {
      return 'Passwords do not match.';
    }
    return null;
  }

  static PasswordValidationStatus checkStrength(String password) {
    if (password.length < 6) {
      return PasswordValidationStatus.SHORT;
    }

    const int lengthWeight = 2;
    const int letterWeight = 2;
    const int digitWeight = 2;
    const int specialCharWeight = 1;

    int score = 0;

    if (password.contains(RegExp(r'[a-zA-Z]'))) {
      score += letterWeight;
    }

    if (password.contains(RegExp(r'[0-9]'))) {
      score += digitWeight;
    }

    if (password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      score += specialCharWeight;
    }

    double percentage = (score /
            (lengthWeight + letterWeight + digitWeight + specialCharWeight)) *
        100;

    if (percentage < 40) {
      return PasswordValidationStatus.WEAK;
    } else if (percentage < 70) {
      return PasswordValidationStatus.MEDIUM;
    } else {
      return PasswordValidationStatus.STRONG;
    }
  }

  static String? validateNumber(String number) {
    RegExp numberRegExp = RegExp(r'^[0-9]+$');

    if (number.isEmpty) {
      return 'Number cannot be empty.';
    }

    if (!numberRegExp.hasMatch(number)) {
      return 'Invalid phone number.';
    }

    if (number.length < 10) {
      return 'Phone number must be at least 10 characters long.';
    }

    return null;
  }

  static String? validatePasswordMatch(
      String password, String confirmPassword) {
    if (password != confirmPassword) {
      return 'Passwords do not match.';
    }
    return null;
  }

  static String? validatorOTP(String otp) {
    if (otp.isEmpty) {
      return 'OTP cannot be empty.';
    }
    if (otp.length < 4) {
      return 'OTP must be at least 4 characters long.';
    }
    return null;
  }
}
