import 'package:flutter/material.dart';

class ImagePickerProvider extends ChangeNotifier {
  String _imagePath = '';

  String get path => _imagePath;

  set setPath(String path) {
    _imagePath = path;
    notifyListeners();
  }
}
