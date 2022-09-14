import 'package:cloud_firestore/cloud_firestore.dart';

class AttendanceRepository {
  CollectionReference db = FirebaseFirestore.instance.collection('Attendance');

  Stream<DocumentSnapshot> getAttendance()  {
    DateTime currentDateTime = DateTime.now();
    Timestamp myTimeStamp = Timestamp.fromDate(currentDateTime); //To TimeStamp
    DateTime currentDate = myTimeStamp.toDate();

    Stream<DocumentSnapshot> courseDocStream = db.doc(
        DateTime(currentDate.year, currentDate.month, 15)
            .toString()).snapshots();

    return courseDocStream;
  }

}