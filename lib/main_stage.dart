import 'package:dukoin/domain/expense_repository.dart';
import 'package:dukoin/dukoin_app.dart';
import 'package:dukoin/infrastructure/database_provider.dart';
import 'package:dukoin/infrastructure/sqflite_expense_repository.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> setup() async {
  final getIt = GetIt.instance;
  DatabaseProvider databaseProvider = DatabaseProvider();
  getIt.registerSingleton<DatabaseProvider>(databaseProvider);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(prefs);
  SqfliteExpenseRepository sqfliteExpenseRepository = SqfliteExpenseRepository(
    getIt<DatabaseProvider>(),
  );
  getIt.registerSingleton<ExpenseRepository>(sqfliteExpenseRepository);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setup();
  runApp(DukoinApp());
}
