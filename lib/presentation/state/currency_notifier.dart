import 'package:dukoin/domain/currency.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CurrencyNotifier extends ChangeNotifier {
  static const _key = 'currency';
  final SharedPreferences _prefs;
  Currency _currency = Currency.EUR;

  CurrencyNotifier({required SharedPreferences prefs}) : _prefs = prefs {
    _loadCurrency();
  }

  Currency get currency => _currency;

  void changeCurrency(Currency? newCurrency) {
    if (newCurrency != null) {
      _currency = newCurrency;
      notifyListeners();
      _saveCurrency();
    }
  }

  void _loadCurrency() {
    final index = _prefs.getInt(_key);
    if (index != null && index >= 0 && index < Currency.values.length) {
      _currency = Currency.values[index];
      notifyListeners();
    }
  }

  Future<void> _saveCurrency() async {
    await _prefs.setInt(_key, _currency.index);
  }
}
