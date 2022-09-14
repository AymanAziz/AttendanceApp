

import '../../Model/UserModel/userModel.dart';
import '../../Repository/UserRepository/UserRepository.dart';

class UserdbProvider {
  final UserRepository userRepository = UserRepository();

  //add user
  Future<void> addUserData(UserModel userModel) async {
    return userRepository.addUser(userModel);
  }


  // //update user
  // Future<void> updateUser(UserModel userModel) async {
  //   return userRepository.update(userModel);
  // }
  //
  // //check user
  // Future<DocumentSnapshot<Object?>> checkUserData() async {
  //   return userRepository.specificUser();
  // }
}