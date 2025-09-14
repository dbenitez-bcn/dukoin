import 'package:dukoin/domain/category.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Category.fromString', () {
    test('returns correct ExpenseCategory', () {
      final category = Category.fromString('food', isExpense: true);
      expect(category, ExpenseCategory.food);
    });

    test('returns correct IncomeCategory', () {
      final category = Category.fromString('salary', isExpense: false);
      expect(category, IncomeCategory.salary);
    });

    test('returns ExpenseCategory.others if value does not exist', () {
      final category = Category.fromString('nonexistent', isExpense: true);
      expect(category, ExpenseCategory.others);
    });

    test('returns IncomeCategory.others if value does not exist', () {
      final category = Category.fromString('nonexistent', isExpense: false);
      expect(category, IncomeCategory.others);
    });
  });

  group('Category.icon', () {
    test('ExpenseCategory icons are correct', () {
      expect(ExpenseCategory.food.icon, '🍔️');
      expect(ExpenseCategory.transport.icon, '🚗');
      expect(ExpenseCategory.shopping.icon, '🛍️');
      expect(ExpenseCategory.entertainment.icon, '🎬');
      expect(ExpenseCategory.bills.icon, '📄');
      expect(ExpenseCategory.health.icon, '🏥');
      expect(ExpenseCategory.education.icon, '📚');
      expect(ExpenseCategory.others.icon, '💰');
      expect(ExpenseCategory.travel.icon, '✈️');
      expect(ExpenseCategory.investments.icon, '📈');
      expect(ExpenseCategory.house.icon, '🏠');
    });

    test('IncomeCategory icons are correct', () {
      expect(IncomeCategory.salary.icon, '💼');
      expect(IncomeCategory.freelance.icon, '🖥️️');
      expect(IncomeCategory.investment.icon, '📈️');
      expect(IncomeCategory.gift.icon, '🎁️');
      expect(IncomeCategory.bonus.icon, '⭐️');
      expect(IncomeCategory.interest.icon, '🏛️️');
      expect(IncomeCategory.others.icon, '💰️');
    });
  });
}
