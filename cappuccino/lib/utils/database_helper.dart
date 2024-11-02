import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._internal();

  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = '$databasePath/notes.db';
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDatabase,
    );
  }

  Future<void> _createDatabase(Database db, int version) async {
    return await db.execute('''
        CREATE TABLE recepies (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          title TEXT NOT NULL,
          timeOfPrep INTEGER NOT NULL,
          dateOfCreation TEXT NOT NULL,
          ingredients TEXT NOT NULL,
          products TEXT NOT NULL,
          steps TEXT NOT NULL,
          timesPrepared TEXT NOT NULL,
        )
      '''); //Falta referencia a otra tabla que contenga solo las imágenes
  }
}
