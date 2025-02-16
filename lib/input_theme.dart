import 'package:flutter/material.dart';

class CustomTextFieldTheme {
  static InputDecorationTheme get light => InputDecorationTheme(
        filled: true,
        border: _buildOutlineInputBorder(color: Colors.grey),
        fillColor: Colors.white,
        enabledBorder: _buildOutlineInputBorder(),
        focusedBorder: _buildOutlineInputBorder(
          color: Colors.purple,
        ),
        errorBorder: _buildOutlineInputBorder(color: Colors.red),
        focusedErrorBorder: _buildOutlineInputBorder(color: Colors.red),
        hintStyle: const TextStyle(
          color: Colors.grey,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
      );

  static _buildOutlineInputBorder({Color? color = Colors.grey}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(20.0),
      borderSide: BorderSide(color: color!, width: 1),
    );
  }
}
