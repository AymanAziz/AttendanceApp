

import 'package:attandance_app/Data_Layer/Model/AttendanceModel/attendanceModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../Repository/AttendanceRepository/AttendanceRepository.dart';

class AttendanceDbProvider {
  final AttendanceRepository attendanceRepository = AttendanceRepository();

  //get attendance
  Future addUserDataToday() async {
    return attendanceRepository.getAttendance();
  }

  //get list attendance
  // Future<List<AttendanceModel>>  getDataToday() async {
  //   return attendanceRepository.getAttendance();
  // }

}