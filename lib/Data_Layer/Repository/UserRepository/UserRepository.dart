import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../Model/UserModel/userModel.dart';

class UserRepository {
  CollectionReference db = FirebaseFirestore.instance.collection('user');



  final FirebaseAuth auth = FirebaseAuth.instance;

  //getcurrent user uid
  Future getuid() async {
    String? uid = auth.currentUser?.email.toString();
    // print("yo this is uid: $uid");
    return uid.toString();
  }

  //check email admin
  Future<String> checkUserStatus() async {
    String? checkMail = FirebaseAuth.instance.currentUser!.email!;
   return checkMail;
  }

  //add user to Repository
  Future<void> addUser(UserModel userModel) async {
    String uid = userModel.email.toString();
    await db.doc(uid).set({
      'username': userModel.name,
      'email': userModel.email,
      'telNumber': userModel.telNumber,
      'userID': userModel.userID,
      'isStudent': userModel.isStudent
    });
    return;
  }


  ///add user to Repository
  Future<void> updateUser(UserModel userModel) async {
    String uid = userModel.email.toString();
    await db.doc(uid).update({
      'username': userModel.name,
      'email': userModel.email,
      'telNumber': userModel.telNumber,
      'userID': userModel.userID,
      'isStudent': userModel.isStudent
    });
    return;
  }



  Stream<DocumentSnapshot<Object?>> specificUser() {
    String? email = FirebaseAuth.instance.currentUser?.email;
    Stream<DocumentSnapshot> courseDocStream = db.doc(email).snapshots();
    return courseDocStream;
  }





 ///get data specific  user from Repository check if is user or not
  Future checkUser(String email) async {
    var data;
    await db.doc(email).get().then((value) => {data = value.data()});
    String userStatus = data["isStudent"];
    return userStatus;
  }

  ///save user data for not first time user (user yg dah delete app, but ada account kt firestore)
  ///get data specific  user from Repository check if is user or not
  Future addNotFirstTimeUser(String email) async {
    var data;
    await db.doc(email).get().then((value) => {data = value.data()});
    String isStudent = data["isStudent"];
    String username = data["username"];
    String telNumber = data["telNumber"];
    String userID = data["userID"];

    userModelSQLite userModelSqlite = userModelSQLite(
      username: username,
      email: email,
      userID: userID,
      telNumber: telNumber,
      isStudent: isStudent,
    );
    return userModelSqlite;
  }


}
