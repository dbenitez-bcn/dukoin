import 'package:dukoin/domain/transaction.dart';

enum IncomeCategory {
  salary,
  freelance,
  investment,
  gift,
  bonus,
  interest,
  others,
}

class Income extends Transaction {
  IncomeCategory category;

  Income({
    super.id,
    required super.amount,
    required this.category,
    required super.description,
    required super.createdAt,
  }) : super(isExpense: false);

  factory Income.fromMap(Map<String, dynamic> map) {
    return Income(
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

IncomeCategory getCategoryFromString(String category) {
  return IncomeCategory.values.firstWhere(
    (e) => e.name == category,
    orElse: () => IncomeCategory.others,
  );
}
