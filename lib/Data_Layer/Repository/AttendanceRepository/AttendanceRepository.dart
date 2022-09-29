import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class AttendanceRepository {
  CollectionReference db = FirebaseFirestore.instance.collection('Attendance');

  Stream<DocumentSnapshot<Object?>> getAttendance() {
    DateTime currentDateTime = DateTime.now();
    Timestamp myTimeStamp = Timestamp.fromDate(currentDateTime); //To TimeStamp
    DateTime currentDate = myTimeStamp.toDate();


    print(DateTime(currentDate.year, currentDate.month, 27));

    var courseDocStream = db
        .doc(DateTime(currentDate.year, currentDate.month, 0)
        .toString())
        .snapshots();

    return courseDocStream;
  }


  Future<bool> checkTodayAttendance() async {
    DateTime currentDateTime = DateTime.now();
    Timestamp myTimeStamp = Timestamp.fromDate(currentDateTime); //To TimeStamp
    DateTime currentDate = myTimeStamp.toDate();

    var userDocRef = db.doc(DateTime(currentDate.year, currentDate.month, 15)
        .toString()).get();

    if (userDocRef == null) {
      return true;
    }
    else {
      return false;
    }
  }

  Stream<DocumentSnapshot<Object?>> getAttendanceTest(selectDateDatabase) {
    DateTime currentDateTime = DateTime.now();
    Timestamp myTimeStamp = Timestamp.fromDate(currentDateTime); //To TimeStamp
    DateTime currentDate = myTimeStamp.toDate();

    print(DateTime(currentDate.year, currentDate.month, 27));
    print("${currentDate.year}-${currentDate.month}-0");

    if(selectDateDatabase == "")
      {
        var courseDocStream = FirebaseFirestore.instance.collection('noValue')
        // .doc("${currentDate.year}-${currentDate.month}-0")
            .doc("V1KydKOcAjjQ72t3EFcg")
            .snapshots();
        return courseDocStream;
      }
    else
      {
        var courseDocStream = db
        // .doc("${currentDate.year}-${currentDate.month}-0")
            .doc(selectDateDatabase)
            .snapshots();
        return courseDocStream;
      }
  }

  Future<int> countUser() async {

    QuerySnapshot myDoc = await FirebaseFirestore.instance.collection('Attendance').get();
    List<DocumentSnapshot> myDocCount = myDoc.docs;
    print(myDocCount.length);
    return myDocCount.length;// Count of Documents in Collection
  }
}



