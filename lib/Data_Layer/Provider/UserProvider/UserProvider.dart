

import '../../Model/UserModel/userModel.dart';
import '../../Repository/SQliteRepository/SQliteRepository.dart';
import '../../Repository/UserRepository/UserRepository.dart';

class UserdbProvider {
  final UserRepository userRepository = UserRepository();
   SqliteDatabase sqliteDatabase = SqliteDatabase.instance;

  //add user
  Future<void> addUserData(UserModel userModel) async {
    return userRepository.addUser(userModel);
  }

  // //update user
  Future<void> updateUser(UserModel userModel) async {
    return userRepository.updateUser(userModel);
  }
  //
  //check user
  Future<userModelSQLite> checkUserData() async {
    return sqliteDatabase.getUserDetails();
  }

  Future<void> addUserDataSQLite(userModelSQLite userModelSqlite) async
  {
    return sqliteDatabase.createUser(userModelSqlite);
  }



}