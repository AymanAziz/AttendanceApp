import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:select_form_field/select_form_field.dart';

import '../../../../../BusinessLogic_Layer/UserBloc/user_bloc.dart';
import '../../../../../Data_Layer/Model/UserModel/userModel.dart';
import '../../../login_and_register/SignInScreen.dart';
import '../../AboutScreenAdmin/AdminAboutScreen.dart';
import '../ListUser/ListUser.dart';


class UpdateUserStatusScreen extends StatefulWidget {
  const UpdateUserStatusScreen({Key? key}) : super(key: key);

  @override
  State<UpdateUserStatusScreen> createState() => _UpdateUserStatusScreenState();
}

class _UpdateUserStatusScreenState extends State<UpdateUserStatusScreen> {

  ///declare bloc
  final UserBloc userBloc = UserBloc();

  ///form
  final _formKey = GlobalKey<FormState>();

  ///declare text controller
  TextEditingController isStudent = TextEditingController();


  ///for user status
  final List<Map<String, dynamic>> _items = [
    {
      'value': 'Student',
      'label': 'Student',
    },
    {
      'value': 'Admin',
      'label': 'Admin',
    },];

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    //80% of screen width
    double cWidth = MediaQuery.of(context).size.width * 0.8;

    final todo = ModalRoute.of(context)?.settings.arguments as Map;
    // int a = int.parse(todo['drugId']);
    String username = todo['name'];
    String email = todo['email'];
    String userID = todo['userID'];
    String telNumber = todo['telNumber'];
     isStudent.text = todo['isStudent'];
    String checkIfAdmin = todo['isStudent'];


    return SafeArea(child: Scaffold(
      appBar: AppBar(title: const Text('Update Status'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,),
      body:  SingleChildScrollView(
    child: Padding(
    padding: const EdgeInsets.all(12),
      child: Card(
          elevation: 1,
          child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment
                      .start,
                  children: [
                    SizedBox(
                      width: cWidth,
                      child: TextFormField(
                        readOnly: true,
                        initialValue: username,
                        enabled: false,
                        decoration: const InputDecoration(
                          labelText: 'Names',
                        ),
                      ),
                    ), ///name
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: cWidth,
                      child: TextFormField(
                        readOnly: true,
                        enabled: false,
                        initialValue: email,
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'Email',
                        ),
                      ),
                    ), ///email
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: cWidth,
                      child: TextFormField(
                        readOnly: true,
                        enabled: false,
                        initialValue: userID,
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'Student ID/ Staff ID',
                        ),
                      ),
                    ), ///userID
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: cWidth,
                      child: TextFormField(
                        readOnly: true,
                        enabled: false,
                        initialValue: telNumber,
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'Phone Number',
                        ),
                      ),
                    ), ///tel number
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: cWidth,
                      child: SelectFormField(
                        type: SelectFormFieldType
                            .dropdown,
                        labelText: 'Status',
                        controller: isStudent.text
                            .isEmpty ? null : isStudent,
                        items: _items,
                        onChanged: (val) =>
                        isStudent.text = val,
                        onSaved: (val) =>
                        isStudent.text = val!,
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty) {
                            return 'Please select Status';
                          }
                          isStudent.text = value;
                          return null;
                        },
                      ),
                    ), ///status
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding:
                      const EdgeInsets.fromLTRB(
                          70, 30, 70, 10),
                      child: ElevatedButton(

                        onPressed: () async {
                          if (_formKey.currentState!
                              .validate()) {
                            try {
                              _formKey.currentState!
                                  .save();


                              UserModel userModel = UserModel(
                                email: email,
                                name: username,
                                isStudent: isStudent
                                    .text,
                                telNumber: telNumber,
                                userID: userID,
                              );

                              /// check If Admin
                              String? checkMail = FirebaseAuth.instance.currentUser!.email!;
                              if(email == checkMail)
                                {
                                  switch (isStudent
                                      .text ) {
                                    case "Student":
                                      {
                                        _showDialog(context,userModel,userBloc);
                                      }
                                      break;
                                    default:
                                      {
                                        ///insert data using bloc
                                        userBloc.add(
                                            GetUserUpdateStatus(
                                                userModel));
                                      }
                                  }
                                }
                              else
                                {
                                  userBloc.add(
                                      GetUserUpdateStatus(
                                          userModel));

                                  ScaffoldMessenger.of(
                                      context)
                                      .showSnackBar(
                                    const SnackBar(
                                      content:
                                      Text(
                                          'Data Updated Successfully'),
                                    ),
                                  );
                                  // Navigator.pop(context);

                                  Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                        const AdminAboutScreen(),
                                        settings:
                                        const RouteSettings(                                    )
                                    ),
                                        (_) => false,
                                  );
                                }









                            } on FirebaseAuthException catch (e) {
                              if (e.code ==
                                  'user-not-found') {
                                ScaffoldMessenger.of(
                                    context)
                                    .showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                          'No user found'),
                                      backgroundColor: Colors
                                          .red,
                                    )
                                );
                              } else if (e.code ==
                                  'wrong-password') {
                                ScaffoldMessenger.of(
                                    context)
                                    .showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                          'Wrong password provided'),
                                      backgroundColor: Colors
                                          .red,
                                    )
                                );
                              }
                            }
                          }
                        },
                        child: const Text('Submit'),
                      ),
                    ),
                  ],
                ),))
      ),
    ),
    )
    ));
  }

}
_showDialog(BuildContext context,userModel,userBloc) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Column(
        children: [
          Expanded(
            child: AlertDialog(
              title: const Text('Confirmation'),
              content: const Text('Do you  want to  switch to user status?'),
              actions: [
                TextButton(
                  onPressed: () {

                    Navigator.of(context).pop();
                  },
                  child: const Text('NO', style: TextStyle(color: Colors.black),),
                ),
                TextButton(
                  onPressed: () {
                    /// Signing out the user
                    userBloc.add(
                        GetUserUpdateStatus(
                            userModel));
                    ///Navigator.of(context).pop();
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