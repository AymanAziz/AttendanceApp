import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class UserModel {
  String? name;
  String? email;
  String? userID;
  String? telNumber;
  String? isStudent;

  UserModel(
      {this.name, this.email, this.userID, this.telNumber, this.isStudent});

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

  static UserModel fromJson(Map<String, dynamic> json) => UserModel(
        name: json['username'],
        email: json['email'],
        userID: json['userID'],
        telNumber: json['telNumber'],
        isStudent: json['isStudent'],
      );
}

class userModelSQLite extends Equatable {
  final int? id;
  final String username;
  final String telNumber;
  final String isStudent;
  final String email;
  final String userID;

  const userModelSQLite(
      {this.id,
      required this.username,
      required this.telNumber,
      required this.userID,
      required this.isStudent,
      required this.email});

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'telNumber': telNumber,
      'isStudent': isStudent,
      'userID': userID,
      'email': email,
      'id': id
    };
  }

//get data from Repository
  static userModelSQLite fromJSON(Map<String, Object?> json) => userModelSQLite(
      username: json['name'] as String,
      telNumber: json['phoneNumber'] as String,
      isStudent: json['isStudent'] as String,
      email: json['email'] as String,
      userID: json['StaffOrUserID'] as String,
      id: json['id'] as int?);

  @override
// TODO: implement props
  List<Object?> get props =>
      [id, username, telNumber, userID, isStudent, email];
}
