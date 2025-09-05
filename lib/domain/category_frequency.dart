import 'package:dukoin/domain/expense.dart';

class CategoryFrequency {
  final ExpenseCategory category;
  final double average;
  final int count;

  CategoryFrequency(this.category, this.average, this.count);

  factory CategoryFrequency.fromMap(Map<String, dynamic> map) {
    return CategoryFrequency(
      getCategoryFromString(map['category']),
      map["average"],
      map["count"],
    );
  }
}
