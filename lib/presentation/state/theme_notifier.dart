import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeNotifier extends ChangeNotifier {
  static const _key = 'themeMode';
  final SharedPreferences prefs;
  ThemeMode _themeMode = ThemeMode.system;

  ThemeNotifier({required this.prefs}) {
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

  void _loadTheme() {
    final index = prefs.getInt(_key);
    if (index != null) {
      _themeMode = ThemeMode.values[index];
      notifyListeners();
    }
  }

  Future<void> _saveTheme() async {
    await prefs.setInt(_key, _themeMode.index);
  }
}
