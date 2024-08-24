import 'package:flutter/material.dart';

class LoginProvider extends ChangeNotifier {
  bool _isPasswordVisible = false;
  String? _errorMessage;

  bool get isPasswordVisible => _isPasswordVisible;
  String? get errorMessage => _errorMessage;

  void togglePasswordVisibility() {
    _isPasswordVisible = !_isPasswordVisible;
    notifyListeners();
  }

  bool validatePassword(String enteredPassword, String correctPassword) {
    if (enteredPassword.isEmpty) {
      _errorMessage = 'Please enter a password';
      notifyListeners();
      return false;
    } else if (enteredPassword == correctPassword) {
      _errorMessage = null;
      notifyListeners();
      return true;
    } else {
      _errorMessage = 'Incorrect password. Please try again.';
      notifyListeners();
      return false;
    }
  }
}
