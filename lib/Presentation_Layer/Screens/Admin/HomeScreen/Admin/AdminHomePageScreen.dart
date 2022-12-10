import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_picker/Picker.dart';
import 'package:intl/intl.dart';

import '../../../../../BusinessLogic_Layer/AuthBloc/auth_bloc.dart';
import '../../../../../BusinessLogic_Layer/UserBloc/user_bloc.dart';
import '../../../../../Data_Layer/Repository/AttendanceRepository/AttendanceRepository.dart';
import '../../../../Widget/CurveWidgetHomePage.dart';
import '../../../login_and_register/SignInScreen.dart';

import 'GeneratePdf.dart';

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
  final DateFormat dateView = DateFormat('dd-MM-yyyy');

  @override
  void initState() {
    super.initState();
    selectDate1 = dateView.format(startDate);
  }


  int totalUser = 0;
  String selectDate1 = '';
  String selectDateDatabase2 = '';
  String selectDate = '';
  String selectDateDatabase = 'A';
  bool pressDateButton = false;

   // for button
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
        onCancel:(){

        },
        adapter: DateTimePickerAdapter(),
        title: const Text("Select Data"),
        selectedTextStyle: const TextStyle(color: Colors.blue),
        onConfirm: (Picker picker, List value) {
          setState(() {
            selectDate ='';
            DateTime? aa = (picker.adapter as DateTimePickerAdapter).value;
            selectDateDatabase = formatter.format(aa!);
            selectDateDatabase2 = dateView.format(aa);
            if (kDebugMode) {
              print('ini data kt db $selectDateDatabase');
            }
            if (kDebugMode) {
              print('page : AdminHomePageScreen');
            }
            selectDate = dateView.format(aa);
            hideWidget();
          });
          // print((picker.adapter as DateTimePickerAdapter).value);
        }).showDialog(context);
  }




  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // FocusScopeNode currentFocus = FocusScope.of(context);
        // if (!currentFocus.hasPrimaryFocus) {
        //   currentFocus.unfocus();
        // }
      },
      child: SafeArea(
        child: Scaffold(
          extendBodyBehindAppBar: true,
          resizeToAvoidBottomInset: false, //new line
          appBar: AppBar(
            elevation: 0,
            backgroundColor: const Color.fromARGB(255, 3, 37, 76),
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
              child: Container(
                height: double.infinity,
                color: Colors.white,
                child:   StreamBuilder<DocumentSnapshot>(
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
                                  shrinkWrap: true,
                                  children: [
                                    Stack(
                                      children: [
                                        CurveWidgetHomePage(
                                          //call from widget
                                          child: Container(
                                            width: double.infinity,
                                            height: 120,
                                            color: const Color.fromARGB(255, 3, 37, 76),
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                              children: [
                                                Container(
                                                  padding: const EdgeInsets.only(top: 0),
                                                  child: const Text(
                                                    'Attendance',
                                                    style: TextStyle(
                                                        fontSize: 30,
                                                        fontWeight: FontWeight.bold,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(top: 0),
                                                  child:  ElevatedButton.icon(
                                                    style: ElevatedButton.styleFrom(
                                                      backgroundColor: Colors.blue,
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
                                                    label:checkAttendanceDateButton(selectDate1,selectDateDatabase2),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: double.infinity,
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(top: 0),
                                            child:  ElevatedButton.icon(
                                              style: ElevatedButton.styleFrom(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                    BorderRadius.circular(12), // <-- Radius
                                                  ),
                                                  disabledForegroundColor: Colors.black,
                                                  disabledBackgroundColor:
                                                  Colors.red
                                              ),
                                              onHover: (value) => false,
                                              onFocusChange: (value) => false,
                                              onPressed: null,

                                              icon: const Icon(Icons.person),
                                              label:  Text('Total Student : $totalAttendance'),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(top: 0),
                                            child:  ElevatedButton.icon(
                                              style: ElevatedButton.styleFrom(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(12), // <-- Radius
                                                ),
                                                // disabledForegroundColor: Colors.white,
                                                // disabledBackgroundColor:
                                                // const Color.fromARGB(
                                                //     255, 33, 150, 243),
                                              ),
                                              onHover: (value) => false,
                                              onFocusChange: (value) => false,
                                              onPressed: null,

                                              icon: const Icon(Icons.print),
                                              label: const Text('Print '),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ]);
                            } else if (asyncSnapshot.hasError) {
                              return const Text('error');
                            } else {
                              var attendanceDocument = asyncSnapshot.data!;
                              List listAttendance = attendanceDocument["Student"];
                              String totalAttendance = attendanceDocument["Student"].length.toString();

                              return ListView(
                                  shrinkWrap: true,
                                  children: [
                                    Stack(
                                      children: [
                                        CurveWidgetHomePage(
                                          //call from widget
                                          child: Container(
                                            width: double.infinity,
                                            height: 120,
                                            color: const Color.fromARGB(255, 3, 37, 76),
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                              children: [
                                                Container(
                                                  padding: const EdgeInsets.only(top: 0),
                                                  child: const Text(
                                                    'Attendance',
                                                    style: TextStyle(
                                                        fontSize: 30,
                                                        fontWeight: FontWeight.bold,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(top: 0),
                                                  child:  ElevatedButton.icon(
                                                    style: ElevatedButton.styleFrom(
                                                      backgroundColor: Colors.blue,
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
                                                    label:  checkAttendanceDateButton(selectDate1,selectDateDatabase2),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: double.infinity,
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(top: 0),
                                            child:  ElevatedButton.icon(
                                              style: ElevatedButton.styleFrom(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                    BorderRadius.circular(12), // <-- Radius
                                                  ),
                                                  disabledForegroundColor: Colors.white,
                                                  disabledBackgroundColor:
                                                  const Color.fromARGB(255, 3, 37, 76)
                                              ),
                                              onHover: (value) => false,
                                              onFocusChange: (value) => false,
                                              onPressed: null,

                                              icon: const Icon(Icons.person),
                                              label:  Text('Total Student : $totalAttendance'),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(top: 0),
                                            child:  ElevatedButton.icon(
                                              style: ElevatedButton.styleFrom(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(12), // <-- Radius
                                                ),
                                                disabledForegroundColor: Colors.white,
                                                backgroundColor:
                                                Colors.blue,
                                              ),
                                              onHover: (value) => false,
                                              onFocusChange: (value) => false,
                                              onPressed: () async {
                                                final pdfFile = await PdfApi
                                                    .generateCenteredText(
                                                    selectDate1,selectDateDatabase,
                                                    listAttendance
                                                );

                                                PdfApi.openFile(pdfFile);
                                                setState(() {  PdfApi.openFile(pdfFile); });
                                              },

                                              icon: const Icon(Icons.print),
                                              label: const Text('Print '),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    Card(
                                      margin:
                                      const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                      elevation: 6,
                                      child: Padding(
                                          padding: const EdgeInsets.all(12),
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children:  [
                                                  const Text(
                                                    'List Student',
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 17),
                                                  ),
                                                  const Spacer(),
                                                  checkAttendanceDate(selectDate1,selectDateDatabase2)
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              SingleChildScrollView(
                                                child: ListView.builder(
                                                  shrinkWrap: true,
                                                  physics: const NeverScrollableScrollPhysics(),
                                                  itemCount: listAttendance.isEmpty
                                                      ? 0
                                                      : listAttendance.length,
                                                  itemBuilder: (BuildContext context, int index) {


                                                    if (index == null) {
                                                      setState(() {
                                                        index = 0;
                                                      });
                                                    }

                                                    if (kDebugMode) {
                                                      print("list email : ${listAttendance[index]['username']}");
                                                    }
                                                    return Column(
                                                      children: [
                                                        ListTile(
                                                          title: Text(
                                                              '${index+1}    ${listAttendance[index]['username']}'),
                                                        ),
                                                        const Divider()
                                                      ],
                                                    );
                                                  },
                                                ),
                                              ),
                                            ],
                                          )),
                                    )
                                  ]);
                            }
                          }
                      }



                    }),
              ),
              ),
        ),
      ),
    );
  }
}

Widget checkAttendanceDate(selectDate,selectDateDatabase)
{
  if(selectDateDatabase.isEmpty)
  {
    return  Text('Date : $selectDate', style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 17),);
  }
  else
  {
    return  Text('Date : $selectDateDatabase', style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 17),);
  }
}

Widget checkAttendanceDateButton(selectDate,selectDateDatabase)
{
  if(selectDateDatabase.isEmpty)
  {
    return  Text('Get Date : $selectDate');
  }
  else
  {
    return  Text('Get Date : $selectDateDatabase');
  }
}