import 'package:dukoin/utils/utils.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dukoin/domain/currency.dart';

void main() {
  group('formatCurrency', () {
    test('formats USD correctly in en_US locale', () {
      final result = formatCurrency(Currency.usd, 1234.56, 'en_US');
      expect(result, '\$1,234.56');
    });

    test('formats EUR correctly in es_ES locale', () {
      final result = formatCurrency(Currency.eur, 1234.56, 'es_ES');
      expect(result, '1.234,56 €');
    });

    test('formats GBP correctly in en_GB locale', () {
      final result = formatCurrency(Currency.gbp, 1234.56, 'en_GB');
      expect(result, '£1,234.56');
    });

    test('formats JPY correctly in ja_JP locale', () {
      final result = formatCurrency(Currency.jpy, 1234, 'ja_JP');
      expect(result, '¥1,234.00');
    });

    test('formats CAD correctly in en_CA locale', () {
      final result = formatCurrency(Currency.cad, 1234.56, 'en_CA');
      expect(result, 'C\$1,234.56');
    });

    test('formats AUD correctly in en_AU locale', () {
      final result = formatCurrency(Currency.aud, 1234.56, 'en_AU');
      expect(result, 'A\$1,234.56');
    });
  });
}
