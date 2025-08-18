import 'expense.dart';

abstract class ExpenseRepository {
  Future<int> insert(Expense expense);
  Future<List<Expense>> getLast();
  Future<Expense?> getById(int id);
  Future<int> update(Expense expense);
  Future<int> delete(int id);
  Future<void> deleteAll();
  Future<List<Expense>> getPaginated({required int limit, required int offset});
}
