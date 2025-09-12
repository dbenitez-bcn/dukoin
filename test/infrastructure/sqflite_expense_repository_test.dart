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
    final testExpense = Expense(
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
        mockDatabase.query(
          'transactions',
          where: 'isExpense = 1',
          orderBy: 'createdAt DESC, id DESC',
          limit: 4,
        ),
      ).thenAnswer((_) async => []);

      var got = await sut.getLast();

      expect(got.length, 0);
      verify(
        mockDatabase.query(
          'transactions',
          where: 'isExpense = 1',
          orderBy: 'createdAt DESC, id DESC',
          limit: 4,
        ),
      ).called(1);
    });

    test("insert should call db.insert", () async {
      when(
        mockDatabase.insert('transactions', testExpense.toMap()),
      ).thenAnswer((_) async => 1);

      final id = await sut.insert(testExpense);

      expect(id, 1);
      verify(
        mockDatabase.insert('transactions', testExpense.toMap()),
      ).called(1);
    });

    test("getById should return testExpense when found", () async {
      when(
        mockDatabase.query('transactions', where: 'id = ?', whereArgs: [1]),
      ).thenAnswer((_) async => [testExpense.toMap()]);

      final result = await sut.getById(1);

      expect(result, isNotNull);
      expect(result!.id, testExpense.id);
      expect(result.description, testExpense.description);
    });

    test("getById should return null when not found", () async {
      when(
        mockDatabase.query('transactions', where: 'id = ?', whereArgs: [999]),
      ).thenAnswer((_) async => []);

      final result = await sut.getById(999);

      expect(result, isNull);
    });

    test("update should call db.update", () async {
      when(
        mockDatabase.update(
          'transactions',
          testExpense.toMap(),
          where: 'id = ?',
          whereArgs: [1],
        ),
      ).thenAnswer((_) async => 1);

      final count = await sut.update(testExpense);

      expect(count, 1);
      verify(
        mockDatabase.update(
          'transactions',
          testExpense.toMap(),
          where: 'id = ?',
          whereArgs: [1],
        ),
      ).called(1);
    });

    test("delete should call db.delete", () async {
      when(
        mockDatabase.delete('transactions', where: 'id = ?', whereArgs: [1]),
      ).thenAnswer((_) async => 1);

      final count = await sut.delete(1);

      expect(count, 1);
      verify(
        mockDatabase.delete('transactions', where: 'id = ?', whereArgs: [1]),
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

      when(mockTransaction.delete('transactions')).thenAnswer((_) async => 1);
      when(
        mockTransaction.delete(
          'sqlite_sequence',
          where: 'name = ?',
          whereArgs: ['transactions'],
        ),
      ).thenAnswer((_) async => 1);

      final sut = SqfliteExpenseRepository(mockDBProvider);
      await sut.deleteAll();

      verify(mockTransaction.delete('transactions')).called(1);
      verify(
        mockTransaction.delete(
          'sqlite_sequence',
          where: 'name = ?',
          whereArgs: ['transactions'],
        ),
      ).called(1);
    });
    group("getPaginated", () {
      test("It should fetch paginated data with limit and offset", () async {
        final now = DateTime.now();
        final mockMap1 = {
          'id': 1,
          'amount': 10.5,
          'category': ExpenseCategory.food.name,
          'description': 'Lunch',
          'createdAt': now.toIso8601String(),
        };
        final mockMap2 = {
          'id': 2,
          'amount': 20.0,
          'category': ExpenseCategory.transport.name,
          'description': 'Bus Ticket',
          'createdAt': now.subtract(const Duration(days: 1)).toIso8601String(),
        };

        when(
          mockDatabase.query(
            'transactions',
            where: 'isExpense = 1',
            orderBy: 'createdAt DESC, id DESC',
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
          'category': ExpenseCategory.entertainment.name,
          'description': 'Cinema',
          'createdAt': now.subtract(const Duration(days: 2)).toIso8601String(),
        };

        when(
          mockDatabase.query(
            'transactions',
            where: 'isExpense = 1',
            orderBy: 'createdAt DESC, id DESC',
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
            'transactions',
            where: 'isExpense = 1',
            orderBy: 'createdAt DESC, id DESC',
            limit: 2,
            offset: 10,
          ),
        ).thenAnswer((_) async => []);

        final got = await sut.getPaginated(limit: 2, offset: 10);

        expect(got, isEmpty);
      });
    });
    group("getTotalAmount", () {
      final end = DateTime.now();
      final start = end.subtract(Duration(days: 7));
      test(
        "it should return the transactions and the amount for the given date",
        () async {
          when(
            mockDatabase.rawQuery(any, [
              start.toIso8601String(),
              end.toIso8601String(),
            ]),
          ).thenAnswer(
            (_) async => [
              {'total': 1, 'amount': 102.23},
            ],
          );

          TotalAmountVM got = await sut.getTotalAmount(start: start, end: end);

          expect(got.amount, 102.23);
          expect(got.totalTransactions, 1);
        },
      );
      test(
        "it should return 0 transactions and 0.0 amount when no data is found",
        () async {
          when(
            mockDatabase.rawQuery(any, [
              start.toIso8601String(),
              end.toIso8601String(),
            ]),
          ).thenAnswer(
            (_) async => [
              {'total': 0, 'amount': 0.0},
            ],
          );

          TotalAmountVM got = await sut.getTotalAmount(start: start, end: end);

          expect(got.amount, 0.0);
          expect(got.totalTransactions, 0);
        },
      );
      test(
        "it should return 0 transactions and 0.0 amount when data is empty",
        () async {
          when(
            mockDatabase.rawQuery(any, [
              start.toIso8601String(),
              end.toIso8601String(),
            ]),
          ).thenAnswer((_) async => [{}]);

          TotalAmountVM got = await sut.getTotalAmount(start: start, end: end);

          expect(got.amount, 0.0);
          expect(got.totalTransactions, 0);
        },
      );
    });

    group("getOldestExpenseDate", () {
      test("If there is no last expense should return null", () {
        when(
          mockDatabase.query(
            'transactions',
            where: 'isExpense = 1',
            orderBy: 'createdAt ASC',
            limit: 1,
          ),
        ).thenAnswer((_) async => []);

        final got = sut.getOldestExpenseDate();

        expect(got, completion(isNull));
      });
      test("Given a expense should return the date", () {
        when(
          mockDatabase.query(
            'transactions',
            where: 'isExpense = 1',
            orderBy: 'createdAt ASC',
            limit: 1,
          ),
        ).thenAnswer((_) async => [testExpense.toMap()]);

        final got = sut.getOldestExpenseDate();

        expect(got, completion(testExpense.createdAt));
      });
    });

    group("getTopHighestExpenses", () {
      final start = DateTime(2023, 1, 1);
      final end = DateTime(2023, 1, 31);

      test("returns top 5 expenses by amount within date range", () async {
        final mockExpenses = List.generate(
          6,
          (i) => {
            'id': i + 1,
            'amount': 100.0 - i * 10,
            'category': ExpenseCategory.food.name,
            'description': 'Expense $i',
            'createdAt': DateTime(2023, 1, 10 + i).toIso8601String(),
          },
        );

        when(
          mockDatabase.query(
            'transactions',
            where: 'isExpense = 1 AND createdAt >= ? AND createdAt <= ?',
            whereArgs: [start.toIso8601String(), end.toIso8601String()],
            orderBy: 'amount DESC',
            limit: 5,
          ),
        ).thenAnswer((_) async => mockExpenses.take(5).toList());

        final got = await sut.getTopHighestExpenses(start: start, end: end);

        expect(got.length, 5);
        expect(got.first.amount, 100.0);
        expect(got.last.amount, 60.0);
        expect(
          got.every(
            (e) =>
                e.createdAt.isAfter(start.subtract(Duration(days: 1))) &&
                e.createdAt.isBefore(end.add(Duration(days: 1))),
          ),
          isTrue,
        );
      });

      test("returns empty list if no expenses in range", () async {
        when(
          mockDatabase.query(
            'transactions',
            where: 'isExpense = 1 AND createdAt >= ? AND createdAt <= ?',
            whereArgs: [start.toIso8601String(), end.toIso8601String()],
            orderBy: 'amount DESC',
            limit: 5,
          ),
        ).thenAnswer((_) async => []);

        final got = await sut.getTopHighestExpenses(start: start, end: end);

        expect(got, isEmpty);
      });

      test("Should filter by categories", () async {
        when(
          mockDatabase.query(
            'transactions',
            where:
                'isExpense = 1 AND createdAt >= ? AND createdAt <= ? AND category IN (?, ?)',
            whereArgs: [
              start.toIso8601String(),
              end.toIso8601String(),
              ExpenseCategory.food.name,
              ExpenseCategory.bills.name,
            ],
            orderBy: 'amount DESC',
            limit: 5,
          ),
        ).thenAnswer((_) async => []);

        final got = await sut.getTopHighestExpenses(
          start: start,
          end: end,
          categories: [ExpenseCategory.food, ExpenseCategory.bills],
        );

        expect(got, isEmpty);
      });
    });

    group("getTotalPerDay", () {
      test("should load allData", () async {
        final start = DateTime(2023, 1, 1);
        final end = DateTime(2023, 1, 7);
        final mockData = [
          {'date': '2023-01-01', 'total': 50.0},
          {'date': '2023-01-02', 'total': 30.0},
          {'date': '2023-01-03', 'total': 20.0},
        ];

        when(mockDatabase.rawQuery(any, any)).thenAnswer((_) async => mockData);

        final got = await sut.getTotalPerDay(start: start, end: end);

        expect(got.length, 3);
        expect(got[0].date, DateTime.parse('2023-01-01'));
        expect(got[0].total, 50.0);
        expect(got[1].date, DateTime.parse('2023-01-02'));
        expect(got[1].total, 30.0);
        expect(got[2].date, DateTime.parse('2023-01-03'));
        expect(got[2].total, 20.0);

        verify(
          mockDatabase.rawQuery(any, [
            start.toIso8601String(),
            end.toIso8601String(),
          ]),
        ).called(1);
      });

      test("should filter by categories", () async {
        final start = DateTime(2023, 1, 1);
        final end = DateTime(2023, 1, 7);
        final categories = [ExpenseCategory.food, ExpenseCategory.transport];
        final mockData = [
          {'date': '2023-01-01', 'total': 50.0},
          {'date': '2023-01-02', 'total': 30.0},
        ];

        when(mockDatabase.rawQuery(any, any)).thenAnswer((_) async => mockData);

        final got = await sut.getTotalPerDay(
          start: start,
          end: end,
          categories: categories,
        );

        expect(got.length, 2);
        expect(got[0].date, DateTime.parse('2023-01-01'));
        expect(got[0].total, 50.0);
        expect(got[1].date, DateTime.parse('2023-01-02'));
        expect(got[1].total, 30.0);

        verify(
          mockDatabase.rawQuery(any, [
            start.toIso8601String(),
            end.toIso8601String(),
            ...categories.map((c) => c.name),
          ]),
        ).called(1);
      });

      test("should return empty list when no data", () async {
        final start = DateTime(2023, 1, 1);
        final end = DateTime(2023, 1, 7);

        when(mockDatabase.rawQuery(any, any)).thenAnswer((_) async => []);

        final got = await sut.getTotalPerDay(start: start, end: end);

        expect(got, isEmpty);

        verify(mockDatabase.rawQuery(any, any)).called(1);
      });
    });

    group("getCategoriesDistribution", () {
      final start = DateTime(2023, 1, 1);
      final end = DateTime(2023, 1, 31);

      test("should return distribution grouped by category", () async {
        final mockData = [
          {'category': ExpenseCategory.food.name, 'value': 100.0},
          {'category': ExpenseCategory.transport.name, 'value': 50.0},
        ];

        when(
          mockDatabase.rawQuery(any, [
            start.toIso8601String(),
            end.toIso8601String(),
          ]),
        ).thenAnswer((_) async => mockData);

        final got = await sut.getCategoriesDistribution(start: start, end: end);

        expect(got.length, 2);
        expect(got[0].category, ExpenseCategory.food);
        expect(got[0].value, 100.0);
        expect(got[1].category, ExpenseCategory.transport);
        expect(got[1].value, 50.0);

        verify(
          mockDatabase.rawQuery(any, [
            start.toIso8601String(),
            end.toIso8601String(),
          ]),
        ).called(1);
      });

      test("should filter by categories", () async {
        final categories = [ExpenseCategory.food, ExpenseCategory.bills];
        final mockData = [
          {'category': ExpenseCategory.food.name, 'value': 75.0},
        ];

        when(
          mockDatabase.rawQuery(any, [
            start.toIso8601String(),
            end.toIso8601String(),
            ...categories.map((c) => c.name),
          ]),
        ).thenAnswer((_) async => mockData);

        final got = await sut.getCategoriesDistribution(
          start: start,
          end: end,
          categories: categories,
        );

        expect(got.length, 1);
        expect(got[0].category, ExpenseCategory.food);
        expect(got[0].value, 75.0);

        verify(
          mockDatabase.rawQuery(any, [
            start.toIso8601String(),
            end.toIso8601String(),
            ...categories.map((c) => c.name),
          ]),
        ).called(1);
      });

      test("should return empty list when no data", () async {
        when(
          mockDatabase.rawQuery(any, [
            start.toIso8601String(),
            end.toIso8601String(),
          ]),
        ).thenAnswer((_) async => []);

        final got = await sut.getCategoriesDistribution(start: start, end: end);

        expect(got, isEmpty);

        verify(
          mockDatabase.rawQuery(any, [
            start.toIso8601String(),
            end.toIso8601String(),
          ]),
        ).called(1);
      });
    });

    group("getCategoryFrequencies", () {
      final start = DateTime(2023, 1, 1);
      final end = DateTime(2023, 1, 31);

      test("should return frequencies grouped by category", () async {
        final mockData = [
          {'category': ExpenseCategory.food.name, 'average': 100.0, 'count': 4},
          {
            'category': ExpenseCategory.transport.name,
            'average': 50.0,
            'count': 2,
          },
        ];

        when(
          mockDatabase.rawQuery(any, [
            start.toIso8601String(),
            end.toIso8601String(),
          ]),
        ).thenAnswer((_) async => mockData);

        final got = await sut.getCategoryFrequencies(start: start, end: end);

        expect(got.length, 2);
        expect(got[0].category, ExpenseCategory.food);
        expect(got[0].average, 100.0);
        expect(got[0].count, 4);
        expect(got[1].category, ExpenseCategory.transport);
        expect(got[1].average, 50.0);
        expect(got[1].count, 2);

        verify(
          mockDatabase.rawQuery(any, [
            start.toIso8601String(),
            end.toIso8601String(),
          ]),
        ).called(1);
      });

      test("should filter by categories", () async {
        final categories = [ExpenseCategory.food, ExpenseCategory.bills];
        final mockData = [
          {'category': ExpenseCategory.food.name, 'average': 75.0, 'count': 10},
        ];

        when(
          mockDatabase.rawQuery(any, [
            start.toIso8601String(),
            end.toIso8601String(),
            ...categories.map((c) => c.name),
          ]),
        ).thenAnswer((_) async => mockData);

        final got = await sut.getCategoryFrequencies(
          start: start,
          end: end,
          categories: categories,
        );

        expect(got.length, 1);
        expect(got[0].category, ExpenseCategory.food);
        expect(got[0].average, 75.0);
        expect(got[0].count, 10);

        verify(
          mockDatabase.rawQuery(any, [
            start.toIso8601String(),
            end.toIso8601String(),
            ...categories.map((c) => c.name),
          ]),
        ).called(1);
      });

      test("should return empty list when no data", () async {
        when(
          mockDatabase.rawQuery(any, [
            start.toIso8601String(),
            end.toIso8601String(),
          ]),
        ).thenAnswer((_) async => []);

        final got = await sut.getCategoryFrequencies(start: start, end: end);

        expect(got, isEmpty);

        verify(
          mockDatabase.rawQuery(any, [
            start.toIso8601String(),
            end.toIso8601String(),
          ]),
        ).called(1);
      });
    });
  });
}
