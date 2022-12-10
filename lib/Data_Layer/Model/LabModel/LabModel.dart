
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class LabModel {
  String? name;


  LabModel(
      {this.name});

  //save data to firebase
  Map<String, dynamic> toMap() {
    return {
      'name': name
    };
  }

  //get data from Repository
  factory LabModel.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> firestore) =>
      LabModel(
        name: firestore.data()!['name'],
      );

  static LabModel fromJson(Map<String, dynamic> json) => LabModel(
    name: json['name'],
  );
}

class LabModelSQLite extends Equatable {
  final String username;

  const LabModelSQLite(
      {
        required this.username,
        });

  Map<String, dynamic> toMap() {
    return {
      'username': username,
    };
  }

//get data from Repository
  static LabModelSQLite fromJSON(Map<String, Object?> json) => LabModelSQLite(
      username: json['name'] as String,);

  @override
// TODO: implement props
  List<Object?> get props =>
      [ username];
}