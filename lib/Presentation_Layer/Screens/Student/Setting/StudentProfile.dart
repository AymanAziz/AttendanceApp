import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:select_form_field/select_form_field.dart';

import '../../../../BusinessLogic_Layer/UserBloc/user_bloc.dart';
import '../../../../Data_Layer/Model/UserModel/userModel.dart';
import '../../../../Data_Layer/Repository/UserRepository/UserRepository.dart';

class StudentProfile extends StatefulWidget {
  const StudentProfile({Key? key}) : super(key: key);

  @override
  State<StudentProfile> createState() => _StudentProfile();
}

class _StudentProfile extends State<StudentProfile> {

  //declare bloc
  final UserBloc userBloc = UserBloc();

  //form
  final _formKey = GlobalKey<FormState>();

  TextEditingController email = TextEditingController();
  TextEditingController isStudent = TextEditingController();
  TextEditingController telNumber = TextEditingController();
  TextEditingController userID = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController verPassword = TextEditingController();

  final List<Map<String, dynamic>> _items = [
    {
      'value': 'Student',
      'label': 'Student',
    },
    {
      'value': 'Admin',
      'label': 'Admin',
    },];

  final user = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    //80% of screen width
    double cWidth = MediaQuery.of(context).size.width * 0.8;

    return SafeArea(child: Scaffold(
      appBar: AppBar(title: const Text('Profile Page'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,),
      body: StreamBuilder<DocumentSnapshot>(stream: UserRepository().specificUser(),
          builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState
                .active) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }
              else
              {
                var userDocument = snapshot.data;
                username.text = userDocument!["username"];
                userID.text = userDocument["userID"];
                email.text = userDocument["email"];
                telNumber.text = userDocument["telNumber"];
                isStudent.text = userDocument["isStudent"];


                // return Text(userDocument!["email"]);
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Card(
                        elevation: 1,
                        child:  Form(
                            key: _formKey,
                            child: Padding(padding: const EdgeInsets.all(16),child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: cWidth,
                                  child: TextFormField(
                                    controller: username,
                                    decoration: const InputDecoration(
                                      border: UnderlineInputBorder(),
                                      labelText: 'Names',
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter name';
                                      }
                                      return null;
                                    },
                                    onSaved: (value) => username.text = value!,
                                  ),
                                ),//name
                                const SizedBox(
                                  height: 20,
                                ),
                                SizedBox(
                                  width: cWidth,
                                  child: TextFormField(
                                    controller: email,
                                    decoration: const InputDecoration(
                                      border: UnderlineInputBorder(),
                                      labelText: 'Email',
                                    ),
                                    validator: (value) {
                                      return value != null && !EmailValidator.validate(value)
                                          ? 'Please enter valid email'
                                          : null;
                                    },
                                  ),
                                ),//email

                                const SizedBox(
                                  height: 20,
                                ),
                                SizedBox(
                                  width: cWidth,
                                  child: SelectFormField(
                                    type: SelectFormFieldType.dropdown,
                                    labelText: 'Status',
                                    controller: isStudent.text.isEmpty?null:isStudent,
                                    items: _items,
                                    onChanged: (val) => isStudent.text = val,
                                    onSaved: (val) => isStudent.text = val!,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please select Status';
                                      }
                                      isStudent.text = value;
                                      return null;
                                    },
                                  ),
                                ) ,//gender
                                const SizedBox(
                                  height: 20,
                                ),
                                SizedBox(
                                  width: cWidth,
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    controller: userID,
                                    decoration: const InputDecoration(
                                      border: UnderlineInputBorder(),
                                      labelText: 'Student ID/ Staff ID',
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter Student ID/ Staff ID';
                                      }
                                      userID.text = value.toString();
                                      return null;
                                    },
                                  ),
                                ),//userID
                                const SizedBox(
                                  height: 20,
                                ),
                                SizedBox(
                                  width: cWidth,
                                  child: TextFormField(
                                    controller: telNumber,
                                    decoration: const InputDecoration(
                                      border: UnderlineInputBorder(),
                                      labelText: 'Phone Number',
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter phone Number';
                                      }
                                      telNumber.text = value;
                                      return null;
                                    },
                                  ),
                                ),//notel
                                const SizedBox(
                                  height: 20,
                                ),
                                SizedBox(
                                  width: cWidth,
                                  child: TextFormField(
                                    controller: verPassword,
                                    obscureText: true,
                                    decoration: const InputDecoration(
                                      border: UnderlineInputBorder(),
                                      labelText: 'Verify Password',
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your password before adding profile information.';
                                      }
                                      verPassword.text = value;
                                      return null;
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Padding(
                                  padding:
                                  const EdgeInsets.fromLTRB(70, 30, 70, 10),
                                  child: ElevatedButton(

                                    onPressed: () async {
                                      if (_formKey.currentState!.validate()) {
                                        try{
                                          _formKey.currentState!.save();

                                          await FirebaseAuth.instance.signInWithEmailAndPassword(
                                            email: user.email!,
                                            password: verPassword.text,
                                          );

                                          user.updateEmail(email.text).then((_){
                                            UserModel usermodel = UserModel(
                                              email: user.email!,
                                              name:  username.text,
                                              isStudent: isStudent.text,
                                              telNumber: telNumber.text,
                                              userID: userID.text,
                                            );

                                            userModelSQLite userModelSqlite = userModelSQLite(
                                              username: username.text,
                                              email: user.email!,
                                              userID: userID.text,
                                              telNumber: telNumber.text,
                                              isStudent: isStudent.text,
                                            );

                                            //insert data using bloc
                                            userBloc.add(GetUserUpdateDb(usermodel, userModelSqlite));



                                            ScaffoldMessenger.of(context).showSnackBar(
                                              const SnackBar(
                                                content:
                                                Text('Data Updated Successfully'),
                                              ),
                                            );
                                            Navigator.pop(context);
                                          }).catchError((error){
                                            ScaffoldMessenger.of(context).showSnackBar(
                                                const SnackBar(content: Text('Please enter your valid password'))
                                            );

                                            print("Email can't be changed" + error.toString());
                                            //This might happen, when the wrong password is in, the user isn't found, or if the user hasn't logged in recently.
                                          });
                                        }on FirebaseAuthException catch (e) {
                                          if (e.code == 'user-not-found') {
                                            ScaffoldMessenger.of(context).showSnackBar(
                                                const SnackBar(content: Text('No user found'),
                                                  backgroundColor: Colors.red,
                                                )
                                            );
                                          } else if (e.code == 'wrong-password') {
                                            ScaffoldMessenger.of(context).showSnackBar(
                                                const SnackBar(content: Text('Wrong password provided'),
                                                  backgroundColor: Colors.red,
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
                );
              }

            } else {
              return Container();
            }
          }),
    ));
  }
}