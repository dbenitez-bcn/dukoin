import 'package:dukoin/domain/expense.dart';
import 'package:dukoin/l10n/app_localizations.dart';
import 'package:dukoin/presentation/widgets/dismissible_expense_info_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:intl/intl.dart';

class ExpenseHistoryListView extends StatelessWidget {
  final List<Expense> expenses;

  const ExpenseHistoryListView({super.key, required this.expenses});

  String formatDateTitle(DateTime date, AppLocalizations appLocales) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final target = DateTime(date.year, date.month, date.day);

    if (target == today) {
      return appLocales.today;
    } else if (target == yesterday) {
      return appLocales.yesterday;
    } else if (target.year == now.year) {
      return DateFormat('d MMMM', appLocales.localeName).format(target);
    } else {
      return DateFormat('d MMMM y', appLocales.localeName).format(target);
    }
  }

  @override
  Widget build(BuildContext context) {
    final Map<DateTime, List<Expense>> grouped = {};
    for (final e in expenses) {
      final day = DateTime(
        e.createdAt.year,
        e.createdAt.month,
        e.createdAt.day,
      );
      grouped.putIfAbsent(day, () => []).add(e);
    }

    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverAppBar(title: Text(AppLocalizations.of(context)!.historyTitle)),
          ...grouped.entries.map((entry) {
            final date = entry.key;
            final expenses = entry.value;
      
            return SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              sliver: SliverStickyHeader(
                header: Container(
                  color: Theme.of(context).colorScheme.surface,
                  padding: const EdgeInsets.all(16.0),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    formatDateTitle(date, AppLocalizations.of(context)!),
                    style: TextTheme.of(context).displaySmall,
                  ),
                ),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate((context, i) {
                    final expense = expenses[i];
                    return DismissibleExpenseInfoCard(expense: expense);
                  }, childCount: expenses.length),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
