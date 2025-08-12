import 'package:dukoin/domain/expense_repository.dart';
import 'package:dukoin/dukoin_app.dart';
import 'package:dukoin/infrastructure/database_provider.dart';
import 'package:dukoin/infrastructure/sqflite_expense_repository.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'domain/expense.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();

  final List<Expense> expenses = [
    Expense(
      id: 1,
      amount: 12.50,
      category: ExpenseCategory.food,
      description: "Lunch at Subway",
      createdAt: DateTime.now().subtract(const Duration(days: 1, hours: 3)),
    ),
    Expense(
      id: 2,
      amount: 45.00,
      category: ExpenseCategory.transport,
      description: "Monthly metro card",
      createdAt: DateTime.now().subtract(const Duration(days: 2, hours: 6)),
    ),
    Expense(
      id: 3,
      amount: 89.99,
      category: ExpenseCategory.shopping,
      description: "New running shoes",
      createdAt: DateTime.now().subtract(const Duration(days: 3, hours: 2)),
    ),
    Expense(
      id: 4,
      amount: 15.00,
      category: ExpenseCategory.entertainment,
      description: "Cinema tickets",
      createdAt: DateTime.now().subtract(const Duration(days: 4, hours: 5)),
    ),
    Expense(
      id: 5,
      amount: 65.30,
      category: ExpenseCategory.bills,
      description: "Electricity bill",
      createdAt: DateTime.now().subtract(const Duration(days: 5, hours: 8)),
    ),
    Expense(
      id: 6,
      amount: 25.00,
      category: ExpenseCategory.health,
      description: "Pharmacy purchase",
      createdAt: DateTime.now().subtract(const Duration(days: 6, hours: 1)),
    ),
    Expense(
      id: 7,
      amount: 120.00,
      category: ExpenseCategory.education,
      description: "Online course subscription",
      createdAt: DateTime.now().subtract(const Duration(days: 7, hours: 4)),
    ),
    Expense(
      id: 8,
      amount: 8.90,
      category: ExpenseCategory.others,
      description: "Gift wrapping",
      createdAt: DateTime.now().subtract(const Duration(days: 8, hours: 2)),
    ),
    Expense(
      id: 9,
      amount: 3.20,
      category: ExpenseCategory.food,
      description: "Morning coffee",
      createdAt: DateTime.now().subtract(const Duration(days: 1, hours: 1)),
    ),
    Expense(
      id: 10,
      amount: 22.75,
      category: ExpenseCategory.food,
      description: "Dinner at Italian restaurant",
      createdAt: DateTime.now().subtract(const Duration(days: 10, hours: 7)),
    ),
    Expense(
      id: 11,
      amount: 2.40,
      category: ExpenseCategory.transport,
      description: "Bus ticket",
      createdAt: DateTime.now().subtract(const Duration(days: 11, hours: 9)),
    ),
    Expense(
      id: 12,
      amount: 199.99,
      category: ExpenseCategory.shopping,
      description: "Bluetooth headphones",
      createdAt: DateTime.now().subtract(const Duration(days: 12, hours: 2)),
    ),
    Expense(
      id: 13,
      amount: 14.50,
      category: ExpenseCategory.entertainment,
      description: "Bowling night",
      createdAt: DateTime.now().subtract(const Duration(days: 13, hours: 6)),
    ),
    Expense(
      id: 14,
      amount: 72.10,
      category: ExpenseCategory.bills,
      description: "Water bill",
      createdAt: DateTime.now().subtract(const Duration(days: 14, hours: 4)),
    ),
    Expense(
      id: 15,
      amount: 55.00,
      category: ExpenseCategory.health,
      description: "Doctor appointment",
      createdAt: DateTime.now().subtract(const Duration(days: 15, hours: 5)),
    ),
    Expense(
      id: 16,
      amount: 30.00,
      category: ExpenseCategory.education,
      description: "Books for university",
      createdAt: DateTime.now().subtract(const Duration(days: 16, hours: 3)),
    ),
    Expense(
      id: 17,
      amount: 50.00,
      category: ExpenseCategory.others,
      description: "Charity donation",
      createdAt: DateTime.now().subtract(const Duration(days: 17, hours: 1)),
    ),
    Expense(
      id: 18,
      amount: 6.50,
      category: ExpenseCategory.food,
      description: "Bakery breakfast",
      createdAt: DateTime.now().subtract(const Duration(days: 18, hours: 7)),
    ),
    Expense(
      id: 19,
      amount: 90.00,
      category: ExpenseCategory.shopping,
      description: "Winter coat",
      createdAt: DateTime.now().subtract(const Duration(days: 20, hours: 8)),
    ),
    Expense(
      id: 20,
      amount: 18.00,
      category: ExpenseCategory.entertainment,
      description: "Museum entry",
      createdAt: DateTime.now().subtract(const Duration(days: 21, hours: 2)),
    ),
  ];
  final ExpenseRepository repo = SqfliteExpenseRepository(DatabaseProvider());

  await repo.deleteAll();
  for (int i = 0; i < expenses.length; i++) {
    await repo.insert(expenses[i]);
  }
  runApp(DukoinApp(prefs: prefs));
}
