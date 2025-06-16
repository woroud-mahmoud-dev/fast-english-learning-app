import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqlDb {
  static Database? _db;

  String databaseName = 'fast.db';


  // table names
  static String objectsTable = "objectsTable" , selectedObjectsTable = "SlectedobjectsTable" , wrongTable = "WrongTable" , allWords = "AllWords" , correctTable = "CorrectTable" ,duplicatedTable = "DuplicatedTable",storiesTable = "StoriesTable" ;

  Future<Database?> get db async {
    if (_db == null) {
      _db = await initialDb();
      return _db;
    } else {
      return _db;
    }
  }

  initialDb() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, databaseName);
    Database myDB = await openDatabase(path,
        onCreate: _onCreate, version: 1, onUpgrade: _onUpgrade);
    return myDB;
  }

  _onCreate(Database db, int version) async {
    Batch batch = db.batch();
    batch.execute('''
   CREATE TABLE '$objectsTable' (id INTEGER   PRIMARY KEY AUTOINCREMENT,
    ar_title Text,en_title Text,image Text)
          ''');
    batch.execute('''
   CREATE TABLE '$selectedObjectsTable' (id INTEGER   PRIMARY KEY AUTOINCREMENT,
    ar_title Text,en_title Text,image Text)
          ''');
    batch.execute('''
      CREATE TABLE '$allWords'(id INTEGER   PRIMARY KEY AUTOINCREMENT,
      date Text,type_id INTEGER NOT NULL,word_id INTEGER NOT NULL,
    word Text,word1 Text,image Text,correct_word Text,object_id INTEGER NOT NULL,level_id INTEGER NOT NULL ,
          FOREIGN KEY (object_id) REFERENCES objectsTable (id) , unique (word_id, type_id) )
          ''');
    batch.execute('''
   CREATE TABLE '$wrongTable'(id INTEGER   PRIMARY KEY AUTOINCREMENT,
   date Text,type_id INTEGER NOT NULL,word_id INTEGER NOT NULL,
    word Text,word1 Text,image Text,correct_word Text,object_id INTEGER NOT NULL,level_id INTEGER NOT NULL ,
          FOREIGN KEY (object_id) REFERENCES objectsTable (id), unique (word_id, type_id) )
          ''');
    batch.execute('''
   CREATE TABLE '$correctTable'( id INTEGER   PRIMARY KEY AUTOINCREMENT,
    word Text,word1 Text,image Text ,date Text,type_id INTEGER NOT NULL,
    word_id INTEGER NOT NULL, correct_word Text,object_id INTEGER NOT NULL,level_id INTEGER NOT NULL ,
    FOREIGN KEY (object_id) REFERENCES objectsTable (id) , unique (word_id, type_id) )
          ''');
    batch.execute('''
   CREATE TABLE '$duplicatedTable' (id INTEGER   PRIMARY KEY AUTOINCREMENT,
   date Text,type_id INTEGER NOT NULL,word_id INTEGER NOT NULL,
    word Text,word1 Text,image Text,correct_word Text,object_id INTEGER NOT NULL,level_id INTEGER NOT NULL ,
    FOREIGN KEY (object_id) REFERENCES objectsTable (id) , unique (word_id, type_id))
    ''');
    batch.execute('''
   CREATE TABLE '$storiesTable' (id INTEGER   PRIMARY KEY AUTOINCREMENT,
    ar_text Text,en_text Text,image Text,title Text,object_id Text)
    ''');

    if (kDebugMode) {
      print('create database and 7 tables');
    }
    await batch.commit();
  }

  _onUpgrade(Database db, int oldVersion, int newVersion) async{
    if (oldVersion != newVersion) {

      if (kDebugMode) {
        print('upgrade database for tables');
      }
    }
  }

  read(String table) async {
    Database? myDB = await db;
    List<Map<String ,dynamic>> response = await myDB!.query(table);
    return response;
  }

  insert(String table, Map<String, Object?> values) async {
    Database? myDB = await db;

    var response = await myDB!.insert(
      table,
      values,
    );
    //print("response for insert word $response");
    return response;
  }

  update(String table, Map<String, Object?> values, String? myWhere) async {
    Database? myDB = await db;

    int response = await myDB!.update(table, values, where: myWhere);
    return response;
  }

  delete({required String table, required String? myWhere}) async {
    Database? myDB = await db;

    int response = await myDB!.delete(table, where: myWhere);
    return response;
  }

  readData(String sql) async {
    Database? myDB = await db;
    List<Map> response = await myDB!.rawQuery(sql);
    return response;
  }

  insertData(String sql) async {
    Database? myDB = await db;

    int response = await myDB!.rawInsert(sql);
    return response;
  }

  updateData(String sql) async {
    Database? myDB = await db;

    int response = await myDB!.rawUpdate(sql);
    return response;
  }

  Future<dynamic> count(String sql) async {
    Database? myDB = await db;
    var response = await myDB!.rawQuery(sql);
    return response;
  }

  deleteData(String sql) async {
    Database? myDB = await db;

    int response = await myDB!.rawDelete(sql);
    return response;
  }

}
