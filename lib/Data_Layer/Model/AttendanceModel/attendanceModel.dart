import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class ListMain{
    final List<AttendanceModel> attendance;

    ListMain({required this.attendance});
}



class AttendanceModel
{
  // Timestamp? date;
  String? email;
  String? username;

  // AttendanceModel({this.date, this.email, this.attend});
  AttendanceModel({ this.email, this.username});

  //save data to firebase
  Map<String, dynamic> toMap() {
    return {
      // 'username': date,
      'email': email,
      'username': username,
    };
  }


  //get data from Repository
  factory AttendanceModel.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> firestore) =>
      AttendanceModel(
        email: firestore.data()!['email'],
        username: firestore.data()!['username'],
      );

  //get data from Repository
  factory AttendanceModel.fromFirestore1(
      DocumentSnapshot<Map<String, dynamic>> firestore) =>
      AttendanceModel(
        email: firestore.data().toString().contains('email') ?firestore.get('email'):'',
        username: firestore.data().toString().contains('username') ?firestore.get('username'):'',
      );

  static AttendanceModel fromJson(Map<String, dynamic> json) => AttendanceModel(
    email: json['email'],
      username: json['attend']
  );

}

class AttendanceSQLModel extends Equatable{
  final int? id;
  final String date;
  final String name;
  final String email;
  final String? UserId;

  AttendanceSQLModel({
    this.id,
    required this.date,
    required this.name,
    required this.email,
    this.UserId
  });

  factory AttendanceSQLModel.fromJson(Map<String, dynamic> json) {
    return AttendanceSQLModel(
        id: json['id'],
        date: json['date'],
        name: json['name'],
        email: json['email'],
        UserId: json['UserId']
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'date': date,
    'name': name,
    'email': email,
    'UserId': UserId
  };

  @override
  List<Object?> get props => [
    id,
    date,
    name,
    email,
    UserId
  ];

}