import 'package:attandance_app/Presentation_Layer/Screens/Student/Home/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_icons/line_icons.dart';

import '../../../../BusinessLogic_Layer/AttendanceBloc/attendance_bloc.dart';
import '../../../Widget/Curve_widget_student.dart';
import '../Widget/NavBarStudent.dart';

class EquipmentTemplate extends StatefulWidget {
  const EquipmentTemplate({Key? key}) : super(key: key);

  @override
  State<EquipmentTemplate> createState() => _EquipmentTemplateState();
}

class _EquipmentTemplateState extends State<EquipmentTemplate> {
  AttendanceBloc attendanceBloc = AttendanceBloc();

  @override
  Widget build(BuildContext context) {
    final todo = ModalRoute.of(context)?.settings.arguments as Map;
    String title = todo['title'];

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context,rootNavigator: false ).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (BuildContext context) =>
                const NavbarStudent(),
              ),
                  (Route<dynamic> route) => false),
        ),
        elevation: 0,
      ),
      body: BlocProvider(
        create: (context) {
          attendanceBloc.add(GetAttendanceData(title));
          return attendanceBloc;
        },
        child: BlocBuilder<AttendanceBloc, AttendanceState>(
            builder: (context, state) {
          if (state is AttendanceInitial) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AttendanceLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AttendanceCurrentDateLoaded) {
            return Container(
              height: double.infinity,
              color: Colors.white,
              child: Stack(
                children: [
                  Stack(
                    children: [
                      CurveWidgetStudent(
                          child: Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height / 2,
                        color: const Color.fromARGB(255, 4, 52, 84),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const [
                            Text(
                              "Thank You!!",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                  color: Colors.white),
                            ),
                            Text(
                              "Your registration is successful",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      )),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Card(
                                color: const Color.fromARGB(253, 217, 217, 217),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                elevation: 10,
                                shadowColor: Colors.black,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 5),
                                      child: Row(
                                        children: const [
                                          Icon(
                                            LineIcons.info,
                                            size: 20,
                                          ),
                                          SizedBox(width: 10),
                                          Text(
                                            "Details",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20),
                                          )
                                        ],
                                      ),
                                    ),
                                    Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                        ),
                                        color: Colors.white,
                                        elevation: 20,
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              20, 0, 20, 20),
                                          child: Column(
                                            children: [
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                children:  [
                                                  const Text("Name : "),
                                                  Text(
                                                      state.attendanceList.name,
                                                      style: const TextStyle(
                                                          fontWeight:
                                                          FontWeight.bold))
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                children:  [
                                                  const Text("Date : "),
                                                  Text(
                                                      state.attendanceList.date,
                                                      style: const TextStyle(
                                                          fontWeight:
                                                          FontWeight.bold))
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                children:  [
                                                  const Text(
                                                      "Student Id : "),
                                                  Text(
                                                      state.attendanceList.StaffOrUserID,
                                                      style: const TextStyle(
                                                          fontWeight:
                                                          FontWeight.bold))
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                children:  [
                                                  const Text("Location : "),
                                                  Text(
                                                      state.attendanceList.labName,
                                                      style: const TextStyle(
                                                          fontWeight:
                                                          FontWeight.bold))
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    2,
                                                // <-- Your width
                                                height: 50,
                                                // <-- Your height
                                                child: ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    textStyle: const TextStyle(
                                                        fontSize: 20),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                    ),
                                                  ),
                                                  onPressed: () {},
                                                  child: const Text(
                                                      "List Equipment"),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    2,
                                                // <-- Your width
                                                height: 50,
                                                // <-- Your height
                                                child: ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    textStyle: const TextStyle(
                                                        fontSize: 20),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                    ),
                                                    backgroundColor:
                                                        const Color.fromARGB(
                                                            255, 0, 0, 0),
                                                  ),
                                                  onPressed: () {},
                                                  child: const Text(
                                                      "Book Equipment"),
                                                ),
                                              )
                                            ],
                                          ),
                                        )),
                                  ],
                                ),
                              ))
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        }),
      ),
    ));
  }
}
