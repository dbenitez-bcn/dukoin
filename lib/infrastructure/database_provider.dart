import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider {
  static final DatabaseProvider _instance = DatabaseProvider._internal();

  factory DatabaseProvider() => _instance;

  DatabaseProvider._internal();

  Database? _db;

  final List<String> _migrations = [
    '''
      CREATE TABLE expenses (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        amount REAL NOT NULL,
        category TEXT NOT NULL,
        description TEXT NOT NULL,
        createdAt TEXT NOT NULL
      );
    ''',
    '''
      ALTER TABLE expenses RENAME TO transactions;
    ''',
    '''
      ALTER TABLE transactions ADD COLUMN isExpense INTEGER NOT NULL DEFAULT 1 CHECK (isExpense IN (0,1));
    ''',
  ];

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDb();
    return _db!;
  }

  Future<Database> _initDb() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'dukoin.db');

    return await openDatabase(
      path,
      version: _migrations.length,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    for (var migration in _migrations) {
      await db.execute(migration);
    }
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    for (var i = oldVersion; i < newVersion; i++) {
      await db.execute(_migrations[i]);
    }
  }
}
