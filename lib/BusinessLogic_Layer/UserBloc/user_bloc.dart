
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import '../../Data_Layer/Model/UserModel/userModel.dart';
import '../../Data_Layer/Provider/UserProvider/UserProvider.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    final UserdbProvider  userDbProvider =UserdbProvider();

    //for register
    on<GetUserData>((event, emit) async {
      await  userDbProvider.addUserData(event.userModel);
    });

    on<GetUserUpdateDb>((event, emit) async {
      await  userDbProvider.addUserData(event.userModel);
    });


    // on<CheckUser>((event, emit) async {
    //   final userdata = await userDbProvider.checkUserData();
    //   emit(UserLoaded(userdata));
    // });

  }
}
