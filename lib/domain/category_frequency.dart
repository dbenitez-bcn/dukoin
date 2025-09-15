import 'package:dukoin/domain/category.dart';

class CategoryFrequency {
  final ExpenseCategory category;
  final double average;
  final int count;

  CategoryFrequency(this.category, this.average, this.count);

  factory CategoryFrequency.fromMap(Map<String, dynamic> map) {
    return CategoryFrequency(
      Category.fromString(map['category']) as ExpenseCategory,
      map["average"],
      map["count"],
    );
  }
}
