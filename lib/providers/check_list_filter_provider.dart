import 'package:flutter/material.dart';

class CheckListFilterProvider extends ChangeNotifier {
  List<String> _checkListFilter = [];

  List<String> get getCheckListFilter => _checkListFilter;

  set setCheckListFilter(String value) {
    _checkListFilter.add(value);
    notifyListeners();
  }

  set removeCheckListFilter(String value) {
    _checkListFilter.remove(value);
    notifyListeners();
  }

  void clear() {
    _checkListFilter.clear();
    notifyListeners();
  }
}
