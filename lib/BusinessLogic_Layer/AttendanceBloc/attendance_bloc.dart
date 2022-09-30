import 'dart:async';

import 'package:attandance_app/Data_Layer/Model/AttendanceModel/attendanceModel.dart';
import 'package:attandance_app/Data_Layer/Provider/AttendanceProvider/AttendanceProvider.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import '../../Data_Layer/Model/UserModel/userModel.dart';
import '../../Data_Layer/Provider/UserProvider/UserProvider.dart';

part 'attendance_event.dart';
part 'attendance_state.dart';

class AttendanceBloc extends Bloc<AttendanceEvent, AttendanceState> {
  AttendanceBloc() : super(AttendanceInitial()) {
    final AttendanceDbProvider attendanceDbProvider = AttendanceDbProvider();
    final UserdbProvider  userDbProvider =UserdbProvider();
    // on<GetAttendanceData>((event, emit) async {
    //   emit(AttendanceLoading());
    //   final attendanceList = await attendanceDbProvider.getDataToday();
    //   emit(AttendanceListTodayLoaded(attendanceList));
    // });

    on<GetIndividualAttendanceData>((event, emit) async {
      emit(AttendanceLoading());
      final userdata = await userDbProvider.checkUserData();
      final attendanceData = await attendanceDbProvider.getUserAttendanceProvider(event.email);
      emit(AttendanceIndividualLoaded(userdata, attendanceData));
    });
  }
}
