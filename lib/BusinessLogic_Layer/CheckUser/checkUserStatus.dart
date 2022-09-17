import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../Data_Layer/Repository/UserRepository/UserRepository.dart';
import '../../Presentation_Layer/Screens/HomeScreen/HomeScreen.dart';
import '../../Presentation_Layer/Widget/NavBar.dart';

checkUserStatus() async {
  String? email = FirebaseAuth.instance.currentUser?.email;
  return UserRepository().checkUser(email!);
}

Widget checkUser() {
  return FutureBuilder(
      future: checkUserStatus(),
      builder: (context, userStatus) {
        if (userStatus.hasData) {
          switch (userStatus.data) {
            case "Student":
              {
                return const HomeScreen();
              }
            default:
              {
                // return const AdminHomeScreen();
                return const Navbar();


              }
          }
        }
        return Container();
      });
}

checkUserLogin(context) async {
  String userStatus = await checkUserStatus();
  switch (userStatus) {
    case "Student":
      {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (_) => const HomeScreen()));
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

