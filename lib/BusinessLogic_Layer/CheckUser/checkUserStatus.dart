import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../Data_Layer/Repository/SQliteRepository/SQliteRepository.dart';
import '../../Data_Layer/Repository/UserRepository/UserRepository.dart';

import '../../Presentation_Layer/Screens/Student/Widget/NavBarStudent.dart';
import '../../Presentation_Layer/Widget/NavBar.dart';

checkUserStatus() async {
  String? email = FirebaseAuth.instance.currentUser?.email;
  return UserRepository().checkUser(email!);
}


/// check user kt firebase and local
/// return true if student
/// return false if admin
Widget checkUser() {
  final sQLiteDb = SqliteDatabase.instance;
  return FutureBuilder(
      future: sQLiteDb.saveUserDetails(),
      builder: (context, userStatus) {
        if (userStatus.hasData) {
          switch (userStatus.data) {
            case true:
              {
                return const NavbarStudent();
              }
            default:
              {

                return const Navbar();

              }
          }
        }
        return Container();
      });

}




Widget checkUserDetailsSQLITE( ) {
  return FutureBuilder(
      future: checkUserStatus(),
      builder: (context, userStatus) {
        if (userStatus.hasData) {
          switch (userStatus.data) {
            case "Student":
              {
                return const NavbarStudent();
              }
            default:
              {
                return const Navbar();
              }
          }
        }
        return Container();
      });
}

///utk SignInScreen page
checkUserLogin(context) async {


  String userStatus = await checkUserStatus();
  switch (userStatus) {
    case "Student":
      {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (_) => const NavbarStudent()));
      }
      break;
    default:
      {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (_) => const Navbar()));
      }
  }

}

