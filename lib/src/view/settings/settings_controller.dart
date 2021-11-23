import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsController with ChangeNotifier {
  String? _expectedOCR;

  String? get expectedOCR => _expectedOCR;

  set expectedOCR(String? value) {
    _expectedOCR = value;
    notifyListeners();
  }
}
