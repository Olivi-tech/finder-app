import 'package:flutter/material.dart';

class ItemFilterProvider extends ChangeNotifier {
  List<Map<String, dynamic>> _filterData = [];

  List<Map<String, dynamic>> get filterData => _filterData;

  set setFilterData(List<Map<String, dynamic>> filterData) {
    _filterData = filterData;
    notifyListeners();
  }

  void clear() {
    _filterData.clear();
    notifyListeners();
  }

  void cancelFilterByIndex({
    required int index,
    required String filterKey,
  }) {
    Map<String, dynamic> data = _filterData.elementAt(index);
    data.update(filterKey, (value) => '');
    notifyListeners();
  }
}
