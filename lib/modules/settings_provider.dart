import 'package:flutter/material.dart';

class SettingsProvider extends ChangeNotifier {
  final List<String> _languages = [
    "English",
    "عربي",
  ];

  final List<String> _themes = [
    "Light",
    "Dark",
  ];

  List<String> get languages => _languages;

  List<String> get themes => _themes;

  /// Observer Pattern
  String currentLanguage = "en";
  ThemeMode currentThemeMode = ThemeMode.light;

  void setNewLanguage(String newLanguage) {
    if (currentLanguage == newLanguage) return;
    currentLanguage = newLanguage;

    notifyListeners();
  }

  void setNewTheme(ThemeMode newTheme) {
    if (currentThemeMode == newTheme) return;
    currentThemeMode = newTheme;

    notifyListeners();
  }

  bool isDark() {
    return currentThemeMode == ThemeMode.dark;
  }
}
