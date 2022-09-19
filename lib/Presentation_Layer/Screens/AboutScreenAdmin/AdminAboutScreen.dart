import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../../BusinessLogic_Layer/AuthBloc/auth_bloc.dart';
import '../AttendanceAdmin/GetAttendanceScreen.dart';
import '../ChangePasswordAdmin/ChangePasswordScreen.dart';
import '../ProfilePageAdmin/AdminProfilePageScreen.dart';
import '../login_and_register/SignInScreen.dart';
class AdminAboutScreen extends StatefulWidget {
  const AdminAboutScreen({Key? key}) : super(key: key);

  @override
  State<AdminAboutScreen> createState() => _AdminAboutScreenState();
}

class _AdminAboutScreenState extends State<AdminAboutScreen> {


  showSuccessAlert(BuildContext context, String message) {
    Alert(
      context: context,
      type: AlertType.success,
      title: "Success",
      desc: message,
      buttons: [
        DialogButton(
          onPressed: () => Navigator.pop(context),
          width: 120,
          child: const Text(
            "OK",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        )
      ],
    ).show();
  }
  showErrorAlert(BuildContext context, String message) {
    Alert(
      context: context,
      type: AlertType.error,
      title: "Error",
      desc: "$message",
      buttons: [
        DialogButton(
          onPressed: () => Navigator.pop(context),
          width: 120,
          child: const Text(
            "OK",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        )
      ],
    ).show();
  }



  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: SafeArea(child: Scaffold(
        appBar: AppBar(title: const Text('About'),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,),
        body: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) async {
            if (state is UnAuthenticated) {
              // Navigate to the sign in screen when the user Signs Out
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const SignInScreen()),
                    (route) => false,
              );
            }
          },
          child:ListView(
            children:  [
              GestureDetector(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  const AdminProfilePageScreen()),

                  );
                },
                child: const Card(
                  child: ListTile(title: Text('Profile'),),
                ),
              ),//user profile
              GestureDetector(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  const ChangePassword()),

                  );
                },
                child: const Card(
                  child: ListTile(title: Text('Change Password'),),
                ),
              ),//change password
              GestureDetector(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  const GetAttendanceScreen()),

                  );
                },
                child: const Card(
                  child: ListTile(title: Text('Attendance Report'),),
                ),
              ),//attendance report
              GestureDetector(
                onTap: (){
                  _showDialog(context);
                },
                child: const Card(
                  child: ListTile(title: Text('Logout'),),
                ),
              )//logout

            ],
          ), )
      )),
    );
  }

  _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Column(
          children: [
            Expanded(
              child: AlertDialog(
                title: const Text('Log Out'),
                content: const Text('Do you  want to Log Out?'),
                actions: [
                  TextButton(
                    onPressed: () {

                      Navigator.of(context).pop();
                    },
                    child: const Text('NO', style: TextStyle(color: Colors.black),),
                  ),
                  TextButton(
                    onPressed: () {
                      // Signing out the user
                      context.read<AuthBloc>().add(SignOutRequested());
                      //Navigator.of(context).pop();
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                              const SignInScreen()),
                              (Route<dynamic> route) => false);
                    },
                    child: const Text('YES', style: TextStyle(color: Colors.black),),
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }
}

