import 'package:dukoin/domain/expense.dart';
import 'package:dukoin/domain/expense_repository.dart';

class ExpensePaginationController {
  final ExpenseRepository repository;
  final int pageSize;

  int _offset = 0;
  bool _hasMore = true;
  bool _isLoading = false;

  List<Expense> _expenses = [];

  ExpensePaginationController({required this.repository, this.pageSize = 10});

  List<Expense> get expenses => _expenses;

  bool get hasMore => _hasMore;

  bool get isLoading => _isLoading;

  /// Load first page or refresh
  Future<void> refresh() async {
    _offset = 0;
    _hasMore = true;
    _expenses = [];
    await loadMore();
  }

  /// Load next page
  Future<void> loadMore() async {
    if (_isLoading || !_hasMore) return;

    _isLoading = true;

    final newExpenses = await repository.getPaginated(
      limit: pageSize,
      offset: _offset,
    );

    _expenses.addAll(newExpenses);
    _offset += newExpenses.length;

    if (newExpenses.length < pageSize) {
      _hasMore = false; // no more data to load
    }

    _isLoading = false;
  }
}
