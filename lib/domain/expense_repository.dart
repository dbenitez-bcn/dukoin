import 'package:dukoin/domain/category.dart';
import 'package:dukoin/domain/category_frequency.dart';
import 'package:dukoin/domain/total_amount_vm.dart';
import 'package:dukoin/domain/total_per_category_dto.dart';
import 'package:dukoin/domain/total_per_day_dto.dart';

import 'transaction.dart';

abstract class ExpenseRepository {
  Future<int> insert(Transaction transaction);

  Future<List<Transaction>> getLast();

  Future<Transaction?> getById(int id);

  Future<int> update(Transaction expense);

  Future<int> delete(int id);

  Future<void> deleteAll();

  Future<List<Transaction>> getPaginated({
    required int limit,
    required int offset,
  });

  Future<TotalAmountVM> getTotalAmount({
    required DateTime start,
    required DateTime end,
    List<ExpenseCategory>? categories,
  });

  Future<DateTime?> getOldestExpenseDate();

  Future<List<Transaction>> getTopHighestExpenses({
    required DateTime start,
    required DateTime end,
    List<ExpenseCategory>? categories,
  });

  Future<List<TotalPerDayDTO>> getTotalPerDay({
    required DateTime start,
    required DateTime end,
    List<ExpenseCategory>? categories,
  });

  Future<List<TotalPerCategoryDTO>> getCategoriesDistribution({
    required DateTime start,
    required DateTime end,
    List<ExpenseCategory>? categories,
  });

  Future<List<CategoryFrequency>> getCategoryFrequencies({
    required DateTime start,
    required DateTime end,
    List<ExpenseCategory>? categories,
  });
}
