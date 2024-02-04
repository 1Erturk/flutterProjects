import 'package:flutter/material.dart';

class CheckboxProvider with ChangeNotifier {
  bool _checkboxSeciliMi = false;

  bool get checkboxSeciliMi => _checkboxSeciliMi;

  set checkboxSeciliMi(bool value) {
    _checkboxSeciliMi = value;
    notifyListeners();
  }

}