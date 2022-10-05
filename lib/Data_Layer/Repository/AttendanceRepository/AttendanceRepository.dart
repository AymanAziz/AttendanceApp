import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class AttendanceRepository {
  CollectionReference db = FirebaseFirestore.instance.collection('Attendance');
  CollectionReference dbUser = FirebaseFirestore.instance.collection('user');

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
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    DateTime startDate = DateTime.now();
    var selectDateDatabase = formatter.format(startDate!);

    var userDocRef = db.doc(selectDateDatabase).get();

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


  Future addAttendanceUser() async {

    String? email = FirebaseAuth.instance.currentUser?.email;
    var data;
    ///dia nk get data  name value
    await dbUser.doc(email).get().then((value) => {data = value.data()});
    var userDetails = {'username':data["username"]};

    ///---------------------------------------
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    DateTime startDate = DateTime.now();
    var selectDateDatabase = formatter.format(startDate!);
    ///---------------------------------------

    bool checkAttendance  = false;

    var userDocRef = db.doc(selectDateDatabase);
    var doc = await userDocRef.get();
    if (!doc.exists) {
       checkAttendance  = true;
    } else {
    }
    ///---------------------------------------



    switch(checkAttendance) {
      case true:
        {  print("save to firestore");

          ///kiv  aspect result: result nak array --> string
        ///kiv   actual result : array--> map --> string
          db.doc(selectDateDatabase).set({
          "Student": [ userDetails ]
        },SetOptions(merge: true));


        }

        break;
      default: { print("Invalid choice?? ehh");

      ///kiv  aspect result: result nak array --> string
      ///kiv  actual result: result nak array --> string
      db.doc(selectDateDatabase).update({
        "Student": FieldValue.arrayUnion(userDetails.values.toList())
      });
      }
      break;
    }

  }
}



