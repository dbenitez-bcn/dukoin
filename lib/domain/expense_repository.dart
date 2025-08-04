import 'expense.dart';

abstract class ExpenseRepository {
  Future<int> insert(Expense expense);
  Future<List<Expense>> getAll();
  Future<Expense?> getById(int id);
  Future<int> update(Expense expense);
  Future<int> delete(int id);
}
