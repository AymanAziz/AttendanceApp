import 'package:attandance_app/Data_Layer/Model/AttendanceModel/attendanceModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../Data_Layer/Repository/AttendanceRepository/AttendanceRepository.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({Key? key}) : super(key: key);

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  // final AttendanceBloc attendanceBloc = AttendanceBloc();
  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    // attendanceBloc.add(CheckAttendanceToday());
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Color colorMainTheme = Theme.of(context).primaryColor;

    CollectionReference db = FirebaseFirestore.instance.collection('Attendance');


      DateTime currentDateTime = DateTime.now();
      Timestamp myTimeStamp = Timestamp.fromDate(currentDateTime); //To TimeStamp
      DateTime currentDate = myTimeStamp.toDate();

      print(DateTime(currentDate.year, currentDate.month, currentDate.day)
              .toString());

    AttendanceModel attendanceModel = AttendanceModel();

    // return SafeArea(
    //     child: Scaffold(
    //   body: BlocListener<AuthBloc, AuthState>(
    //     listener: (context, state) async {
    //       if (state is UnAuthenticated) {
    //         // Navigate to the sign in screen when the user Signs Out
    //         Navigator.of(context).pushAndRemoveUntil(
    //           MaterialPageRoute(builder: (context) => const SignInScreen()),
    //           (route) => false,
    //         );
    //       }
    //     },
    //     child: BlocProvider(create: (_) => attendanceBloc,
    //     child:  BlocBuilder<AttendanceBloc, AttendanceState>(builder:(context, state)
    //     {
    //         if (state is AttendanceTodayLoaded) {
    //
    //           List<int> attendanceCheck =[];
    //           attendanceCheck.add(state.attendanceCurrentDateData.where((c) => c.attend == true).length);
    //           attendanceCheck.add(state.attendanceCurrentDateData.where((c) => c.attend == false).length);
    //
    //           print("check value :${state.attendanceCurrentDateData.where((c) => c.attend == true).length}");
    //
    //
    //           DateTime currentDate = DateTime.now();
    //          Future aaa=  FirebaseFirestore
    //               .instance
    //               .collection('Attandance')
    //               .doc( DateTime(currentDate.year,currentDate.month,currentDate.day).toString())
    //               .get().then((value) =>
    //               value.get("Student")
    //           );
    //
    //          print(aaa);
    //
    //           return Builder(builder: (BuildContext context) {
    //             return Padding(
    //               padding: const EdgeInsets.only(left: 10, right: 10),
    //               child: ListView(
    //                 children: [
    //                   Column(
    //                     mainAxisSize: MainAxisSize.min,
    //                     mainAxisAlignment: MainAxisAlignment.start,
    //                     children: [
    //                       Row(
    //                         mainAxisAlignment: MainAxisAlignment.start,
    //                         children: [
    //                           Container(
    //                             padding: const EdgeInsets.only(top: 30),
    //                             child: const Text(
    //                               "Hello",
    //                               style: TextStyle(
    //                                 fontSize: 30,
    //                               ),
    //                             ),
    //                           ),
    //                           // Image.asset("assets/home.png", width: 200, height: 200),
    //                         ],
    //                       ),
    //                       Row(
    //                         mainAxisAlignment: MainAxisAlignment.start,
    //                         children: [
    //                           Card(child: SfCircularChart(
    //                               title: ChartTitle(text: 'Total Number of Drug'),
    //                               legend: Legend(
    //                                   isVisible: true,
    //                                   toggleSeriesVisibility: true,
    //                                   position: LegendPosition.bottom,
    //                                   overflowMode: LegendItemOverflowMode.wrap,
    //                                   textStyle:const TextStyle(fontSize: 8)
    //                                 //isResponsive: true,
    //                               ),
    //                               // Initialize category axis
    //                               // primaryXAxis: CategoryAxis(),
    //                               tooltipBehavior: _tooltipBehavior,
    //                               series: <DoughnutSeries>[
    //                                 // Initialize line series
    //                               DoughnutSeries<ChartData, String>(
    //                               dataSource: [
    //                               // Bind data source
    //                               ChartData('attend', attendanceCheck.first),
    //                               ChartData('not attend', attendanceCheck.last),
    //                               ],
    //                                   xValueMapper: (ChartData data, _) => data.x,
    //                                   yValueMapper: (ChartData data, _) => data.y,
    //                                   // Render the data label
    //                                   dataLabelSettings:const DataLabelSettings(isVisible : true)
    //                               )
    //
    //                               ]),
    //                           )
    //                           // Image.asset("assets/home.png", width: 200, height: 200),
    //                         ],
    //                       ),
    //                     ],
    //                   )
    //                 ],
    //               ),
    //             );
    //           });
    //         } else {
    //           return Builder(builder: (BuildContext context) {
    //             return const Center(child: Text("Nothing"),);
    //           });
    //         }
    //     })
    //
    //
    //       ,),
    //   ),
    // ));
    return SafeArea(
        child: Scaffold(
      body: Center(
        child:StreamBuilder<DocumentSnapshot>(stream: AttendanceRepository().getAttendance(),
            builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState
                  .active) {
                // get course document
                var courseDocument = snapshot.data;
                // get sections from the document
               var  sections = courseDocument!['Student'];

               // build list using names from sections
                return ListView.builder(
                  itemCount: sections != null ? sections.length : 0,
                  itemBuilder: (_, int index) {
                    print(sections[index]['email']);
                    return ListTile(title: Text(sections[index]['email']));
                  },);


              } else {
                return Container();
              }
            }),
      ),
    ));
  }
}

class ChartData {
  ChartData(
    this.x,
    this.y,
  );

  final String x;
  final int y;
}
