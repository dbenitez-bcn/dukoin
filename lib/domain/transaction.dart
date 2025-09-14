import 'package:dukoin/domain/category.dart';

sealed class Transaction implements Comparable<Transaction> {
  int? id;
  double amount;
  String description;
  DateTime createdAt;

  Transaction({
    this.id,
    required this.amount,
    required this.description,
    required DateTime createdAt,
  }) : createdAt = DateTime(
         createdAt.year,
         createdAt.month,
         createdAt.day,
       ); // Normalize to date only

  // Convert to Map for DB
  Map<String, dynamic> toMap();

  @override
  int compareTo(Transaction obj) {
    return obj.createdAt.compareTo(createdAt);
  }
}

class Expense extends Transaction {
  Category category;

  Expense({
    super.id,
    required super.amount,
    required this.category,
    required super.description,
    required super.createdAt,
  });

  // Create from Map
  factory Expense.fromMap(Map<String, dynamic> map) {
    return Expense(
      id: map['id'],
      amount: map['amount'],
      category: Category.fromString(map['category'], isExpense: true),
      description: map['description'],
      createdAt: DateTime.parse(map['createdAt']),
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'amount': amount,
      'description': description,
      'isExpense': 1,
      'category': category.cName,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}

ExpenseCategory getCategoryFromString(String category) {
  return ExpenseCategory.values.firstWhere(
    (e) => e.name == category,
    orElse: () => ExpenseCategory.others,
  );
}

class Income extends Transaction {
  Category category;

  Income({
    super.id,
    required super.amount,
    required this.category,
    required super.description,
    required super.createdAt,
  });

  factory Income.fromMap(Map<String, dynamic> map) {
    return Income(
      id: map['id'],
      amount: map['amount'],
      category: Category.fromString(map['category'], isExpense: false),
      description: map['description'],
      createdAt: DateTime.parse(map['createdAt']),
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'amount': amount,
      'description': description,
      'isExpense': 0,
      'category': category.cName,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  static IncomeCategory getCategoryFromString(String category) {
    return IncomeCategory.values.firstWhere(
      (e) => e.name == category,
      orElse: () => IncomeCategory.others,
    );
  }
}
