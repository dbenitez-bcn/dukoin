import 'package:dukoin/domain/expense.dart';
import 'package:test/test.dart';

void main() {
  group("Transaction", () {
    group('compareTo', () {
      test('returns 0 when createdAt is the same', () {
        final t1 = Income(
          amount: 100,
          description: 'Same day',
          createdAt: DateTime(2023, 1, 1),
          category: IncomeCategory.salary,
        );

        final t2 = Expense(
          amount: 200,
          description: 'Same day',
          createdAt: DateTime(2023, 1, 1),
          category: ExpenseCategory.food,
        );

        expect(t1.compareTo(t2), 0);
        expect(t2.compareTo(t1), 0);
      });

      test('returns negative when this is more recent (should come first)', () {
        final newer = Income(
          amount: 100,
          description: 'Newer',
          createdAt: DateTime(2023, 1, 2),
          category: IncomeCategory.salary,
        );

        final older = Expense(
          amount: 50,
          description: 'Older',
          createdAt: DateTime(2023, 1, 1),
          category: ExpenseCategory.food,
        );

        expect(newer.compareTo(older), lessThan(0));
      });

      test('returns positive when this is older (should come later)', () {
        final newer = Income(
          amount: 100,
          description: 'Newer',
          createdAt: DateTime(2023, 1, 2),
          category: IncomeCategory.salary,
        );

        final older = Expense(
          amount: 50,
          description: 'Older',
          createdAt: DateTime(2023, 1, 1),
          category: ExpenseCategory.food,
        );

        expect(older.compareTo(newer), greaterThan(0));
      });

      test('sorting a list puts newest first', () {
        final t1 = Income(
          amount: 10,
          description: 'Oldest',
          createdAt: DateTime(2023, 1, 1),
          category: IncomeCategory.salary,
        );

        final t2 = Expense(
          amount: 20,
          description: 'Middle',
          createdAt: DateTime(2023, 1, 2),
          category: ExpenseCategory.food,
        );

        final t3 = Income(
          amount: 30,
          description: 'Newest',
          createdAt: DateTime(2023, 1, 3),
          category: IncomeCategory.salary,
        );

        final list = [t1, t3, t2]..sort();

        expect(list, [t3, t2, t1]); // newest → oldest
      });
    });
  });
}
