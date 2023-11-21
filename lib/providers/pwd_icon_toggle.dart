import 'package:flutter/material.dart';

class PasswordIconToggleProvider extends ChangeNotifier {
  bool isVisible = false;

  get getIsVisible => isVisible;

  set setIsVisible(_isVisible) {
    isVisible = _isVisible;
    notifyListeners();
  }
}
