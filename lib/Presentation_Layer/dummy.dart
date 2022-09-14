// import 'dart:io';
//
// import 'package:attandance_system/Data_Layer/Repository/AuthenticationRepository/AuthRepository.dart';
// import 'package:attandance_system/Data_Layer/Repository/UserRepository/UserRepository.dart';
// import 'package:firebase_app_check/firebase_app_check.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import '../BusinessLogic_Layer/AuthBloc/auth_bloc.dart';
// import '../firebase_options.dart';
// import 'Screens/HomeScreen/Admin/AdminHomeScreen.dart';
// import 'Screens/HomeScreen/HomeScreen.dart';
// import 'Screens/login_and_register/SignInScreen.dart';
// // ...
//
// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   //initialize firebase
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//
//   await FirebaseAppCheck.instance.activate();
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//
//     // Create function utk access repository function
//     return RepositoryProvider(
//       create: (BuildContext context) {
//         return AuthRepository();
//       },
//       child: BlocProvider(
//         create: (context) => AuthBloc(
//             authRepository: RepositoryProvider.of<AuthRepository>(context)),
//         child: MaterialApp(
//           debugShowCheckedModeBanner: false,
//           theme: ThemeData(
//             colorScheme: ColorScheme.fromSwatch().copyWith(
//               primary: const Color.fromARGB(255, 4, 52, 84),
//             ),
//           ),
//           home: StreamBuilder<User?>(
//               stream: FirebaseAuth.instance.authStateChanges(),
//               builder: (context, snapshot) {
//                 // If the snapshot has user data, then they're already signed in. So Navigating to the Dashboard via NavBar.
//                 if (snapshot.hasData) {
//                   return FutureBuilder(
//                       future: internetCheck(),
//                       builder: (
//                         context,
//                         snapshot,
//                       ) {
//                         if (snapshot.connectionState == ConnectionState.done) {
//                           if (snapshot.hasData) {
//                             //yg ni kalau ada data--> terus masuk x yah login
//                             return checkUserStatus();
//                           } else {
//                             return const SignInScreen();
//                           }
//                         } else {
//                           return Container(
//                             decoration: const BoxDecoration(
//                               color: Colors.white,
//                             ),
//                           );
//                         }
//                       });
//                 }
//                 // Otherwise, they're not signed in. Show the sign in page.
//                 return const SignInScreen();
//               }),
//         ),
//       ),
//     );
//   }
// }
//
// Future<bool?> internetCheck() async {
//   final result = await InternetAddress.lookup('www.google.com');
//   if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
//     return true;
//   } else {
//     return null;
//   }
// }
//
// checkUserStatus() {
//   String? email = FirebaseAuth.instance.currentUser?.email;
//   String userStatus = UserRepository().checkUser(email!);
//
//   switch (userStatus) {
//     case "Student":
//       {
//         return const HomeScreen();
//       }
//
//     default:
//       {
//         return const AdminHomeScreen();
//       }
//   }
// }

// return Container(
// alignment: Alignment.center,
// child: Flex(
// direction: Axis.vertical,
// mainAxisAlignment: MainAxisAlignment.center,
// children: <Widget>[
// ElevatedButton(
// onPressed: () {
// // Signing out the user
// context.read<AuthBloc>().add(SignOutRequested());
// //Navigator.of(context).pop();
// Navigator.pushAndRemoveUntil(
// context,
// MaterialPageRoute(
// builder: (BuildContext context) =>
// const SignInScreen()),
// (Route<dynamic> route) => false);
// },
// child: const Text('log out')),
// ]));
