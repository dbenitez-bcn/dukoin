import 'package:dukoin/domain/transaction.dart';
import 'package:dukoin/domain/transaction_repository.dart';
import 'package:dukoin/infrastructure/database_provider.dart';
import 'package:sqflite/sqflite.dart' show Database;

class SqfliteTransactionRepository implements TransactionRepository {
  final DatabaseProvider dbProvider;

  SqfliteTransactionRepository(this.dbProvider);

  Future<Database> get _db async => await dbProvider.database;

  @override
  Future<int> insert(Transaction transaction) async {
    final db = await _db;
    return db.insert('transactions', transaction.toMap());
  }
}
