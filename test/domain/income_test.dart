import 'package:dukoin/domain/transaction.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("Income", () {
    final now = DateTime.now();
    group("fromMap", () {
      test("It should create an Expense from a map", () {
        Map<String, dynamic> map = {
          "id": 1,
          "amount": 2.3,
          "category": IncomeCategory.salary.name,
          "description": "Title",
          "createdAt": now.toIso8601String(),
        };

        Income sut = Income.fromMap(map);

        expect(sut.id, 1);
        expect(sut.description, "Title");
        expect(sut.amount, 2.3);
        expect(sut.category, IncomeCategory.salary);
        expect(sut.createdAt, DateTime(now.year, now.month, now.day));
      });
    });
    group("toMap", () {
      test("It should create a map from an Income", () {
        Map<String, dynamic> expected = {
          "id": 1,
          "amount": 2.3,
          "category": IncomeCategory.salary.name,
          "description": "Title",
          "isExpense": 0,
          "createdAt": DateTime(now.year, now.month, now.day).toIso8601String(),
        };

        Income sut = Income(
          id: 1,
          amount: 2.3,
          category: IncomeCategory.salary,
          description: "Title",
          createdAt: now,
        );

        expect(sut.toMap(), expected);
      });
    });
  });
}
