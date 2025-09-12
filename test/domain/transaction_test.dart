import 'package:dukoin/domain/transaction.dart';
import 'package:test/test.dart';

void main() {
  group("Transaction", () {
    group('compareTo', () {
      test('returns 0 when createdAt is the same', () {
        final t1 = Transaction(
          amount: 100,
          description: 'Same day',
          isExpense: true,
          createdAt: DateTime(2023, 1, 1),
        );

        final t2 = Transaction(
          amount: 200,
          description: 'Same day',
          isExpense: false,
          createdAt: DateTime(2023, 1, 1),
        );

        expect(t1.compareTo(t2), 0);
        expect(t2.compareTo(t1), 0);
      });

      test('returns negative when this is more recent (should come first)', () {
        final newer = Transaction(
          amount: 100,
          description: 'Newer',
          isExpense: false,
          createdAt: DateTime(2023, 1, 2),
        );

        final older = Transaction(
          amount: 50,
          description: 'Older',
          isExpense: true,
          createdAt: DateTime(2023, 1, 1),
        );

        expect(newer.compareTo(older), lessThan(0));
      });

      test('returns positive when this is older (should come later)', () {
        final newer = Transaction(
          amount: 100,
          description: 'Newer',
          isExpense: false,
          createdAt: DateTime(2023, 1, 2),
        );

        final older = Transaction(
          amount: 50,
          description: 'Older',
          isExpense: true,
          createdAt: DateTime(2023, 1, 1),
        );

        expect(older.compareTo(newer), greaterThan(0));
      });

      test('sorting a list puts newest first', () {
        final t1 = Transaction(
          amount: 10,
          description: 'Oldest',
          isExpense: true,
          createdAt: DateTime(2023, 1, 1),
        );

        final t2 = Transaction(
          amount: 20,
          description: 'Middle',
          isExpense: false,
          createdAt: DateTime(2023, 1, 2),
        );

        final t3 = Transaction(
          amount: 30,
          description: 'Newest',
          isExpense: true,
          createdAt: DateTime(2023, 1, 3),
        );

        final list = [t1, t3, t2]..sort();

        expect(list, [t3, t2, t1]); // newest → oldest
      });
    });
  });
}
