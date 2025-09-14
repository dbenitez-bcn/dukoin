import 'transaction.dart';

abstract class TransactionRepository {
  Future<int> insert(Transaction transaction);
}
