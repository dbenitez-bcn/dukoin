import 'package:dukoin/domain/category.dart';
import 'package:dukoin/domain/dukoin_flavor.dart';
import 'package:dukoin/domain/expense_repository.dart';
import 'package:dukoin/dukoin_app.dart';
import 'package:dukoin/main.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'domain/transaction.dart';
import 'domain/transaction_repository.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setup();
  final twoMonthAgo = DateTime.now().subtract(const Duration(days: 60));
  final List<Transaction> expenses = [
    Transaction(
      id: 1,
      amount: 12.50,
      category: ExpenseCategory.food,
      description: "Lunch at Subway",
      createdAt: DateTime.now().subtract(const Duration(days: 0, hours: 3)),
    ),
    Transaction(
      id: 2,
      amount: 45.00,
      category: ExpenseCategory.transport,
      description: "Monthly metro card",
      createdAt: DateTime.now().subtract(const Duration(days: 1, hours: 6)),
    ),
    Transaction(
      id: 3,
      amount: 89.99,
      category: ExpenseCategory.shopping,
      description: "New running shoes",
      createdAt: DateTime.now().subtract(const Duration(days: 2, hours: 2)),
    ),
    Transaction(
      id: 4,
      amount: 15.00,
      category: ExpenseCategory.entertainment,
      description: "Cinema tickets",
      createdAt: DateTime.now().subtract(const Duration(days: 3, hours: 5)),
    ),
    Transaction(
      id: 5,
      amount: 65.30,
      category: ExpenseCategory.bills,
      description: "Electricity bill",
      createdAt: DateTime.now().subtract(const Duration(days: 5, hours: 8)),
    ),
    Transaction(
      id: 6,
      amount: 25.00,
      category: ExpenseCategory.health,
      description: "Pharmacy purchase",
      createdAt: DateTime.now().subtract(const Duration(days: 6, hours: 1)),
    ),
    Transaction(
      id: 7,
      amount: 120.00,
      category: ExpenseCategory.education,
      description: "Online course subscription",
      createdAt: DateTime.now().subtract(const Duration(days: 7, hours: 4)),
    ),
    Transaction(
      id: 8,
      amount: 8.90,
      category: ExpenseCategory.others,
      description: "Gift wrapping",
      createdAt: DateTime.now().subtract(const Duration(days: 8, hours: 2)),
    ),
    Transaction(
      id: 9,
      amount: 3.20,
      category: ExpenseCategory.food,
      description: "Morning coffee",
      createdAt: DateTime.now().subtract(const Duration(days: 1, hours: 1)),
    ),
    Transaction(
      id: 10,
      amount: 22.75,
      category: ExpenseCategory.food,
      description: "Dinner at Italian restaurant",
      createdAt: DateTime.now().subtract(const Duration(days: 10, hours: 7)),
    ),
    Transaction(
      id: 11,
      amount: 2.40,
      category: ExpenseCategory.transport,
      description: "Bus ticket",
      createdAt: DateTime.now().subtract(const Duration(days: 11, hours: 9)),
    ),
    Transaction(
      id: 12,
      amount: 199.99,
      category: ExpenseCategory.shopping,
      description: "Bluetooth headphones",
      createdAt: DateTime.now().subtract(const Duration(days: 12, hours: 2)),
    ),
    Transaction(
      id: 13,
      amount: 14.50,
      category: ExpenseCategory.entertainment,
      description: "Bowling night",
      createdAt: DateTime.now().subtract(const Duration(days: 13, hours: 6)),
    ),
    Transaction(
      id: 14,
      amount: 72.10,
      category: ExpenseCategory.bills,
      description: "Water bill",
      createdAt: DateTime.now().subtract(const Duration(days: 14, hours: 4)),
    ),
    Transaction(
      id: 15,
      amount: 55.00,
      category: ExpenseCategory.health,
      description: "Doctor appointment",
      createdAt: DateTime.now().subtract(const Duration(days: 15, hours: 5)),
    ),
    Transaction(
      id: 16,
      amount: 30.00,
      category: ExpenseCategory.education,
      description: "Books for university",
      createdAt: DateTime.now().subtract(const Duration(days: 16, hours: 3)),
    ),
    Transaction(
      id: 17,
      amount: 50.00,
      category: ExpenseCategory.others,
      description: "Charity donation",
      createdAt: DateTime.now().subtract(const Duration(days: 17, hours: 1)),
    ),
    Transaction(
      id: 18,
      amount: 6.50,
      category: ExpenseCategory.food,
      description: "Bakery breakfast",
      createdAt: DateTime.now().subtract(const Duration(days: 18, hours: 7)),
    ),
    Transaction(
      id: 19,
      amount: 90.00,
      category: ExpenseCategory.shopping,
      description: "Winter coat",
      createdAt: DateTime.now().subtract(const Duration(days: 20, hours: 8)),
    ),
    Transaction(
      id: 20,
      amount: 18.00,
      category: ExpenseCategory.entertainment,
      description: "Museum entry",
      createdAt: DateTime.now().subtract(const Duration(days: 21, hours: 2)),
    ),
    Transaction(
      id: 21,
      amount: 7.50,
      category: ExpenseCategory.food,
      description: "Shawarma",
      createdAt: DateTime.now().subtract(const Duration(days: 41, hours: 2)),
    ),
    Transaction(
      id: 22,
      amount: 4.00,
      category: ExpenseCategory.transport,
      description: "Taxi ride",
      createdAt: DateTime(twoMonthAgo.year, twoMonthAgo.month, 1),
    ),
    Transaction(
      id: 23,
      amount: 150.00,
      category: ExpenseCategory.shopping,
      description: "Smartwatch",
      createdAt: DateTime(twoMonthAgo.year, twoMonthAgo.month, 5),
    ),
    Transaction(
      id: 24,
      amount: 20.00,
      category: ExpenseCategory.entertainment,
      description: "Concert ticket",
      createdAt: DateTime(twoMonthAgo.year, twoMonthAgo.month, 10),
    ),
    Transaction(
      id: 25,
      amount: 60.00,
      category: ExpenseCategory.bills,
      description: "Internet bill",
      createdAt: DateTime(twoMonthAgo.year, twoMonthAgo.month, 15),
    ),
    Transaction(
      id: 26,
      amount: 40.00,
      category: ExpenseCategory.health,
      description: "Gym membership",
      createdAt: DateTime(twoMonthAgo.year, twoMonthAgo.month, 20),
    ),
    Transaction(
      id: 27,
      amount: 80.00,
      category: ExpenseCategory.education,
      description: "Workshop fee",
      createdAt: DateTime(twoMonthAgo.year, twoMonthAgo.month, 25),
    ),
    Transaction(
      id: 28,
      amount: 12.00,
      category: ExpenseCategory.others,
      description: "Stationery",
      createdAt: DateTime(twoMonthAgo.year, twoMonthAgo.month, 28),
    ),
    Transaction(
      id: 29,
      amount: 7.00,
      category: ExpenseCategory.transport,
      description: "Taxi ride",
      createdAt: DateTime(twoMonthAgo.year, twoMonthAgo.month - 1, 1),
    ),
    Transaction(
      id: 30,
      amount: 10.00,
      category: ExpenseCategory.shopping,
      description: "Smartwatch",
      createdAt: DateTime(twoMonthAgo.year, twoMonthAgo.month - 1, 2),
    ),
    Transaction(
      id: 31,
      amount: 240.00,
      category: ExpenseCategory.entertainment,
      description: "Concert ticket",
      createdAt: DateTime(twoMonthAgo.year, twoMonthAgo.month - 1, 10),
    ),
    Transaction(
      id: 32,
      amount: 65.00,
      category: ExpenseCategory.bills,
      description: "Internet bill",
      createdAt: DateTime(twoMonthAgo.year, twoMonthAgo.month - 1, 13),
    ),
    Transaction(
      id: 33,
      amount: 42.00,
      category: ExpenseCategory.health,
      description: "Gym membership",
      createdAt: DateTime(twoMonthAgo.year, twoMonthAgo.month - 1, 20),
    ),
    Transaction(
      id: 34,
      amount: 23.00,
      category: ExpenseCategory.education,
      description: "Workshop fee",
      createdAt: DateTime(twoMonthAgo.year, twoMonthAgo.month - 1, 22),
    ),
    Transaction(
      id: 35,
      amount: 145.00,
      category: ExpenseCategory.others,
      description: "Stationery",
      createdAt: DateTime(twoMonthAgo.year, twoMonthAgo.month - 1, 31),
    ),
  ];

  final ExpenseRepository repo = GetIt.I<ExpenseRepository>();
  final TransactionRepository transactionRepo =
      GetIt.I<TransactionRepository>();

  await repo.deleteAll();
  var income = Transaction(
    amount: 12.50,
    category: IncomeCategory.salary,
    description: "Nomina",
    createdAt: DateTime.now().subtract(const Duration(days: 0, hours: 3)),
  );
  for (int i = 0; i < expenses.length; i++) {
    await transactionRepo.insert(expenses[i]);
  }
  transactionRepo.insert(income);

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(false);
  FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(false);
  DukoinFlavors.dev();
  runApp(DukoinApp());
}
