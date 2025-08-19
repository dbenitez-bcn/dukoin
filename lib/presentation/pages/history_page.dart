import 'package:dukoin/infrastructure/database_provider.dart';
import 'package:dukoin/infrastructure/sqflite_expense_repository.dart';
import 'package:dukoin/presentation/state/expense_pagination_controller.dart';
import 'package:dukoin/presentation/widgets/history_view.dart';
import 'package:flutter/material.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ExpensesHistoryView(
        paginationController: ExpensePaginationController(
          repository: SqfliteExpenseRepository(DatabaseProvider()),
        ),
      ),
    );
  }
}
