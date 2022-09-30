import 'dart:async';

import 'package:attandance_app/Data_Layer/Model/AttendanceModel/attendanceModel.dart';
import 'package:attandance_app/Data_Layer/Provider/AttendanceProvider/AttendanceProvider.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'attendance_event.dart';
part 'attendance_state.dart';

class AttendanceBloc extends Bloc<AttendanceEvent, AttendanceState> {
  AttendanceBloc() : super(AttendanceInitial()) {
    final AttendanceDbProvider attendanceDbProvider = AttendanceDbProvider();
    // on<GetAttendanceData>((event, emit) async {
    //   emit(AttendanceLoading());
    //   final attendanceList = await attendanceDbProvider.getDataToday();
    //   emit(AttendanceListTodayLoaded(attendanceList));
    // });
  }
}
