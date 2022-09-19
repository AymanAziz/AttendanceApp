import 'package:cloud_firestore/cloud_firestore.dart';

class AttendanceRepository {
  CollectionReference db = FirebaseFirestore.instance.collection('Attendance');
  Stream<DocumentSnapshot<Object?>> getAttendance() {
    DateTime currentDateTime = DateTime.now();
    Timestamp myTimeStamp = Timestamp.fromDate(currentDateTime); //To TimeStamp
    DateTime currentDate = myTimeStamp.toDate();

    Stream<DocumentSnapshot> courseDocStream = db
        .doc(DateTime(currentDate.year, currentDate.month, currentDate.day)
            .toString())
        .snapshots();

    return courseDocStream;
  }

 Future<bool> checkTodayAttendance()
  async {
    DateTime currentDateTime = DateTime.now();
    Timestamp myTimeStamp = Timestamp.fromDate(currentDateTime); //To TimeStamp
    DateTime currentDate = myTimeStamp.toDate();

    var userDocRef = db.doc(DateTime(currentDate.year, currentDate.month, currentDate.day)
        .toString()).get();

   if (userDocRef == null) {
     return true;
   }
   else
     {
       return false;
     }
  }





//  getAttendance()   async {
//
//   DateTime currentDateTime = DateTime.now();
//   Timestamp myTimeStamp = Timestamp.fromDate(currentDateTime); //To TimeStamp
//   DateTime currentDate = myTimeStamp.toDate();
//
//
//
//   DocumentSnapshot<Object?> snapshot = await db.doc(
//       DateTime(currentDate.year, currentDate.month, currentDate.day)
//           .toString()).get();
//
//  print(snapshot);
//
//  String aa = 'test';
//
//  return aa;
//
// }

}
