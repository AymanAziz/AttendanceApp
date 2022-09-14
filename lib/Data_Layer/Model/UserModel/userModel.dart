import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? name;
  String? email;
  String? userID;
  String? telNumber;
  String? isStudent;

  UserModel({this.name, this.email, this.userID, this.telNumber,this.isStudent});

  //save data to firebase
  Map<String, dynamic> toMap() {
    return {
      'username': name,
      'email': email,
      'userID': userID,
      'telNumber': telNumber,
      'isStudent': isStudent,

    };
  }

  //get data from Repository
  factory UserModel.fromFirestore(
          DocumentSnapshot<Map<String, dynamic>> firestore) =>
      UserModel(
        name: firestore.data()!['username'],
        email: firestore.data()!['email'],
        userID: firestore.data()!['userID'],
        telNumber: firestore.data()!['telNumber'],
        isStudent: firestore.data()!['isStudent'],
      );
}
