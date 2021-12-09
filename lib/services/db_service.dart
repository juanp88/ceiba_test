import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:users_test/models/user_model.dart';

class DBService {
  static Database? _database;
  static final DBService db = DBService._();

  DBService._();

  Future<Database?> get database async {
    // If database exists, return database
    if (_database != null) return _database;

    // If database don't exists, create one
    _database = await initDB();

    return _database;
  }

  // Create the database and the User table
  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'users.db');

    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute('CREATE TABLE User('
          'id INTEGER PRIMARY KEY,'
          'email TEXT,'
          'name TEXT,'
          'phone TEXT'
          ')');
    });
  }

  // Insert user on database
  createUser(User newUser) async {
    await deleteAllUsers();
    final db = await database;
    final res = await db!.insert('User', newUser.toJson());

    return res;
  }

  // Delete all users
  Future<int> deleteAllUsers() async {
    final db = await database;
    final res = await db!.rawDelete('DELETE FROM User');

    return res;
  }

  Future<List<User>> getAllUsers() async {
    final db = await database;
    final res = await db!.rawQuery("SELECT * FROM User");

    List<User> list =
        res.isNotEmpty ? res.map((c) => User.fromJson(c)).toList() : [];

    return list;
  }
}
