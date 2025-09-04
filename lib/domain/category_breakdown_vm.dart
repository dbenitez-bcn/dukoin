import 'package:dukoin/domain/expense.dart';

class CategoryBreakdownVM {
  List<CategoryBreakdownData> data;

  CategoryBreakdownVM(this.data);
}

class CategoryBreakdownData {
  final ExpenseCategory category;
  final double value;
  final double percentage;

  CategoryBreakdownData(this.category, this.value, this.percentage);
}
