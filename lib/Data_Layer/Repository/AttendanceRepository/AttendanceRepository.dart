import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

import '../../Model/UserModel/userModel.dart';

class AttendanceRepository {
  CollectionReference db = FirebaseFirestore.instance.collection('Attendance');
  CollectionReference dbUser = FirebaseFirestore.instance.collection('user');

  Stream<DocumentSnapshot<Object?>> getAttendance() {
    DateTime currentDateTime = DateTime.now();
    Timestamp myTimeStamp = Timestamp.fromDate(currentDateTime); //To TimeStamp
    DateTime currentDate = myTimeStamp.toDate();

    print(DateTime(currentDate.year, currentDate.month, 27));

    var courseDocStream = db
        .doc(DateTime(currentDate.year, currentDate.month, 0).toString())
        .snapshots();

    return courseDocStream;
  }

  Future<bool> checkTodayAttendance() async {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    DateTime startDate = DateTime.now();
    var selectDateDatabase = formatter.format(startDate!);

    var userDocRef = db.doc(selectDateDatabase).snapshots();

    if (await userDocRef.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  Stream<DocumentSnapshot<Object?>> getAttendanceTest(
      selectDateDatabase, pressDateButton) {
    String selectDate = '';
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    DateTime aa = DateTime.now();
    selectDate = formatter.format(aa!);

    switch (pressDateButton) {
      case false:
        {
          print('current date: $selectDate');
          var courseDocStream = db.doc(selectDate).snapshots();
          return courseDocStream;
        }
      default:
        {
          switch (selectDateDatabase) {
            case '':
              {
                var courseDocStream = FirebaseFirestore.instance
                    .collection('noValue')
                    // .doc("${currentDate.year}-${currentDate.month}-0")
                    .doc("V1KydKOcAjjQ72t3EFcg")
                    .snapshots();
                return courseDocStream;
              }
            default:
              {
                var courseDocStream = db.doc(selectDateDatabase).snapshots();
                return courseDocStream;
              }
          }
        }
    }
  }

  Future<int> countUser() async {
    int size = 0;
    await FirebaseFirestore.instance.collection('user').get().then((snap) {
      size = snap.size;
    });
    return size;
  }

  ///display list user
  Future<List<UserModel>> listUsers() async {
    List<UserModel> userList = [];
    try {
      final users = await FirebaseFirestore.instance.collection('user').get();

      for (var value in users.docs) {
        userList.add(UserModel.fromJson(value.data()));
      }
      return userList;
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print("Failed with error $e");
      }
      return userList;
    } catch (e) {
      throw Exception(e.toString());
    }
  }



///utk hasif
  Future addAttendanceUser() async {
    String? email = FirebaseAuth.instance.currentUser?.email;
    var data;

    ///dia nk get data  name value
    await dbUser.doc(email).get().then((value) => {data = value.data()});
    var userDetails = {'username': data["username"]};

    ///---------------------------------------
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    DateTime startDate = DateTime.now();
    var selectDateDatabase = formatter.format(startDate!);

    ///---------------------------------------

    bool checkAttendance = false;

    var userDocRef = db.doc(selectDateDatabase);
    var doc = await userDocRef.get();
    if (!doc.exists) {
      checkAttendance = true;
    } else {}

    ///---------------------------------------

    switch (checkAttendance) {
      case true:
        {
          print("save to firestore");

          /// kt sini ko save kt sqlite if n only if ( data tu x de)

          ///kiv  aspect result: result nak array --> string
          ///kiv   actual result : array--> map --> string
          db.doc(selectDateDatabase).set({
            "Student": [userDetails]
          }, SetOptions(merge: true));
        }

        break;
      default:
        {
          print("Invalid choice?? ehh");

          /// kt sini ko save kt sqlite if n only if ( data tu x de)

          ///kiv  aspect result: result nak array --> string
          ///kiv  actual result: result nak array --> string
          db.doc(selectDateDatabase).update(
              {"Student": FieldValue.arrayUnion(userDetails.values.toList())});
        }
        break;
    }
  }
}
