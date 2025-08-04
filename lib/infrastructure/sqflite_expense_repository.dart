import 'package:sqflite/sqflite.dart';

import '../domain/expense.dart';
import '../domain/expense_repository.dart';
import 'database_provider.dart';

class SqfliteExpenseRepository implements ExpenseRepository {
  final DatabaseProvider dbProvider;

  SqfliteExpenseRepository(this.dbProvider);

  Future<Database> get _db async => await dbProvider.database;

  @override
  Future<int> insert(Expense expense) async {
    final db = await _db;
    return db.insert('expenses', expense.toMap());
  }

  @override
  Future<List<Expense>> getAll() async {
    final db = await _db;
    final maps = await db.query('expenses', orderBy: 'createdAt DESC');
    return maps.map((e) => Expense.fromMap(e)).toList();
  }

  @override
  Future<Expense?> getById(int id) async {
    final db = await _db;
    final maps = await db.query('expenses', where: 'id = ?', whereArgs: [id]);
    return maps.isNotEmpty ? Expense.fromMap(maps.first) : null;
  }

  @override
  Future<int> update(Expense expense) async {
    final db = await _db;
    return db.update(
      'expenses',
      expense.toMap(),
      where: 'id = ?',
      whereArgs: [expense.id],
    );
  }

  @override
  Future<int> delete(int id) async {
    final db = await _db;
    return db.delete('expenses', where: 'id = ?', whereArgs: [id]);
  }
}
