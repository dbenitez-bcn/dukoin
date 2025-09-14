import 'package:dukoin/domain/category.dart';
import 'package:dukoin/domain/category_frequency.dart';
import 'package:dukoin/domain/expense_repository.dart';
import 'package:dukoin/domain/total_amount_vm.dart';
import 'package:dukoin/domain/total_per_category_dto.dart';
import 'package:dukoin/domain/total_per_day_dto.dart';
import 'package:dukoin/domain/transaction.dart';
import 'package:sqflite/sqflite.dart';

import 'database_provider.dart';

class SqfliteExpenseRepository implements ExpenseRepository {
  final DatabaseProvider dbProvider;

  SqfliteExpenseRepository(this.dbProvider);

  Future<Database> get _db async => await dbProvider.database;

  @override
  Future<List<Expense>> getLast() async {
    final db = await _db;
    final maps = await db.query(
      'transactions',
      where: "isExpense = 1",
      orderBy: 'createdAt DESC, id DESC',
      limit: 4,
    );
    return maps.map((e) => Expense.fromMap(e)).toList();
  }

  @override
  Future<Expense?> getById(int id) async {
    final db = await _db;
    final maps = await db.query(
      'transactions',
      where: 'id = ?',
      whereArgs: [id],
    );
    return maps.isNotEmpty ? Expense.fromMap(maps.first) : null;
  }

  @override
  Future<int> update(Expense expense) async {
    if (expense.id == null) {
      throw ArgumentError('Cannot update an expense without an ID');
    }
    final db = await _db;
    return db.update(
      'transactions',
      expense.toMap(),
      where: 'id = ?',
      whereArgs: [expense.id],
    );
  }

  @override
  Future<int> delete(int id) async {
    final db = await _db;
    return db.delete('transactions', where: 'id = ?', whereArgs: [id]);
  }

  @override
  Future<void> deleteAll() async {
    final db = await _db;
    await db.transaction((txn) async {
      await txn.delete('transactions');
      await txn.delete(
        'sqlite_sequence',
        where: 'name = ?',
        whereArgs: ['transactions'],
      );
    });
  }

  @override
  Future<List<Expense>> getPaginated({
    required int limit,
    required int offset,
  }) async {
    final db = await _db;
    final maps = await db.query(
      'transactions',
      where: 'isExpense = 1',
      orderBy: 'createdAt DESC, id DESC',
      limit: limit,
      offset: offset,
    );
    return maps.map((e) => Expense.fromMap(e)).toList();
  }

  @override
  Future<TotalAmountVM> getTotalAmount({
    required DateTime start,
    required DateTime end,
    List<ExpenseCategory>? categories,
  }) async {
    final db = await _db;
    final args = [start.toIso8601String(), end.toIso8601String()];
    String where = 'isExpense = 1 AND createdAt >= ? AND createdAt <= ?';

    if (categories != null && categories.isNotEmpty) {
      final placeholders = List.filled(categories.length, '?').join(', ');
      where += ' AND category IN ($placeholders)';
      args.addAll(categories.map((c) => c.name));
    }

    final result = await db.rawQuery('''
    SELECT COUNT(*) as total, SUM(amount) as amount
    FROM transactions
    WHERE $where
    ''', args);

    final row = result.first;
    final amount = row['amount'] != null
        ? (row['amount'] as num).toDouble()
        : 0.0;
    final totalTransactions = row['total'] != null ? row['total'] as int : 0;

    return TotalAmountVM(amount, totalTransactions);
  }

  @override
  Future<DateTime?> getOldestExpenseDate() async {
    final db = await _db;
    final results = await db.query(
      'transactions',
      where: 'isExpense = 1',
      orderBy: 'createdAt ASC',
      limit: 1,
    );
    if (results.isEmpty) {
      return null;
    } else {
      final oldestExpense = Expense.fromMap(results.first);
      return oldestExpense.createdAt;
    }
  }

  @override
  Future<List<Expense>> getTopHighestExpenses({
    required DateTime start,
    required DateTime end,
    List<ExpenseCategory>? categories,
  }) async {
    final db = await _db;
    final args = [start.toIso8601String(), end.toIso8601String()];
    String where = 'isExpense = 1 AND createdAt >= ? AND createdAt <= ?';

    if (categories != null && categories.isNotEmpty) {
      final placeholders = List.filled(categories.length, '?').join(', ');
      where += ' AND category IN ($placeholders)';
      args.addAll(categories.map((c) => c.name));
    }

    final maps = await db.query(
      'transactions',
      where: where,
      whereArgs: args,
      orderBy: 'amount DESC',
      limit: 5,
    );
    return maps.map((e) => Expense.fromMap(e)).toList();
  }

  @override
  Future<List<TotalPerDayDTO>> getTotalPerDay({
    required DateTime start,
    required DateTime end,
    List<ExpenseCategory>? categories,
  }) async {
    final db = await _db;
    final args = [start.toIso8601String(), end.toIso8601String()];
    String where = 'isExpense = 1 AND createdAt >= ? AND createdAt <= ?';

    if (categories != null && categories.isNotEmpty) {
      final placeholders = List.filled(categories.length, '?').join(', ');
      where += ' AND category IN ($placeholders)';
      args.addAll(categories.map((c) => c.name));
    }

    final result = await db.rawQuery('''
    SELECT DATE(createdAt) as date, SUM(amount) as total
    FROM transactions
    WHERE $where
    GROUP BY DATE(createdAt)
    ORDER BY DATE(createdAt) ASC
    ''', args);

    return result.map((e) => TotalPerDayDTO.fromJson(e)).toList();
  }

  @override
  Future<List<TotalPerCategoryDTO>> getCategoriesDistribution({
    required DateTime start,
    required DateTime end,
    List<ExpenseCategory>? categories,
  }) async {
    final db = await _db;
    final args = [start.toIso8601String(), end.toIso8601String()];
    String where = 'isExpense = 1 AND createdAt >= ? AND createdAt <= ?';

    if (categories != null && categories.isNotEmpty) {
      final placeholders = List.filled(categories.length, '?').join(', ');
      where += ' AND category IN ($placeholders)';
      args.addAll(categories.map((c) => c.name));
    }

    final result = await db.rawQuery('''
    SELECT category as category, SUM(amount) as value
    FROM transactions
    WHERE $where
    GROUP BY category
    ORDER BY value DESC
    ''', args);

    return result.map((e) => TotalPerCategoryDTO.fromMap(e)).toList();
  }

  @override
  Future<List<CategoryFrequency>> getCategoryFrequencies({
    required DateTime start,
    required DateTime end,
    List<ExpenseCategory>? categories,
  }) async {
    final db = await _db;
    final args = [start.toIso8601String(), end.toIso8601String()];
    String where = 'isExpense = 1 AND createdAt >= ? AND createdAt <= ?';

    if (categories != null && categories.isNotEmpty) {
      final placeholders = List.filled(categories.length, '?').join(', ');
      where += ' AND category IN ($placeholders)';
      args.addAll(categories.map((c) => c.name));
    }

    final result = await db.rawQuery('''
    SELECT category, AVG(amount) as average, COUNT(*) as count
    FROM transactions
    WHERE $where
    GROUP BY category
    ORDER BY count DESC, average DESC
    LIMIT 3
    ''', args);

    return result.map((e) => CategoryFrequency.fromMap(e)).toList();
  }
}
