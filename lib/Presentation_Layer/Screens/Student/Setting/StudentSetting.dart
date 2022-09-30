import 'package:attandance_app/Presentation_Layer/Screens/ChangePasswordAdmin/ChangePasswordScreen.dart';
import 'package:attandance_app/Presentation_Layer/Screens/Student/Setting/StudentProfile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StudentSetting extends StatefulWidget{
  const StudentSetting({super.key});

  @override
  State<StatefulWidget> createState() => _StudentSetting();

}

class _StudentSetting extends State<StudentSetting>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView(
          children: [
            GestureDetector(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  const StudentProfile()),

                );
              },
              child: const Card(
                child: ListTile(title: Text('Profile'),),
              ),
            ),
            GestureDetector(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  const ChangePassword()),

                );
              },
              child: const Card(
                child: ListTile(title: Text('ChangePassword'),),
              ),
            ),
          ],
        ),
      ),
    );
  }

}