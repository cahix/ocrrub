import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ocrrub/src/view/ocr/expected_texts.dart';
import 'package:ocrrub/src/view/widgets/scaffold_messenger.dart';

class SettingsController with ChangeNotifier {
  String? _expectedOCR;

  String? get expectedOCR => _expectedOCR;

  set expectedOCR(String? value) {
    _expectedOCR = value;
    notifyListeners();
  }

  void addToExpectedTexts(String name, String? value) {
    expectedTexts[name] = value;
    showSnackbar('Added successfully');
    expectedOCR = value;
    notifyListeners();
  }
}
