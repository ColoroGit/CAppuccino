import 'package:cappuccino/models/caption.dart';
import 'package:cappuccino/models/recepie.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._internal();

  static Database? db;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (db != null) {
      return db!;
    }

    db = await _initDatabase();
    return db!;
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

  Future _createDatabase(Database db, int version) async {
    // await db.execute('PRAGMA foreign_keys = ON'); Might need this
    await db.execute('''
        CREATE TABLE recepies (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          title TEXT NOT NULL,
          timeOfPrep INTEGER NOT NULL,
          dateOfCreation TEXT NOT NULL,
          ingredients TEXT NOT NULL,
          products TEXT NOT NULL,
          steps TEXT NOT NULL,
          timesPrepared TEXT NOT NULL
         )''');
    await db.execute('''
        CREATE TABLE captions (
          id INTEGER PRIMARY KEY,
          recepieId INTEGER NOT NULL,    
          caption TEXT NOT NULL,   
          FOREIGN KEY (recepieId) REFERENCES recepies (id)                  
           ON DELETE CASCADE ON UPDATE NO ACTION
         )''');
  }

  // Inserting and updating a RECEPIE **************
  Future<Recepie> upsertRecepie(Recepie recepie) async {
    Database db = await instance.database;
    var count = Sqflite.firstIntValue(await db.rawQuery(
        "SELECT COUNT(*) FROM recepies WHERE title = ?", [recepie.title]));

    if (count == 0) {
      recepie.id = await db.insert(
        "recepies",
        recepie.toMap(),
      );
    } else {
      await db.update(
        "recepies",
        recepie.toMap(),
        where: "id = ?",
        whereArgs: [recepie.id],
      );
    }
    return recepie;
  }

  // Inserting and updating a CAPTION ********** (consider just making a insert, we might not need to modify)
  Future<Caption> upsertCaption(Caption caption) async {
    Database db = await instance.database;
    var count = Sqflite.firstIntValue(await db
        .rawQuery("SELECT COUNT(*) FROM captions WHERE id = ?", [caption.id]));

    if (count == 0) {
      await db.insert(
        "captions",
        caption.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } else {
      await db.update(
        "captions",
        caption.toMap(),
        where: "id = ?",
        whereArgs: [caption.id],
      );
    }
    return caption;
  }

  // fetch a single RECEPIE ***************
  Future<Recepie> fetchRecepie(int id) async {
    Database db = await instance.database;

    List<Map> results = await db.query(
      "recepies",
      where: "id = ?",
      whereArgs: [id],
    );

    Recepie recepie = Recepie.fromMap(results[0]);
    return recepie;
  }

  // fetch all RECEPIES ***********
  Future<List<Recepie>> fetchAllRecepies() async {
    Database db = await instance.database;
    List<Map<String, dynamic>> results = await db.query("recepies");

    List<Recepie> recepies = [];
    for (var res in results) {
      Recepie r = Recepie.fromMap(res);
      recepies.add(r);
    }
    return recepies;
  }

  // fetch CAPTIONS of a particular RECEPIE **********
  Future<List<Caption>> fetchRecepieCaptions(int recepieId) async {
    Database db = await instance.database;
    List<Map<String, dynamic>> results = await db.query(
      "captions",
      where: "recepieId = ?",
      whereArgs: [recepieId],
    );

    List<Caption> captions = [];
    for (var res in results) {
      Caption c = Caption.fromMap(res);
      captions.add(c);
    }
    return captions;
  }

  // DELETE RECEPIE
  Future<int> deleteRecepie(int id) async {
    Database db = await instance.database;
    return await db.delete("recepie", where: "id = ?", whereArgs: [id]);
  }
}
