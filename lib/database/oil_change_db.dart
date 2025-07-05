import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/oil_change_model.dart';

class OilChangeDB {
  static final OilChangeDB instance = OilChangeDB._();
  static Database? _db;

  OilChangeDB._();

  Future<Database> get db async {
    _db ??= await _initDB();
    return _db!;
  }

  Future<Database> _initDB() async {
    final path = join(await getDatabasesPath(), 'oil_change.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, _) {
        return db.execute('''
        CREATE TABLE oil_changes (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          current_km INTEGER,
          oil_life_km INTEGER,
          avg_km_per_day INTEGER,
          target_km INTEGER,
          change_date TEXT
        )
      ''');
      },
    );
  }

  Future<void> insertOilChange(OilChange data) async {
    final database = await db;
    await database.insert('oil_changes', data.toMap());
  }

  Future<OilChange?> getLastOilChange() async {
    final database = await db;
    final result =
        await database.query('oil_changes', orderBy: 'id DESC', limit: 1);
    if (result.isNotEmpty) {
      return OilChange.fromMap(result.first);
    }
    return null;
  }
}
