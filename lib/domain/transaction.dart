class Transaction implements Comparable<Transaction> {
  int? id;
  double amount;
  String description;
  DateTime createdAt;
  bool isExpense;

  Transaction({
    this.id,
    required this.amount,
    required this.description,
    required this.isExpense,
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
      'isExpense': isExpense ? 1 : 0,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  @override
  int compareTo(Transaction obj) {
    return obj.createdAt.compareTo(createdAt);
  }
}
