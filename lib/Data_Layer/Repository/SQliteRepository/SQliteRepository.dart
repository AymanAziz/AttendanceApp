import 'package:firebase_auth/firebase_auth.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../../Model/UserModel/userModel.dart';
import '../UserRepository/UserRepository.dart';


class SqliteDatabase
{
  static final SqliteDatabase instance = SqliteDatabase._init();
  static Database? _database;
  SqliteDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('attendance.db');

    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    //user table
    await db.execute(' '
        ' CREATE TABLE USER(id INTEGER PRIMARY KEY AUTOINCREMENT,'
        'name TEXT NOT NULL,'
        'phoneNumber TEXT NOT NULL,'
        'isStudent TEXT NOT NULL,'
        'email  TEXT NOT NULL,'
        'StaffOrUserID TEXT NOT NULL)');

    // attendance table
    await db.execute(' '
        ' CREATE TABLE Attendance(id INTEGER PRIMARY KEY AUTOINCREMENT,'
        'date TEXT NOT NULL,'
        'name TEXT NOT NULL,'
        'email TEXT NOT NULL,'
        'UserId INTEGER NOT NULL,'
        'FOREIGN KEY (UserId) REFERENCES Hospital (id))'
        ' ');

    //equipment table
    await db.execute(' '
        ' CREATE TABLE Equipment(id INTEGER PRIMARY KEY AUTOINCREMENT,'
        'EquipmentName TEXT NOT NULL,'
        'EquipmentDescription TEXT NOT NULL,'
        'Quantity INTEGER NOT NULL,'
        'UserId INTEGER NOT NULL,'
        'FOREIGN KEY (UserId) REFERENCES Hospital (id))'
        ' ');


  }

  Future<userModelSQLite> getUserDetails() async {
    final db = await instance.database;

    //check email from firebase auth
    String email = await UserRepository().checkUserStatus();
    print("email : $email ");
    final maps = await db.rawQuery('SELECT * FROM USER WHERE email = ?',[email]);

    if (maps.isNotEmpty) {
      return userModelSQLite.fromJSON(maps.first);
    }
    else
    {
      return const userModelSQLite(username: '', telNumber: '', userID: '', isStudent: '',id: 0, email: '');
    }
  }

  Future createUser(userModelSQLite reminder) async {
    Database db = await instance.database;
    userModelSQLite reminderResponse;
    //check email from firebase auth
    String email = FirebaseAuth.instance.currentUser?.email! ?? "0";

    //check email from FireStore
    if(email == "0")
      {
        //insert to Medicine table
        await db.rawInsert(
            'INSERT INTO USER(name, phoneNumber, StaffOrUserID, isStudent, email) VALUES( ?, ?, ?, ?, ?)',
            [
              reminder.username,
              reminder.telNumber,
              reminder.userID,
              reminder.isStudent,
              reminder.email,
            ]);
      }
    else
      {
        final maps = await db.rawQuery(
            'SELECT * FROM USER WHERE email = ? Limit 1', [reminder.email]);
        reminderResponse = userModelSQLite.fromJSON(maps.first);



        if(maps.isEmpty)
        {
          //insert to Medicine table
          await db.rawInsert(
              'INSERT INTO USER(name, phoneNumber, StaffOrUserID, isStudent, email) VALUES( ?, ?, ?, ?, ?)',
              [
                reminder.username,
                reminder.telNumber,
                reminder.userID,
                reminder.isStudent,
                email,
              ]);
        }
        else
        {
          await db.rawUpdate(
              'UPDATE USER SET name = ?, phoneNumber = ?, StaffOrUserID = ?, isStudent = ?, email = ?  WHERE id = ?',[
            reminder.username,
            reminder.telNumber,
            reminder.userID,
            reminder.isStudent,
            reminder.email,
            reminderResponse.id

          ]);

        }
      }


  }
}