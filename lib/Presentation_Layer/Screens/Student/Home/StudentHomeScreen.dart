import 'package:attandance_app/BusinessLogic_Layer/AttendanceBloc/attendance_bloc.dart';
import 'package:attandance_app/BusinessLogic_Layer/UserBloc/user_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/cupertino.dart';

class StudentHomeScreen extends StatefulWidget{
  const StudentHomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _StudentHomeScreen();

}

class _StudentHomeScreen extends State<StudentHomeScreen>{
  final user = FirebaseAuth.instance.currentUser!;
  final AttendanceBloc attendanceBloc = AttendanceBloc();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState(){
    attendanceBloc.add(GetIndividualAttendanceData(user.email!));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: BlocProvider(
          create: ((context){
            return attendanceBloc;
          }),
          child: BlocBuilder<AttendanceBloc, AttendanceState>(
            builder: (context, state){
              if (state is AttendanceInitial) {

                return const Center(child: CircularProgressIndicator(color: Colors.red,));

              } else if (state is AttendanceLoading) {
                return const Center(child: CircularProgressIndicator());

              }else if(state is AttendanceIndividualLoaded){
                if(state.attendanceModel.length == 0){
                  return const Center(child: Text("No History"));
                }else{
                  return Text(state.userdata.email);
                }
              }else{
                return const Center(child: Text("No data"));
              }
            },
          ),
        ),
      ),
    );
  }

}