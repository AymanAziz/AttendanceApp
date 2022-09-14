import 'package:cloud_firestore/cloud_firestore.dart';

class Main{
    final List<AttendanceModel> attendance;

  Main({required this.attendance});
}



class AttendanceModel
{
  // Timestamp? date;
  String? email;
  bool? attend;

  // AttendanceModel({this.date, this.email, this.attend});
  AttendanceModel({ this.email, this.attend});

  //save data to firebase
  Map<String, dynamic> toMap() {
    return {
      // 'username': date,
      'email': email,
      'attend': attend,
    };
  }


  //get data from Repository
  factory AttendanceModel.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> firestore) =>
      AttendanceModel(
        email: firestore.data()!['email'],
        attend: firestore.data()!['attend'],
      );

  //get data from Repository
  factory AttendanceModel.fromFirestore1(
      DocumentSnapshot<Map<String, dynamic>> firestore) =>
      AttendanceModel(
        email: firestore.data().toString().contains('email') ?firestore.get('email'):'',
        attend: firestore.data().toString().contains('attend') ?firestore.get('attend'):'',
      );

  static AttendanceModel fromJson(Map<String, dynamic> json) => AttendanceModel(
    email: json['email'],
    attend: json['attend']
  );

}