import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeNotifier extends ChangeNotifier {
  static const _key = 'themeMode';
  ThemeMode _themeMode = ThemeMode.system;

  ThemeNotifier() {
    _loadTheme();
  }

  ThemeMode get themeMode => _themeMode;

  bool get isDarkMode => _themeMode == ThemeMode.dark;

  void toggleTheme([bool? value]) {
    _themeMode = value != null
        ? (value ? ThemeMode.dark : ThemeMode.light)
        : (_themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark);
    notifyListeners();
    _saveTheme();
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final index = prefs.getInt(_key);
    if (index != null) {
      _themeMode = ThemeMode.values[index];
      notifyListeners(); // important to notify after loading
    }
  }

  Future<void> _saveTheme() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_key, _themeMode.index);
  }
}
