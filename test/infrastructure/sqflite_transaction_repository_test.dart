import 'package:dukoin/domain/category.dart';
import 'package:dukoin/domain/transaction.dart';
import 'package:dukoin/infrastructure/database_provider.dart';
import 'package:dukoin/infrastructure/sqflite_transaction_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sqflite/sqflite.dart' show Database;

import 'sqflite_transaction_repository_test.mocks.dart';

@GenerateMocks([DatabaseProvider, Database])
void main() {
  group("SqfliteTransactionRepository", () {
    late MockDatabase mockDatabase;
    late MockDatabaseProvider mockDBProvider;
    late SqfliteTransactionRepository sut;
    final testExpense = Transaction(
      id: 1,
      description: 'Coffee',
      amount: 3.5,
      category: ExpenseCategory.food,
      createdAt: DateTime(2023, 1, 1),
    );
    final testIncome = Transaction(
      description: 'Nomina',
      amount: 10.5,
      category: IncomeCategory.salary,
      createdAt: DateTime(2023, 1, 1),
    );

    setUp(() {
      mockDatabase = MockDatabase();
      mockDBProvider = MockDatabaseProvider();
      when(mockDBProvider.database).thenAnswer((_) async => mockDatabase);

      sut = SqfliteTransactionRepository(mockDBProvider);
    });
    group("insert", () {
      test("insert should create a new Expense", () async {
        when(
          mockDatabase.insert('transactions', testExpense.toMap()),
        ).thenAnswer((_) async => 1);

        final id = await sut.insert(testExpense);

        expect(id, 1);
        verify(
          mockDatabase.insert('transactions', testExpense.toMap()),
        ).called(1);
      });
      test("insert should create a new Income", () async {
        when(
          mockDatabase.insert('transactions', testIncome.toMap()),
        ).thenAnswer((_) async => 1);

        final id = await sut.insert(testIncome);

        expect(id, 1);
        verify(
          mockDatabase.insert('transactions', testIncome.toMap()),
        ).called(1);
      });
    });
  });
}
