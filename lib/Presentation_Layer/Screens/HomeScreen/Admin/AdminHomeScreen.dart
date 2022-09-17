// import 'package:attandance_app/Data_Layer/Model/AttendanceModel/attendanceModel.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';
//
// import '../../../../BusinessLogic_Layer/AttendanceBloc/attendance_bloc.dart';
// import '../../../../Data_Layer/Repository/AttendanceRepository/AttendanceRepository.dart';
//
// class AdminHomeScreen extends StatefulWidget {
//   const AdminHomeScreen({Key? key}) : super(key: key);
//
//   @override
//   State<AdminHomeScreen> createState() => _AdminHomeScreenState();
// }
//
// class _AdminHomeScreenState extends State<AdminHomeScreen> {
//    final AttendanceBloc attendanceBloc = AttendanceBloc();
//   late TooltipBehavior _tooltipBehavior;
//
//   @override
//   void initState() {
//      // attendanceBloc.add(GetAttendanceData());
//     _tooltipBehavior = TooltipBehavior(enable: true);
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     Color colorMainTheme = Theme.of(context).primaryColor;
//
//     CollectionReference db = FirebaseFirestore.instance.collection('Attendance');
//
//
//       DateTime currentDateTime = DateTime.now();
//       Timestamp myTimeStamp = Timestamp.fromDate(currentDateTime); //To TimeStamp
//       DateTime currentDate = myTimeStamp.toDate();
//
//       print(DateTime(currentDate.year, currentDate.month, currentDate.day)
//               .toString());
//
//     AttendanceModel attendanceModel = AttendanceModel();
//
//
//     // return SafeArea(
//     //     child: Scaffold(
//     //   appBar: AppBar(),
//     //       body: BlocProvider(create: (_) => attendanceBloc,
//     //       child:  BlocBuilder<AttendanceBloc, AttendanceState>(builder: (context, state)
//     //       {
//     //       if (state is AttendanceLoading) {
//     //         return const Center(child: Text('loading'));
//     //       }
//     //       else if (state is AttendanceListTodayLoaded) {
//     //         if (state.attendanceList.isNotEmpty) {
//     //           return  ListView.builder(
//     //             itemCount: state.attendanceList != null ? state.attendanceList.length : 0,
//     //             itemBuilder: (_, int index) {
//     //               print(state.attendanceList[index].email);
//     //               return ListTile(title: Text(state.attendanceList[index].email.toString()));
//     //             },);
//     //         }
//     //         else
//     //           {
//     //             return const Center(child: Text('empty'));
//     //           }
//     //       }
//     //       else
//     //         {
//     //           return Container();
//     //         }
//     //       }),),
//     //   )
//     // );
//     return SafeArea(
//         child: Scaffold(
//           body: Center(
//             child:StreamBuilder<DocumentSnapshot>(stream: AttendanceRepository().getAttendance(),
//                 builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
//
//
//
//                   if (snapshot.connectionState == ConnectionState
//                       .active) {
//
//                     if (!snapshot.hasData) {
//                       return Container();
//                     }
//                     else
//                     {
//                       // get course document
//                       var courseDocument = snapshot.data;
//                       // get sections from the document
//                       var  sections = courseDocument!['Student'];
//
//                       // build list using names from sections
//                       return ListView.builder(
//                         itemCount: sections != null ? sections.length : 0,
//                         itemBuilder: (_, int index) {
//                           print(sections[index]['email']);
//                           return ListTile(title: Text(sections[index]['email']));
//                         },);
//
//                     }
//
//                   } else {
//                     return Container();
//                   }
//                 }),
//           ),
//         ));
//   }
// }
//
// class ChartData {
//   ChartData(
//     this.x,
//     this.y,
//   );
//
//   final String x;
//   final int y;
// }
