

import 'package:attandance_app/Data_Layer/Model/AttendanceModel/attendanceModel.dart';
import 'package:attandance_app/Data_Layer/Model/UserModel/userModel.dart';
import 'package:attandance_app/Data_Layer/Repository/SQliteRepository/SQliteRepository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../Repository/AttendanceRepository/AttendanceRepository.dart';
import '../../Repository/AttendanceRepository/AttendanceRepositorySQLite.dart';

class AttendanceDbProvider {
  final AttendanceRepository attendanceRepository = AttendanceRepository();
  SqliteDatabase sqliteDatabase = SqliteDatabase.instance;

  //get attendance
  Future addUserDataToday() async {
    return attendanceRepository.getAttendance();
  }
  //get attendance
  Future<int> countUser() async {
    return attendanceRepository.countUser();
  }

  Future getUserAttendanceProvider(String email) async{
    sqliteDatabase.getUserAttendance(email);

  }

  //get list attendance
  // Future<List<AttendanceModel>>  getDataToday() async {
  //   return attendanceRepository.getAttendance();
  // }

}