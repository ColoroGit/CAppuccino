import 'package:cappuccino/models/barista_recepie.dart';
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
          ingredients TEXT NOT NULL,
          products TEXT NOT NULL,
          steps TEXT NOT NULL,
          timesPrepared INTEGER NOT NULL
         )''');
    await db.execute('''
        CREATE TABLE dates (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          recepieId INTEGER NOT NULL,    
          year INTEGER NOT NULL,
          month INTEGER NOT NULL,
          day INTEGER NOT NULL,
          FOREIGN KEY (recepieId) REFERENCES recepies (id)                  
           ON DELETE CASCADE ON UPDATE CASCADE
        )''');
    await db.execute('''
        CREATE TABLE captions (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          recepieId INTEGER NOT NULL,    
          caption TEXT NOT NULL,   
          FOREIGN KEY (recepieId) REFERENCES recepies (id)                  
           ON DELETE CASCADE ON UPDATE CASCADE
         )''');
  }

  // Necesita devolver una receta?
  Future<Recepie> insertRecepie(Recepie recepie) async {
    Database db = await instance.database;

    recepie.id = await db.insert(
      "recepies",
      recepie.toMap(),
    );

    await db.insert(
      "dates",
      recepie.dateOfCreation.toMap(recepie.id),
    );

    for (var c in recepie.captions) {
      await db.insert(
        "captions",
        c.toMap(recepie.id),
      );
    }

    return recepie;
  }

  Future<Recepie> insertBRecepie(BRecepie br) async {
    Database db = await instance.database;

    List<Caption> captions = List.empty(growable: true);
    captions.add(br.mainCaption);

    Recepie r = Recepie(
      id: -1,
      title: br.title,
      timeOfPrep: br.timeOfPrep,
      dateOfCreation: br.dateOfCreation,
      ingredients: br.ingredients,
      products: br.products,
      steps: br.steps,
      timesPrepared: br.timesPrepared,
      captions: captions,
    );

    var rID = await db.insert(
      "recepies",
      br.toMap(),
    );

    r.dateOfCreation.id = await db.insert(
      "dates",
      br.dateOfCreation.toMap(rID),
    );

    r.dateOfCreation.recepieId = rID;

    r.captions[0].id = await db.insert(
      "captions",
      br.mainCaption.toMap(rID),
    );

    r.captions[0].recepieId = rID;

    return r;
  }

  // Updating a RECEPIE **************
  Future<Recepie> updateRecepie(Recepie recepie) async {
    Database db = await instance.database;
    var count = Sqflite.firstIntValue(await db
        .rawQuery("SELECT COUNT(*) FROM recepies WHERE id = ?", [recepie.id]));

    if (count != 0) {
      await db.update(
        "recepies",
        recepie.toMap(),
        where: "id = ?",
        whereArgs: [recepie.id],
      );

      await db.update(
        "dates",
        recepie.dateOfCreation.toMap(recepie.id),
        where: "RecepieId = ?",
        whereArgs: [recepie.id],
        // conflictAlgorithm: ConflictAlgorithm.replace,
      );

      for (var c in recepie.captions) {
        await db.update(
          "captions",
          c.toMap(recepie.id),
          where: "RecepieId = ?",
          whereArgs: [recepie.id],
          // conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
    } else {
      // ignore: avoid_print
      print("Error, this recepie doesn't exist");
    }

    return recepie;
  }

  // // Inserting and updating a CAPTION ********** (consider just making a insert, we might not need to modify)
  // Future<Caption> upsertCaption(Caption caption) async {
  //   Database db = await instance.database;
  //   var count = Sqflite.firstIntValue(await db
  //       .rawQuery("SELECT COUNT(*) FROM captions WHERE id = ?", [caption.id]));

  //   if (count == 0) {
  //     await db.insert(
  //       "captions",
  //       caption.toMap(),
  //       conflictAlgorithm: ConflictAlgorithm.replace,
  //     );
  //   } else {
  //     await db.update(
  //       "captions",
  //       caption.toMap(),
  //       where: "id = ?",
  //       whereArgs: [caption.id],
  //     );
  //   }
  //   return caption;
  // }

  // fetch a single RECEPIE ***************
  Future<Recepie> fetchRecepie(int rID) async {
    Database db = await instance.database;

    List<Map> results = await db.query(
      "recepies",
      where: "id = ?",
      whereArgs: [rID],
    );

    List<Map> dates = await db.query(
      "dates",
      where: "RecepieId = ?",
      whereArgs: [rID],
    );

    List<Map> captions = await db.query(
      "captions",
      where: "recepieId = ?",
      whereArgs: [rID],
    );

    Recepie recepie = Recepie.fromDB(results[0], dates[0], captions);
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
        where: "recepieId = ?",
        whereArgs: [res['id']],
      );
      List<Map> captions = await db.query(
        "captions",
        where: "recepieId = ?",
        whereArgs: [res['id']],
      );
      Recepie r = Recepie.fromDB(res, date[0], captions);
      recepies.add(r);
    }
    return recepies;
  }

  // // fetch CAPTIONS of a particular RECEPIE **********
  // Future<List<Caption>> fetchRecepieCaptions(int recepieId) async {
  //   Database db = await instance.database;
  //   List<Map<String, dynamic>> results = await db.query(
  //     "captions",
  //     where: "recepieId = ?",
  //     whereArgs: [recepieId],
  //   );

  //   List<Caption> captions = [];
  //   for (var res in results) {
  //     Caption c = Caption.fromMap(res);
  //     captions.add(c);
  //   }
  //   return captions;
  // }

  // DELETE RECEPIE
  Future<int> deleteRecepie(Recepie r) async {
    Database db = await instance.database;
    return await db.delete("recepies", where: "id = ?", whereArgs: [r.id]);
  }
}
