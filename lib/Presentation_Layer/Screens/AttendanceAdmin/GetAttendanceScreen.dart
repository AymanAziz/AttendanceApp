import 'package:attandance_app/Data_Layer/Repository/AttendanceRepository/AttendanceRepository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


class GetAttendanceScreen extends StatefulWidget {
  const GetAttendanceScreen({Key? key}) : super(key: key);

  @override
  State<GetAttendanceScreen> createState() => _GetAttendanceScreenState();
}

class _GetAttendanceScreenState extends State<GetAttendanceScreen> {
  @override
  Widget build(BuildContext context) {
    //80% of screen width
    double cWidth = MediaQuery.of(context).size.width * 0.8;

    return SafeArea(child: Scaffold(
      appBar: AppBar(title: const Text('Attendance Page'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,),
      body:FutureBuilder(future: checkNull(),builder: (context, snapshot){
        if(!snapshot.hasData)
          {
            return const Text('no value langsung');
          }
        else
          {
            if(snapshot.data == true)
              {
                return const Text('no value');
              }
            else
              {
                return StreamBuilder<DocumentSnapshot>(stream: AttendanceRepository().getAttendance(),
                    builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                      if (snapshot.connectionState == ConnectionState
                          .active) {
                        if  (!snapshot.hasData ) {
                          return const Center(child: CircularProgressIndicator());
                        }
                        else if(!snapshot.data!.exists)//kalau document tu x de
                        {
                          return const Text('No data');
                        }
                        else if(snapshot.hasError)
                        {
                          return const Text('error');
                        }
                        else//kalau ada data
                        {
                          var attendanceDocument = snapshot.data!;
                          var listAttendance =  attendanceDocument["Student"];

                          return Padding(
                              padding: const EdgeInsets.all(12),
                              child: ListView.builder(
                                itemCount: listAttendance != null ? listAttendance.length: 0,
                                itemBuilder: (BuildContext context, int index)
                                {
                                  return ListTile(title: Text(listAttendance[index]['email']));
                                },
                              )

                          );
                        }

                      } else {
                        return Container();
                      }
                    });
              }
          }

      }),
    ));
  }
}

Future<bool> checkNull()
 async {
  bool value =  await AttendanceRepository().checkTodayAttendance() ;
  if (value == true)
    {
      return true;
    }
  else
    {
      return false;
    }
}