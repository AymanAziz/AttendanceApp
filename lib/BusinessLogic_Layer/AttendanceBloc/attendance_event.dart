part of 'attendance_bloc.dart';

@immutable
abstract class AttendanceEvent extends Equatable {
  const AttendanceEvent();
}
class GetAttendanceData extends AttendanceEvent {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

}

class GetIndividualAttendanceData extends AttendanceEvent{
  final String email;
  const GetIndividualAttendanceData(this.email);

  @override
  List<Object?> get props => [email];

}
