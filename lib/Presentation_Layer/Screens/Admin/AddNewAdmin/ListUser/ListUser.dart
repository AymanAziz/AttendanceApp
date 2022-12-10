import 'package:attandance_app/BusinessLogic_Layer/UserBloc/user_bloc.dart';
import 'package:attandance_app/Data_Layer/Model/UserModel/userModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../DisplaySpecificUser/displayUserData.dart';



class UserListScreen extends StatefulWidget {
  const UserListScreen({Key? key}) : super(key: key);

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  final UserBloc userBloc = UserBloc();

  @override
  void initState() {
    userBloc.add(GetListUserForAdmin());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(title: const Text('List User'),backgroundColor: Colors.white,foregroundColor: Colors.black,),
      body: Container(
          margin: const EdgeInsets.all(8.0),
          child: BlocProvider(
            create: (_) => userBloc,
            child: BlocBuilder<UserBloc, UserState>(
                builder: (context, state) {
                  if (state is UserInitial) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is UserLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is ListUserLoaded) {

                    List<UserModel> listUser = state.userdata;

                    return _listUser(context, listUser);
                  }
                   else {
                    return const Center(child: CircularProgressIndicator());
                  }
                }),
          )),
    ));
  }
}

Widget _listUser(BuildContext context, state) {
  return ListView.builder(
      itemCount: state == null ? 0 : state.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const UpdateUserStatusScreen(),
                    settings: RouteSettings(
                      arguments: {
                        "name": state[index].name.toString(),
                        "email": state[index].email.toString(),
                        "isStudent": state[index].isStudent.toString(),
                        "userID": state[index].userID.toString(),
                        "telNumber": state[index].telNumber.toString(),
                      },
                    )));
          },
          child: Card(
            elevation: 5,
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            child: Container(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8, right: 8),
                            child: Text(
                              state[index].name.toString(),
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8, right: 8),
                            child: Text(state[index].isStudent.toString()),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      });
}
