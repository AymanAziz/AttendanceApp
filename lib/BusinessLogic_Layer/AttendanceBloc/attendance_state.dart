part of 'attendance_bloc.dart';

@immutable
abstract class AttendanceState {

  @override
  List<Object?> get props => [];
}

class AttendanceInitial extends AttendanceState {
}


class AttendanceLoading extends AttendanceState {}

class AttendanceListLoaded extends AttendanceState {
  final List<AttendanceSQLite> attendanceList;
   AttendanceListLoaded(this.attendanceList);
}
