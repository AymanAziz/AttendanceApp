part of 'attendance_bloc.dart';

@immutable
abstract class AttendanceState {

  @override
  List<Object?> get props => [];
}

class AttendanceInitial extends AttendanceState {
}


class AttendanceLoading extends AttendanceState {

}

class AttendanceListTodayLoaded extends AttendanceState {

  final List<AttendanceModel> attendanceList;
   AttendanceListTodayLoaded(this.attendanceList);
}

class AttendanceIndividualLoaded extends AttendanceState{
  final userModelSQLite userdata;
  final List<AttendanceSQLModel> attendanceModel;
  AttendanceIndividualLoaded(this.userdata, this.attendanceModel);

  @override
  List<Object?> get props => [userdata, attendanceModel];
}
