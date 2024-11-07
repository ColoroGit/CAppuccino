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
          dateOfCreation INTEGER NOT NULL,
          ingredients TEXT NOT NULL,
          products TEXT NOT NULL,
          steps TEXT NOT NULL,
          timesPrepared TEXT NOT NULL,   
          FOREIGN KEY (dateOfCreation) REFERENCES dates (id)                  
           ON DELETE NO ACTION ON UPDATE NO ACTION

         )''');
    await db.execute('''
        CREATE TABLE dates (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          year INTEGER NOT NULL,
          month INTEGER NOT NULL,
          day INTEGER NOT NULL
        )''');
    await db.execute('''
        CREATE TABLE captions (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          recepieId INTEGER NOT NULL,    
          caption TEXT NOT NULL,   
          FOREIGN KEY (recepieId) REFERENCES recepies (id)                  
           ON DELETE CASCADE ON UPDATE NO ACTION
         )''');
  }

  Future<Recepie> insertRecepie(Recepie recepie) async {
    Database db = await instance.database;
    await db.insert(
      "dates",
      recepie.dateOfCreation.toMap(),
    );
    recepie.id = await db.insert(
      "recepies",
      recepie.toMap(),
    );

    //Falta insertar la imágen

    return recepie;
  }

  // Inserting and updating a RECEPIE **************
  Future<Recepie> updateRecepie(Recepie recepie) async {
    Database db = await instance.database;
    var count = Sqflite.firstIntValue(await db
        .rawQuery("SELECT COUNT(*) FROM recepies WHERE id = ?", [recepie.id]));

    if (count != 0) {
      await db.insert(
        "dates",
        recepie.dateOfCreation.toMap(),
      );
      recepie.id = await db.insert(
        "recepies",
        recepie.toMap(),
      );
    } else {
      print("Error, this recepie doesn't exist");
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
  Future<Recepie> fetchRecepie(Recepie r) async {
    Database db = await instance.database;

    List<Map> results = await db.query(
      "recepies",
      where: "id = ?",
      whereArgs: [r.id],
    );

    List<Map> dates = await db.query(
      "dates",
      where: "id = ?",
      whereArgs: [r.dateOfCreation.id],
    );

    Recepie recepie = Recepie.fromDB(results[0], dates[0]);
    return recepie;
  }

  // fetch all RECEPIES ***********
  Future<List<Recepie>> fetchAllRecepies() async {
    Database db = await instance.database;
    List<Map<String, dynamic>> results = await db.query("recepies");

    List<Recepie> recepies = [];
    for (var res in results) {
      List<Map> date = await db.query(
        "dates",
        where: "id = ?",
        whereArgs: [res['dateOfCreation']],
      );
      Recepie r = Recepie.fromDB(res, date[0]);
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
  Future<int> deleteRecepie(Recepie r) async {
    Database db = await instance.database;
    await db.delete("dates", where: "id = ?", whereArgs: [r.dateOfCreation.id]);
    return await db.delete("recepie", where: "id = ?", whereArgs: [r.id]);
  }
}
