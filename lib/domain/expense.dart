enum ExpenseCategory { //TODO: move others to down.
  others,
  travel,
  investments,
  insurance,
  subscriptions,
  pets,
  personalCare,
  house,
  education,
  health,
  bills,
  entertainment,
  shopping,
  transport,
  food,
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
  }) : createdAt = DateTime(createdAt.year, createdAt.month, createdAt.day); // Normalize to date only

  // Convert to Map for DB
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'amount': amount,
      'category': category.index, // TODO: Store enum as string
      'description': description,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  // Create from Map
  factory Expense.fromMap(Map<String, dynamic> map) {
    return Expense(
      id: map['id'],
      amount: map['amount'],
      category: ExpenseCategory.values[map['category']], // TODO: Load enum as string
      description: map['description'],
      createdAt: DateTime.parse(map['createdAt']),
    );
  }

  @override
  int compareTo(Expense obj) {
    return obj.createdAt.compareTo(createdAt);
  }
}
