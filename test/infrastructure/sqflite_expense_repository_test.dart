import 'package:dukoin/domain/expense.dart';
import 'package:dukoin/domain/total_amount_vm.dart';
import 'package:dukoin/infrastructure/database_provider.dart';
import 'package:dukoin/infrastructure/sqflite_expense_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sqflite/sqflite.dart';

import 'sqflite_expense_repository_test.mocks.dart';

@GenerateMocks([DatabaseProvider, Database, Transaction])
void main() {
  group('SqfliteExpenseRepository', () {
    late MockDatabase mockDatabase;
    late MockDatabaseProvider mockDBProvider;
    late SqfliteExpenseRepository sut;
    final testExpenses = Expense(
      id: 1,
      description: 'Coffee',
      amount: 3.5,
      category: ExpenseCategory.food,
      createdAt: DateTime(2023, 1, 1),
    );

    setUp(() {
      mockDatabase = MockDatabase();
      mockDBProvider = MockDatabaseProvider();
      when(mockDBProvider.database).thenAnswer((_) async => mockDatabase);

      sut = SqfliteExpenseRepository(mockDBProvider);
    });

    test("getLast should fetch all data", () async {
      when(
        mockDatabase.query('expenses', orderBy: 'createdAt DESC', limit: 4),
      ).thenAnswer((_) async => []);

      var got = await sut.getLast();

      expect(got.length, 0);
      verify(
        mockDatabase.query('expenses', orderBy: 'createdAt DESC', limit: 4),
      ).called(1);
    });

    test("insert should call db.insert", () async {
      when(
        mockDatabase.insert('expenses', testExpenses.toMap()),
      ).thenAnswer((_) async => 1);

      final id = await sut.insert(testExpenses);

      expect(id, 1);
      verify(mockDatabase.insert('expenses', testExpenses.toMap())).called(1);
    });

    test("getById should return testExpenses when found", () async {
      when(
        mockDatabase.query('expenses', where: 'id = ?', whereArgs: [1]),
      ).thenAnswer((_) async => [testExpenses.toMap()]);

      final result = await sut.getById(1);

      expect(result, isNotNull);
      expect(result!.id, testExpenses.id);
      expect(result.description, testExpenses.description);
    });

    test("getById should return null when not found", () async {
      when(
        mockDatabase.query('expenses', where: 'id = ?', whereArgs: [999]),
      ).thenAnswer((_) async => []);

      final result = await sut.getById(999);

      expect(result, isNull);
    });

    test("update should call db.update", () async {
      when(
        mockDatabase.update(
          'expenses',
          testExpenses.toMap(),
          where: 'id = ?',
          whereArgs: [1],
        ),
      ).thenAnswer((_) async => 1);

      final count = await sut.update(testExpenses);

      expect(count, 1);
      verify(
        mockDatabase.update(
          'expenses',
          testExpenses.toMap(),
          where: 'id = ?',
          whereArgs: [1],
        ),
      ).called(1);
    });

    test("delete should call db.delete", () async {
      when(
        mockDatabase.delete('expenses', where: 'id = ?', whereArgs: [1]),
      ).thenAnswer((_) async => 1);

      final count = await sut.delete(1);

      expect(count, 1);
      verify(
        mockDatabase.delete('expenses', where: 'id = ?', whereArgs: [1]),
      ).called(1);
    });

    test("deleteAll should clear expenses and reset sequence", () async {
      final mockDatabase = MockDatabase();
      final mockDBProvider = MockDatabaseProvider();
      final mockTransaction = MockTransaction();

      when(mockDBProvider.database).thenAnswer((_) async => mockDatabase);

      // simulate transaction behavior
      when(mockDatabase.transaction(any)).thenAnswer((invocation) async {
        final txnFn =
            invocation.positionalArguments[0]
                as Future<void> Function(Transaction txn);
        await txnFn(mockTransaction);
        return null;
      });

      when(mockTransaction.delete('expenses')).thenAnswer((_) async => 1);
      when(
        mockTransaction.delete(
          'sqlite_sequence',
          where: 'name = ?',
          whereArgs: ['expenses'],
        ),
      ).thenAnswer((_) async => 1);

      final sut = SqfliteExpenseRepository(mockDBProvider);
      await sut.deleteAll();

      verify(mockTransaction.delete('expenses')).called(1);
      verify(
        mockTransaction.delete(
          'sqlite_sequence',
          where: 'name = ?',
          whereArgs: ['expenses'],
        ),
      ).called(1);
    });
    group("getPaginated", () {
      test("It should fetch paginated data with limit and offset", () async {
        final now = DateTime.now();
        final mockMap1 = {
          'id': 1,
          'amount': 10.5,
          'category': ExpenseCategory.food.index,
          'description': 'Lunch',
          'createdAt': now.toIso8601String(),
        };
        final mockMap2 = {
          'id': 2,
          'amount': 20.0,
          'category': ExpenseCategory.transport.index,
          'description': 'Bus Ticket',
          'createdAt': now.subtract(const Duration(days: 1)).toIso8601String(),
        };

        when(
          mockDatabase.query(
            'expenses',
            orderBy: 'createdAt DESC',
            limit: 2,
            offset: 0,
          ),
        ).thenAnswer((_) async => [mockMap1, mockMap2]);

        final got = await sut.getPaginated(limit: 2, offset: 0);

        expect(got.length, 2);
        expect(got.first, isA<Expense>());
        expect(got.first.description, equals('Lunch'));
        expect(got.first.category, ExpenseCategory.food);
      });

      test("It should fetch next page of data", () async {
        final now = DateTime.now();
        final mockMap3 = {
          'id': 3,
          'amount': 30.0,
          'category': ExpenseCategory.entertainment.index,
          'description': 'Cinema',
          'createdAt': now.subtract(const Duration(days: 2)).toIso8601String(),
        };

        when(
          mockDatabase.query(
            'expenses',
            orderBy: 'createdAt DESC',
            limit: 1,
            offset: 2,
          ),
        ).thenAnswer((_) async => [mockMap3]);

        final got = await sut.getPaginated(limit: 1, offset: 2);

        expect(got.length, 1);
        expect(got.first.description, equals('Cinema'));
        expect(got.first.category, ExpenseCategory.entertainment);
      });

      test("It should return empty list when no more data", () async {
        when(
          mockDatabase.query(
            'expenses',
            orderBy: 'createdAt DESC',
            limit: 2,
            offset: 10,
          ),
        ).thenAnswer((_) async => []);

        final got = await sut.getPaginated(limit: 2, offset: 10);

        expect(got, isEmpty);
      });
    });
    group("getTotalAmount", () {
      test(
        "it should return the transactions and the amount for the given date",
        () async {
          final date = DateTime.now();
          when(mockDatabase.rawQuery(any, [date.toIso8601String()])).thenAnswer(
            (_) async => [
              {'total': 1, 'amount': 102.23},
            ],
          );

          TotalAmountVM got = await sut.getTotalAmount(date: date);

          expect(got.amount, 102.23);
          expect(got.totalTransactions, 1);
        },
      );
      test(
        "it should return 0 transactions and 0.0 amount when no data is found",
        () async {
          final date = DateTime.now();
          when(mockDatabase.rawQuery(any, [date.toIso8601String()])).thenAnswer(
            (_) async => [
              {'total': 0, 'amount': 0.0},
            ],
          );

          TotalAmountVM got = await sut.getTotalAmount(date: date);

          expect(got.amount, 0.0);
          expect(got.totalTransactions, 0);
        },
      );
      test(
        "it should return 0 transactions and 0.0 amount when data is empty",
        () async {
          final date = DateTime.now();
          when(
            mockDatabase.rawQuery(any, [date.toIso8601String()]),
          ).thenAnswer((_) async => [{}]);

          TotalAmountVM got = await sut.getTotalAmount(date: date);

          expect(got.amount, 0.0);
          expect(got.totalTransactions, 0);
        },
      );
    });
  });
}
