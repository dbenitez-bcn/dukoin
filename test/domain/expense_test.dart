import 'package:dukoin/domain/expense.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("Expense", () {
    final now = DateTime.now();
    group("fromMap", () {
      test("It should create an Expense from a map", () {
        Map<String, dynamic> map = {
          "id": 1,
          "amount": 2.3,
          "category": ExpenseCategory.food.name,
          "description": "Title",
          "createdAt": now.toIso8601String(),
        };

        Expense sut = Expense.fromMap(map);

        expect(sut.id, 1);
        expect(sut.description, "Title");
        expect(sut.amount, 2.3);
        expect(sut.category, ExpenseCategory.food);
        expect(sut.createdAt, DateTime(now.year, now.month, now.day));
      });
    });
    group("toMap", () {
      test("It should create a map from an Expense", () {
        Map<String, dynamic> expected = {
          "id": 1,
          "amount": 2.3,
          "category": ExpenseCategory.food.name,
          "description": "Title",
          "createdAt": DateTime(now.year, now.month, now.day).toIso8601String(),
        };

        Expense sut = Expense(
          id: 1,
          amount: 2.3,
          category: ExpenseCategory.food,
          description: "Title",
          createdAt: now,
        );

        expect(sut.toMap(), expected);
      });
    });
  });
}
