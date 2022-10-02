import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../Data_Layer/Model/UserModel/userModel.dart';
import '../../Data_Layer/Provider/AttendanceProvider/AttendanceProvider.dart';
import '../../Data_Layer/Provider/UserProvider/UserProvider.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    final UserdbProvider  userDbProvider =UserdbProvider();
    final AttendanceDbProvider attendanceDbProvider = AttendanceDbProvider();

    //for register
    on<GetUserData>((event, emit) async {
      emit(UserLoading());
      await  userDbProvider.addUserData(event.userModel);
      await  userDbProvider.addUserDataSQLite(event.userModelSqlite);
    });

    on<GetUserDataProfile>((event, emit) async {
      emit(UserLoading());
      await  userDbProvider.addUserDataSQLite(event.userModelSqlite);
    });

    on<CountUserFireStore>((event, emit) async {
      emit(UserLoading());
      int totalUser = await  attendanceDbProvider.countUser();
      emit(TotalUserState(totalUser));
    });




    on<GetUserUpdateDb>((event, emit) async {
      await  userDbProvider.addUserData(event.userModel);
      await  userDbProvider.addUserDataSQLite(event.userModelSqlite);
    });


    on<CheckUser>((event, emit) async {
      final userdata = await userDbProvider.checkUserData();
      emit(UserLoaded(userdata));
    });

  }
}
