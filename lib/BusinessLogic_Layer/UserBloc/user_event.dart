part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();
  @override
  List<Object> get props => [];
}

class GetUserData extends UserEvent {
  //get update data
  final UserModel userModel;
  const GetUserData(this.userModel);
  @override
  List<Object> get props => [userModel];
}

class GetUserUpdateDb extends UserEvent {
  //get update data
  final UserModel userModel;
  const GetUserUpdateDb(this.userModel);
  @override
  List<Object> get props => [userModel];
}

class CheckUser extends UserEvent
{}