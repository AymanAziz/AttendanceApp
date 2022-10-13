import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_picker/Picker.dart';
import 'package:intl/intl.dart';

import '../../../../BusinessLogic_Layer/AuthBloc/auth_bloc.dart';
import '../../../../BusinessLogic_Layer/UserBloc/user_bloc.dart';
import '../../../../Data_Layer/Repository/AttendanceRepository/AttendanceRepository.dart';
import '../../../Widget/CurveWidgetHomePage.dart';
import '../../login_and_register/SignInScreen.dart';

class AdminHomePageScreen extends StatefulWidget {
  const AdminHomePageScreen({Key? key}) : super(key: key);

  @override
  State<AdminHomePageScreen> createState() => _AdminHomePageScreenState();
}

class _AdminHomePageScreenState extends State<AdminHomePageScreen> {

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  UserBloc userBloc = UserBloc();

  DateTime startDate = DateTime.now();
  final DateFormat formatter = DateFormat('yyyy-MM-dd');

  int totalUser = 0;
  String selectDate = '';
  String selectDateDatabase = '';
  bool pressDateButton = false;

  bool _canShowButton = true;

  void hideWidget() {
    if (selectDate == '') {
    } else {
      setState(() {
        _canShowButton = false;
      });
    }
  }

  showPickerDate(BuildContext context, date) {
    Picker(
        hideHeader: true,
        adapter: DateTimePickerAdapter(),
        title: const Text("Select Data"),
        selectedTextStyle: const TextStyle(color: Colors.blue),
        onConfirm: (Picker picker, List value) {
          setState(() {
            selectDate ='';
            DateTime? aa = (picker.adapter as DateTimePickerAdapter).value;
            selectDateDatabase = formatter.format(aa!);
            print('ini data kt db $selectDateDatabase');
            selectDate = formatter.format(aa!);
            hideWidget();
          });
          // print((picker.adapter as DateTimePickerAdapter).value);
        }).showDialog(context);
  }




  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: SafeArea(
        child: Scaffold(
          extendBodyBehindAppBar: true,
          resizeToAvoidBottomInset: false, //new line
          appBar: AppBar(
            elevation: 0,
            backgroundColor: const Color.fromARGB(255, 4, 199, 199),
          ),
          body: BlocListener<AuthBloc, AuthState>(
              listener: (context, state) async {
                if (state is UnAuthenticated) {
                  // Navigate to the sign in screen when the user Signs Out
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (context) => const SignInScreen()),
                        (route) => false,
                  );
                }
              },
              child: BlocProvider<UserBloc>(create: (context){ userBloc.add(CountUserFireStore()); return userBloc;},
                child:  BlocListener<UserBloc, UserState>(
                    listener: (context, state) async {

                      if (state is UserLoading) {

                      }
                      else if (state is TotalUserState)
                      {
                        totalUser = state.totalUser;
                      }
                    },
                    child:
                    StreamBuilder<DocumentSnapshot>(
                        stream: AttendanceRepository().getAttendanceTest(selectDateDatabase,pressDateButton),
                        builder: (context, AsyncSnapshot<DocumentSnapshot> asyncSnapshot) {

                          switch (asyncSnapshot.connectionState) {
                            case ConnectionState.none:
                            case ConnectionState.active:
                            case ConnectionState.waiting:
                            case ConnectionState.done:
                              {

                                if (!asyncSnapshot.hasData) {
                                  return const Center(child: CircularProgressIndicator());
                                } else if (!asyncSnapshot.data!.exists) ///if document tu x de
                                {
                                  String totalAttendance = "0";
                                  return ListView(
                                    children: [
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: ElevatedButton.icon(
                                              style: ElevatedButton.styleFrom(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(12), // <-- Radius
                                                ),
                                              ),
                                              onPressed: () {
                                                showPickerDate(context, selectDate);
                                                pressDateButton = true;
                                              },
                                              icon: const Icon(Icons.date_range),
                                              label: const Text('Get date'),
                                            ),
                                          ),
                                        ],
                                      ),
                                      /// date button and date in text
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 10),
                                        child: Card(
                                          color: const Color.fromARGB(255, 3, 37, 76),
                                          elevation: 5,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(12), // <-- Radius
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(5),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children:  [
                                                    const Padding(
                                                      padding: EdgeInsets.only(left: 10),
                                                      child: Text(
                                                        'Total attendance ',
                                                        style: TextStyle(
                                                            fontWeight: FontWeight.w400,
                                                            fontSize: 25,
                                                            color: Colors.white),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.only(left: 10),
                                                      child: _canShowButton
                                                          ? const SizedBox.shrink()
                                                          : ElevatedButton(
                                                        onHover: (value) => false,
                                                        onFocusChange: (value) => false,
                                                        onPressed: null,
                                                        style: ElevatedButton.styleFrom(
                                                          disabledForegroundColor: Colors.white,
                                                          disabledBackgroundColor:
                                                          const Color.fromARGB(
                                                              255, 33, 150, 243),
                                                        ),
                                                        child: Text(selectDate),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                ConstrainedBox(
                                                  constraints: const BoxConstraints.tightFor(
                                                      width: 100, height: 100),
                                                  child: ElevatedButton(
                                                    onHover: (value) => false,
                                                    onFocusChange: (value) => false,
                                                    onPressed: null,
                                                    style: ElevatedButton.styleFrom(
                                                        disabledForegroundColor: Colors.white,
                                                        disabledBackgroundColor: const Color.fromARGB(
                                                            255, 24, 123, 205) ),
                                                    child: Text(totalAttendance, style: const TextStyle(
                                                        fontWeight: FontWeight.w400,
                                                        color: Color.fromARGB(255, 255, 255, 255) ,
                                                        fontSize: 19),),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      ///display list of attendance
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 10),
                                        child: Card(
                                          color: const Color.fromARGB(255, 3, 37, 76),
                                          elevation: 5,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(12), // <-- Radius
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(5),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children:  [
                                                    const Padding(
                                                      padding: EdgeInsets.only(left: 10),
                                                      child: Text(
                                                        'Total Users',
                                                        style: TextStyle(
                                                            fontWeight: FontWeight.w400,
                                                            fontSize: 25,
                                                            color: Colors.white),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.only(left: 10),
                                                      child: _canShowButton
                                                          ? const SizedBox.shrink()
                                                          : ElevatedButton(
                                                        onHover: (value) => false,
                                                        onFocusChange: (value) => false,
                                                        onPressed: null,
                                                        style: ElevatedButton.styleFrom(
                                                          disabledForegroundColor: Colors.white,
                                                          disabledBackgroundColor:
                                                          const Color.fromARGB(
                                                              255, 33, 150, 243),
                                                        ),
                                                        child: Text(selectDate),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                ConstrainedBox(
                                                  constraints: const BoxConstraints.tightFor(
                                                      width: 100, height: 100),
                                                  child: ElevatedButton(
                                                    onHover: (value) => false,
                                                    onFocusChange: (value) => false,
                                                    onPressed: null,
                                                    style: ElevatedButton.styleFrom(
                                                        disabledForegroundColor: Colors.white,
                                                        disabledBackgroundColor: const Color.fromARGB(
                                                            255, 24, 123, 205) ),
                                                    child: Text(totalUser.toString(), style: const TextStyle(
                                                        fontWeight: FontWeight.w400,
                                                        color: Color.fromARGB(255, 255, 255, 255) ,
                                                        fontSize: 19),),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      ///display list of user
                                      // Card(
                                      //   child: Padding(
                                      //       padding: const EdgeInsets.all(12),
                                      //       child: Column(
                                      //         children: [
                                      //           Row(
                                      //             mainAxisAlignment: MainAxisAlignment.start,
                                      //             children: const [
                                      //               Text(
                                      //                 'List Student',
                                      //                 style: TextStyle(
                                      //                     fontWeight: FontWeight.bold,
                                      //                     fontSize: 17),
                                      //               ),
                                      //             ],
                                      //           ),
                                      //           const SizedBox(
                                      //             height: 10,
                                      //           ),
                                      //           ListView.builder(
                                      //             shrinkWrap: true,
                                      //             itemCount: listAttendance != null
                                      //                 ? listAttendance.length
                                      //                 : 0,
                                      //             itemBuilder: (BuildContext context, int index) {
                                      //               return Column(
                                      //                 children: [
                                      //                   ListTile(
                                      //                     title: Text(
                                      //                         listAttendance[index]['email']),
                                      //                   ),
                                      //                   const Divider()
                                      //                 ],
                                      //               );
                                      //             },
                                      //           ),
                                      //         ],
                                      //       )),
                                      // )
                                      //
                                      // ///display list of student
                                    ],
                                  );
                                } else if (asyncSnapshot.hasError) {
                                  return const Text('error');
                                } else {

                                  var attendanceDocument = asyncSnapshot.data!;
                                  var listAttendance = attendanceDocument["Student"];
                                  String totalAttendance = attendanceDocument["Student"].length.toString();

                                  print("list student : ${listAttendance.length}");
                                  return ListView(
                                    children: [
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: ElevatedButton.icon(
                                              style: ElevatedButton.styleFrom(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(12), // <-- Radius
                                                ),
                                              ),
                                              onPressed: () {
                                                showPickerDate(context, selectDate);
                                                pressDateButton = true;
                                              },
                                              icon: const Icon(Icons.date_range),
                                              label: const Text('Get date'),
                                            ),
                                          ),
                                        ],
                                      ),
                                      /// date button and date in text
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 10),
                                        child: Card(
                                          color: const Color.fromARGB(255, 3, 37, 76),
                                          elevation: 5,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(12), // <-- Radius
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(5),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children:  [
                                                    const Padding(
                                                      padding: EdgeInsets.only(left: 10),
                                                      child: Text(
                                                        'Total attendance ',
                                                        style: TextStyle(
                                                            fontWeight: FontWeight.w400,
                                                            fontSize: 25,
                                                            color: Colors.white),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.only(left: 10),
                                                      child: _canShowButton
                                                          ? const SizedBox.shrink()
                                                          : ElevatedButton(
                                                        onHover: (value) => false,
                                                        onFocusChange: (value) => false,
                                                        onPressed: null,
                                                        style: ElevatedButton.styleFrom(
                                                          disabledForegroundColor: Colors.white,
                                                          disabledBackgroundColor:
                                                          const Color.fromARGB(
                                                              255, 33, 150, 243),
                                                        ),
                                                        child: Text(selectDate),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                ConstrainedBox(
                                                  constraints: const BoxConstraints.tightFor(
                                                      width: 100, height: 100),
                                                  child: ElevatedButton(
                                                    onHover: (value) => false,
                                                    onFocusChange: (value) => false,
                                                    onPressed: null,
                                                    style: ElevatedButton.styleFrom(
                                                        disabledForegroundColor: Colors.white,
                                                        disabledBackgroundColor: const Color.fromARGB(
                                                            255, 24, 123, 205) ),
                                                    child: Text(totalAttendance, style: const TextStyle(
                                                        fontWeight: FontWeight.w400,
                                                        color: Color.fromARGB(255, 255, 255, 255) ,
                                                        fontSize: 19),),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      ///display list of attendance
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 10),
                                        child: Card(
                                          color: const Color.fromARGB(255, 3, 37, 76),
                                          elevation: 5,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(12), // <-- Radius
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(5),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children:  [
                                                    const Padding(
                                                      padding: EdgeInsets.only(left: 10),
                                                      child: Text(
                                                        'Total Users',
                                                        style: TextStyle(
                                                            fontWeight: FontWeight.w400,
                                                            fontSize: 25,
                                                            color: Colors.white),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.only(left: 10),
                                                      child: _canShowButton
                                                          ? const SizedBox.shrink()
                                                          : ElevatedButton(
                                                        onHover: (value) => false,
                                                        onFocusChange: (value) => false,
                                                        onPressed: null,
                                                        style: ElevatedButton.styleFrom(
                                                          disabledForegroundColor: Colors.white,
                                                          disabledBackgroundColor:
                                                          const Color.fromARGB(
                                                              255, 33, 150, 243),
                                                        ),
                                                        child: Text(selectDate),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                ConstrainedBox(
                                                  constraints: const BoxConstraints.tightFor(
                                                      width: 100, height: 100),
                                                  child: ElevatedButton(
                                                    onHover: (value) => false,
                                                    onFocusChange: (value) => false,
                                                    onPressed: null,
                                                    style: ElevatedButton.styleFrom(
                                                        disabledForegroundColor: Colors.white,
                                                        disabledBackgroundColor: const Color.fromARGB(
                                                            255, 24, 123, 205) ),
                                                    child: Text(totalUser.toString(), style: const TextStyle(
                                                        fontWeight: FontWeight.w400,
                                                        color: Color.fromARGB(255, 255, 255, 255) ,
                                                        fontSize: 19),),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      ///display list of attendance
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Card(
                                        child: Padding(
                                            padding: const EdgeInsets.all(12),
                                            child: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: const [
                                                    Text(
                                                      'List Student',
                                                      style: TextStyle(
                                                          fontWeight: FontWeight.bold,
                                                          fontSize: 17),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                ListView.builder(
                                                  shrinkWrap: true,
                                                  itemCount: listAttendance.isEmpty
                                                      ? 0
                                                      : listAttendance.length,
                                                  itemBuilder: (BuildContext context, int index) {
                                                    print("list email : ${listAttendance[index]['email']}");
                                                    return Column(
                                                      children: [
                                                        ListTile(
                                                          title: Text(
                                                              listAttendance[index]['email']),
                                                        ),
                                                        const Divider()
                                                      ],
                                                    );
                                                  },
                                                ),
                                              ],
                                            )),
                                      )
                                    ],
                                  );
                                }
                              }
                          }



                        })),
              )),
        ),
      ),
    );
  }
}

