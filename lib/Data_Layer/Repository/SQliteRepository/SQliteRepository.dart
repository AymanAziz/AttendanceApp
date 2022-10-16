import 'package:firebase_auth/firebase_auth.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../../Model/AttendanceModel/testAddAttendance.dart';
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
        'CREATE TABLE Attendance(id INTEGER PRIMARY KEY AUTOINCREMENT,'
        'date TEXT NOT NULL,'
        'userId INTEGER NOT NULL,'
        'FOREIGN KEY (UserId) REFERENCES USER (id))'
        ' ');

    //equipment table
    await db.execute(' '
        ' CREATE TABLE Equipment(id INTEGER PRIMARY KEY AUTOINCREMENT,'
        'EquipmentName TEXT NOT NULL,'
        'EquipmentDescription TEXT NOT NULL,'
        'Quantity INTEGER NOT NULL,'
        'UserId INTEGER NOT NULL,'
        'FOREIGN KEY (UserId) REFERENCES USER (id))'
        ' ');


  }

  Future<userModelSQLite> getUserDetails() async {
    final db = await instance.database;

    //check email from firebase auth
    String email = await UserRepository().checkUserStatus();
    print("email : $email ");

    final maps = await db.rawQuery('SELECT * FROM USER WHERE email = ?',[email]);
    if (maps.isNotEmpty) {

      ///return model with user data (SQLITE)
      return userModelSQLite.fromJSON(maps.first);
    }
    else
    {
      ///return empty model
      return const userModelSQLite(username: '', telNumber: '', userID: '', isStudent: '',id: 0, email: '');


    }
  }



  ///save user data for not first time user (user yg dah delete app, but ada account kt firestore)
  ///get data specific  user from Repository check if is user or not
  Future<bool> saveUserDetails() async {
    final db = await instance.database;

    ///check email from firebase auth
    String email = await UserRepository().checkUserStatus();

    final maps = await db.rawQuery('SELECT * FROM USER WHERE email = ?',[email]);

    ///save to db if empty
    ///return true if it empty
    if (maps.isEmpty) {
      userModelSQLite  userModel = await UserRepository().addNotFirstTimeUser(email);

      await db.rawInsert(
          'INSERT INTO USER(name, phoneNumber, StaffOrUserID, isStudent, email) VALUES( ?, ?, ?, ?, ?)',
          [
            userModel.username,
            userModel.telNumber,
            userModel.userID,
            userModel.isStudent,
            userModel.email,
          ]);

      return true;
    }
    else
      {
        return false;
      }

  }

  Future<bool> createAttendance(currentDate) async {
    Database db = await instance.database;
    userModelSQLite reminderResponse;

    ///get user details from sqlite
    /// find attendance from specific user
    userModelSQLite  userModel = await getUserDetails();
    final maps = await db.rawQuery('SELECT * FROM Attendance  INNER JOIN USER ON Attendance.userId = USER.id  WHERE date = ? AND USER.id = ?',[currentDate, userModel.id]);

    ///save to db if empty
    ///return true if it empty
    if (maps.isEmpty) {

      await db.rawInsert(
          'INSERT INTO Attendance(date, userId) VALUES( ?, ?)',
          [
            currentDate,
            userModel.id,
          ]);

      return true;
    }
    else
    {
      return false;
    }

  }


  ///student get list attendance
  Future<List<AttendanceSQLite>> getAttendanceList() async {
    final db = await instance.database;
    userModelSQLite  userModel = await getUserDetails();
    final maps = await db.rawQuery('SELECT * FROM Attendance INNER JOIN USER ON Attendance.userId = USER.id   WHERE USER.id = ?',[userModel.id]);
    return maps.map((e) => AttendanceSQLite.fromJSON(e)).toList();
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
            'SELECT * FROM USER WHERE email = ?', [reminder.email]);
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
          reminderResponse = userModelSQLite.fromJSON(maps.first);
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