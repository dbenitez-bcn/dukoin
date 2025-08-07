import 'package:dukoin/domain/currency.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dukoin/presentation/state/currency_notifier.dart';

void main() {
  group("CurrencyNotifier", () {
    group("changeCurrency()", () {
      test("It should update to EUR and persist it", () async {
        SharedPreferences.setMockInitialValues({});
        SharedPreferences prefs = await SharedPreferences.getInstance();
        CurrencyNotifier sut = CurrencyNotifier(prefs: prefs);

        sut.changeCurrency(Currency.EUR);

        expect(sut.currency, Currency.EUR);
        expect(prefs.getInt('currency'), Currency.EUR.index);
      });

      test("It should update to JPY and persist it", () async {
        SharedPreferences.setMockInitialValues({});
        SharedPreferences prefs = await SharedPreferences.getInstance();
        CurrencyNotifier sut = CurrencyNotifier(prefs: prefs);

        sut.changeCurrency(Currency.JPY);

        expect(sut.currency, Currency.JPY);
        expect(prefs.getInt('currency'), Currency.JPY.index);
      });

      test("It should not update the currency when value is null", () async {
        SharedPreferences.setMockInitialValues({});
        SharedPreferences prefs = await SharedPreferences.getInstance();
        CurrencyNotifier sut = CurrencyNotifier(prefs: prefs);

        sut.changeCurrency(null);

        expect(sut.currency, Currency.USD);
        expect(prefs.getInt('currency'), null);
      });
    });

    group("_loadCurrency()", () {
      test("It should load default Currency.USD when no value is stored", () async {
        SharedPreferences.setMockInitialValues({});
        SharedPreferences prefs = await SharedPreferences.getInstance();
        CurrencyNotifier sut = CurrencyNotifier(prefs: prefs);

        expect(sut.currency, Currency.USD);
      });

      test("It should load stored Currency.GBP", () async {
        SharedPreferences.setMockInitialValues({'currency': Currency.GBP.index});
        SharedPreferences prefs = await SharedPreferences.getInstance();
        CurrencyNotifier sut = CurrencyNotifier(prefs: prefs);

        expect(sut.currency, Currency.GBP);
      });

      test("It should ignore invalid stored value and keep default", () async {
        SharedPreferences.setMockInitialValues({'currency': 999});
        SharedPreferences prefs = await SharedPreferences.getInstance();
        CurrencyNotifier sut = CurrencyNotifier(prefs: prefs);

        expect(sut.currency, Currency.USD); // default fallback
      });
    });
  });
}
