import 'package:dukoin/domain/currency.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dukoin/presentation/state/currency_notifier.dart';

void main() {
  group("CurrencyNotifier", () {
    group("changeCurrency()", () {
      test("It should update to USD and persist it", () async {
        SharedPreferences.setMockInitialValues({});
        SharedPreferences prefs = await SharedPreferences.getInstance();
        CurrencyNotifier sut = CurrencyNotifier(prefs: prefs);

        sut.changeCurrency(Currency.usd);

        expect(sut.currency, Currency.usd);
        expect(prefs.getInt('currency'), Currency.usd.index);
      });

      test("It should update to JPY and persist it", () async {
        SharedPreferences.setMockInitialValues({});
        SharedPreferences prefs = await SharedPreferences.getInstance();
        CurrencyNotifier sut = CurrencyNotifier(prefs: prefs);

        sut.changeCurrency(Currency.jpy);

        expect(sut.currency, Currency.jpy);
        expect(prefs.getInt('currency'), Currency.jpy.index);
      });

      test("It should not update the currency when value is null", () async {
        SharedPreferences.setMockInitialValues({});
        SharedPreferences prefs = await SharedPreferences.getInstance();
        CurrencyNotifier sut = CurrencyNotifier(prefs: prefs);

        sut.changeCurrency(null);

        expect(sut.currency, Currency.eur);
        expect(prefs.getInt('currency'), null);
      });
    });

    group("_loadCurrency()", () {
      test(
        "It should load default Currency.EUR when no value is stored",
        () async {
          SharedPreferences.setMockInitialValues({});
          SharedPreferences prefs = await SharedPreferences.getInstance();
          CurrencyNotifier sut = CurrencyNotifier(prefs: prefs);

          expect(sut.currency, Currency.eur);
        },
      );

      test("It should load stored Currency.GBP", () async {
        SharedPreferences.setMockInitialValues({
          'currency': Currency.gbp.index,
        });
        SharedPreferences prefs = await SharedPreferences.getInstance();
        CurrencyNotifier sut = CurrencyNotifier(prefs: prefs);

        expect(sut.currency, Currency.gbp);
      });

      test("It should ignore invalid stored value and keep default", () async {
        SharedPreferences.setMockInitialValues({'currency': 999});
        SharedPreferences prefs = await SharedPreferences.getInstance();
        CurrencyNotifier sut = CurrencyNotifier(prefs: prefs);

        expect(sut.currency, Currency.eur); // default fallback
      });
    });
  });
}
