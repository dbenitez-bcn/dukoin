import 'package:dukoin/domain/category_frequency.dart';
import 'package:dukoin/domain/total_amount_vm.dart';
import 'package:dukoin/domain/total_per_category_dto.dart';
import 'package:dukoin/domain/total_per_day_dto.dart';

import 'transaction.dart';

abstract class ExpenseRepository {
  Future<int> insert(
    Expense expense,
  ); // TODO: Extract to transaction repository

  Future<List<Expense>> getLast(); // TODO: Extract to transaction repository

  Future<Expense?> getById(int id);

  Future<int> update(Expense expense);

  Future<int> delete(int id); // TODO: Extract to transaction repository

  Future<void> deleteAll();

  Future<List<Expense>> getPaginated({
    required int limit,
    required int offset,
  }); // TODO: Extract to transaction repository

  Future<TotalAmountVM> getTotalAmount({
    required DateTime start,
    required DateTime end,
    List<ExpenseCategory>? categories,
  });

  Future<DateTime?> getOldestExpenseDate();

  Future<List<Expense>> getTopHighestExpenses({
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
