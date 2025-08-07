import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeNotifier extends ChangeNotifier {
  static const _key = 'themeMode';
  final SharedPreferences _prefs;
  ThemeMode _themeMode = ThemeMode.system;

  ThemeNotifier({required SharedPreferences prefs}) : _prefs = prefs {
    _loadTheme();
  }

  ThemeMode get themeMode => _themeMode;

  void toggleTheme([bool? value]) {
    if (value != null) {
      _themeMode = value ? ThemeMode.dark : ThemeMode.light;
      notifyListeners();
      _saveTheme();
    }
  }

  void _loadTheme() {
    final index = _prefs.getInt(_key);
    if (index != null && index >= 0 && index < ThemeMode.values.length) {
      _themeMode = ThemeMode.values[index];
      notifyListeners();
    }
  }

  Future<void> _saveTheme() async {
    await _prefs.setInt(_key, _themeMode.index);
  }
}
