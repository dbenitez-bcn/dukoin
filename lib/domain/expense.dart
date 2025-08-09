enum ExpenseCategory {
  food,
  transport,
  shopping,
  entertainment,
  bills,
  health,
  education,
  others,
}

class Expense implements Comparable<Expense>{
  int? id;
  double amount;
  ExpenseCategory category;
  String description;
  DateTime createdAt;

  Expense({
    this.id,
    required this.amount,
    required this.category,
    required this.description,
    required this.createdAt,
  });

  // Convert to Map for DB
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'amount': amount,
      'category': category.index,
      'description': description,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  // Create from Map
  factory Expense.fromMap(Map<String, dynamic> map) {
    return Expense(
      id: map['id'],
      amount: map['amount'],
      category: ExpenseCategory.values[map['category']],
      description: map['description'],
      createdAt: DateTime.parse(map['createdAt']),
    );
  }

  @override
  int compareTo(Expense obj) {
    return obj.createdAt.compareTo(createdAt);
  }
}
