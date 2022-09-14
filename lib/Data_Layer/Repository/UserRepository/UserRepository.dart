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

  // //get data specific  user from Repository
  // Future<DocumentSnapshot<Object?>> specificUser() async {
  //   FirebaseFirestore dbTest = FirebaseFirestore.instance;
  //   // dbTest.collection('medicatonformulary').doc("OtM3DD5lkEeSL3psBDtK").set({
  //   //   "Dosage": DateTime.now().millisecondsSinceEpoch,
  //   //   "MDC": 'ss',
  //   // });
  //
  //   String uid = await getuid();
  //   return await db.doc(uid).get();
  // }


// //get data specific  user from Repository check if is user or not
  Future checkUser(String email) async {
    var data;
    await db.doc(email).get().then((value) => {data = value.data()});
    String userStatus = data["isStudent"];
    return userStatus;

  }


}
