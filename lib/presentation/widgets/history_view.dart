import 'package:dukoin/domain/expense.dart';
import 'package:dukoin/l10n/app_localizations.dart';
import 'package:dukoin/presentation/state/expense_pagination_controller.dart';
import 'package:dukoin/presentation/widgets/dismissible_expense_info_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:intl/intl.dart';

class ExpensesHistoryView extends StatelessWidget {
  final ExpensePaginationController paginationController;
  final ScrollController scrollController;

  ExpensesHistoryView({super.key, required this.paginationController})
    : scrollController = ScrollController();

  Future<void> _initialRefresh() async {
    await Future.delayed(Duration(seconds: 2));
    await paginationController.refresh();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.historyTitle)),
      body: FutureBuilder(
        future: _initialRefresh(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return CircularProgressIndicator();
          } else {
            return ExpenseHistoryListView(
              paginationController: paginationController,
            );
          }
        },
      ),
    );
  }
}

class ExpenseHistoryListView extends StatefulWidget {
  final ExpensePaginationController paginationController;

  const ExpenseHistoryListView({super.key, required this.paginationController});

  @override
  State<ExpenseHistoryListView> createState() => _ExpenseHistoryListViewState();
}

class _ExpenseHistoryListViewState extends State<ExpenseHistoryListView> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  String _formatDateTitle(DateTime date, AppLocalizations appLocales) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final target = DateTime(date.year, date.month, date.day);

    if (target == today) {
      return appLocales.today;
    } else if (target == yesterday) {
      return appLocales.yesterday;
    } else if (target.year == now.year) {
      return DateFormat('MMMMd', appLocales.localeName).format(target);
    } else {
      return DateFormat('yMMMMd', appLocales.localeName).format(target);
    }
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 100 &&
        widget.paginationController.hasMore &&
        !widget.paginationController.isLoading) {
      widget.paginationController.loadMore().then((_) => setState(() {}));
    }
  }

  @override
  Widget build(BuildContext context) {
    final Map<DateTime, List<Expense>> grouped = {};
    for (final e in widget.paginationController.expenses) {
      final day = DateTime(
        e.createdAt.year,
        e.createdAt.month,
        e.createdAt.day,
      );
      grouped.putIfAbsent(day, () => []).add(e);
    }

    return RefreshIndicator(
      onRefresh: () async {
        await widget.paginationController.refresh();
        setState(() {});
      },
      child: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        controller: _scrollController,
        slivers: [
          SliverStickyHeader(), // makes refresh indicator better looking
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
                    _formatDateTitle(date, AppLocalizations.of(context)!),
                    style: TextTheme.of(context).displaySmall,
                  ),
                ),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, i) =>
                        DismissibleExpenseInfoCard(expense: expenses[i]),
                    childCount: expenses.length,
                  ),
                ),
              ),
            );
          }),
          if (widget.paginationController.hasMore)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Center(child: CircularProgressIndicator()),
              ),
            ),
          SliverToBoxAdapter(child: SizedBox(height: 32)),
        ],
      ),
    );
  }
}
