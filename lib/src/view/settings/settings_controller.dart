import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ocrrub/src/view/ocr/expected_texts.dart';

class SettingsController with ChangeNotifier {
  String? _expectedOCR = sampleText;

  String? get expectedOCR => _expectedOCR;

  set expectedOCR(String? value) {
    _expectedOCR = value;
    notifyListeners();
  }
}
