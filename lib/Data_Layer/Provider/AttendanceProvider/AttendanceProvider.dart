import '../../Model/AttendanceModel/testAddAttendance.dart';
import '../../Repository/AttendanceRepository/AttendanceRepository.dart';
import '../../Repository/SQliteRepository/SQliteRepository.dart';

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

  Future addAttendance() async {
    return attendanceRepository.addAttendanceUser();
  }

  Future<List<AttendanceSQLite>> getListAttendanceUser() async {
    return sqliteDatabase.getAttendanceList();
  }

  //get list attendance
  // Future<List<AttendanceModel>>  getDataToday() async {
  //   return attendanceRepository.getAttendance();
  // }

}