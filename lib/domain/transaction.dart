import 'package:dukoin/domain/category.dart';

class Transaction implements Comparable<Transaction> {
  int? id;
  double amount;
  String description;
  Category category;
  DateTime createdAt;

  Transaction({
    this.id,
    required this.amount,
    required this.description,
    required this.category,
    required DateTime createdAt,
  }) : createdAt = DateTime(
         createdAt.year,
         createdAt.month,
         createdAt.day,
       ); // Normalize to date only

  // Convert to Map for DB
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'amount': amount,
      'description': description,
      'isExpense': category is ExpenseCategory ? 1 : 0,
      'category': category.cName,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory Transaction.fromMap(Map<String, dynamic> map) {
    return Transaction(
      id: map['id'],
      amount: map['amount'],
      category: Category.fromString(
        map['category'],
        isExpense: map['isExpense'] == 0 ? false : true,
      ),
      description: map['description'],
      createdAt: DateTime.parse(map['createdAt']),
    );
  }

  @override
  int compareTo(Transaction obj) {
    return obj.createdAt.compareTo(createdAt);
  }
}
