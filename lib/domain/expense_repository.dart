import 'package:dukoin/domain/total_amount_vm.dart';
import 'package:dukoin/domain/total_per_day_dto.dart';
import 'expense.dart';

abstract class ExpenseRepository {
  Future<int> insert(Expense expense);

  Future<List<Expense>> getLast();

  Future<Expense?> getById(int id);

  Future<int> update(Expense expense);

  Future<int> delete(int id);

  Future<void> deleteAll();

  Future<List<Expense>> getPaginated({required int limit, required int offset});

  Future<TotalAmountVM> getTotalAmount({
    required DateTime start,
    required DateTime end,
    List<ExpenseCategory>? categories,
  });

  Future<DateTime?> getOldestExpenseDate();

  Future<List<Expense>> getTopFiveExpenses({required DateTime start, required DateTime end});

  Future<List<TotalPerDayDTO>> getTotalPerDay({
    required DateTime start,
    required DateTime end,
    List<ExpenseCategory>? categories,
  });
}
