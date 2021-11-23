import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsController with ChangeNotifier {
  late ThemeMode _themeMode;

  ThemeMode get themeMode => _themeMode;

  SettingsController() {
    loadSettings();
  }

  Future<void> loadSettings() async {
    _themeMode = ThemeMode.dark;
    notifyListeners();
  }

  Future<void> updateThemeMode(ThemeMode? newThemeMode) async {
    if (newThemeMode == null) return;
    if (newThemeMode == _themeMode) return;
    _themeMode = newThemeMode;
    notifyListeners();
  }
}
