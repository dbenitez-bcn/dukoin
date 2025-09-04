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

class Expense implements Comparable<Expense> {
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
      'category': category.name,
      'description': description,
      'createdAt': createdAt.toIso8601String(),
    };
  }

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
  int compareTo(Expense obj) {
    return obj.createdAt.compareTo(createdAt);
  }
}

ExpenseCategory getCategoryFromString(String category) {
  return ExpenseCategory.values.firstWhere(
    (e) => e.name == category,
    orElse: () => ExpenseCategory.others,
  );
}
