import 'expense.dart';

abstract class IncomeRepository {
  Future<int> insert(Income expense);
}
