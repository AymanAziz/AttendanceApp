part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();
  @override
  List<Object> get props => [];
}

class GetUserData extends UserEvent {
  //get update data
  final UserModel userModel;
  final userModelSQLite userModelSqlite;
  const GetUserData(this.userModel,this.userModelSqlite );
  @override
  List<Object> get props => [userModel,userModelSqlite];
}

class GetUserDataProfile extends UserEvent {
   final userModelSQLite userModelSqlite;
  const GetUserDataProfile(this.userModelSqlite );
  @override
  List<Object> get props => [userModelSqlite];
}

class GetUserUpdateDb extends UserEvent {
  //get update data
  final UserModel userModel;
  final userModelSQLite userModelSqlite;
  const GetUserUpdateDb(this.userModel,this.userModelSqlite);
  @override
  List<Object> get props => [userModel,userModelSqlite];
}

///get update user status
class GetUserUpdateStatus extends UserEvent {
  final UserModel userModel;
  const GetUserUpdateStatus(this.userModel);
  @override
  List<Object> get props => [userModel];
}


class CountUserFireStore extends UserEvent
{}

class GetListUserForAdmin extends UserEvent
{}

class CheckUser extends UserEvent
{}