import '../../Model/AttendanceModel/testAddAttendance.dart';
import '../../Model/EquipmentLabModel/EquipmentLabModel.dart';
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

  Future addAttendance(String labName) async {
    return attendanceRepository.addAttendanceUser(labName);
  }

  /// get lab list after user scan the qr code
  /// check if qr code is valid or not
  Future getListLab(labModel) async {
    return attendanceRepository.getLabListFirestore(labModel);
  }

  Future<List<AttendanceSQLite>> getListAttendanceUser() async {
    return sqliteDatabase.getAttendanceList();
  }


  Future<AttendanceSQLite> getCurrentDateAttendanceData(String labName) async {
    return sqliteDatabase.getCurrentDateAttendanceData(labName);
  }

  Future<List<EquipmentLabModel>> getAllEquipmentSpecificLab(labName) async{
    return attendanceRepository.getAllEquipmentSpecificLab(labName);
  }

}