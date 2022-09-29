part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();
}

class UserInitial extends UserState {
  @override
  List<Object> get props => [];
}

class UserLoading extends UserState{
  @override
  List<Object> get props =>[];
}

class UserLoaded extends UserState {
  final userModelSQLite userdata;
  const UserLoaded(this.userdata);

  @override
  List<Object?> get props => [userdata];
}

class TotalUserState extends UserState {
  final int totalUser;
  const TotalUserState(this.totalUser);

  @override
  List<Object?> get props => [totalUser];
}