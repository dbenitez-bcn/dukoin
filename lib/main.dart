import 'dart:ui';

import 'package:dukoin/domain/dukoin_flavor.dart';
import 'package:dukoin/domain/expense_repository.dart';
import 'package:dukoin/domain/transaction_repository.dart';
import 'package:dukoin/dukoin_app.dart';
import 'package:dukoin/infrastructure/database_provider.dart';
import 'package:dukoin/infrastructure/sqflite_expense_repository.dart';
import 'package:dukoin/infrastructure/sqflite_transaction_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'firebase_options.dart';

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
  SqfliteTransactionRepository sqfliteTransactionRepository =
      SqfliteTransactionRepository(getIt<DatabaseProvider>());
  getIt.registerSingleton<TransactionRepository>(sqfliteTransactionRepository);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DukoinFlavors.prod();
  await setup();
  await setupFirebase();
  runApp(DukoinApp());
}

Future<void> setupFirebase() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
}
