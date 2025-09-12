import 'package:dukoin/domain/transaction.dart';

enum ExpenseCategory {
  food,
  transport,
  shopping,
  entertainment,
  health,
  bills,
  house,
  education,
  investments,
  travel,
  others,
}

class Expense extends Transaction {
  ExpenseCategory category;

  Expense({
    super.id,
    required super.amount,
    required this.category,
    required super.description,
    required super.createdAt,
  }) : super(isExpense: true);

  // Create from Map
  factory Expense.fromMap(Map<String, dynamic> map) {
    return Expense(
      id: map['id'],
      amount: map['amount'],
      category: getCategoryFromString(map['category']),
      description: map['description'],
      createdAt: DateTime.parse(map['createdAt']),
    );
  }

  @override
  Map<String, dynamic> toMap() {
    var map = super.toMap();
    map["category"] = category.name;
    return map;
  }
}

ExpenseCategory getCategoryFromString(String category) {
  return ExpenseCategory.values.firstWhere(
    (e) => e.name == category,
    orElse: () => ExpenseCategory.others,
  );
}
