// import 'package:attandance_app/Presentation_Layer/Screens/Student/Setting/StudentSetting.dart';
// import 'package:flutter/material.dart';
//
// import 'Home/StudentHomeScreen.dart';
//
// class StudentDashboard extends StatefulWidget {
//   const StudentDashboard({Key? key}) : super(key: key);
//
//   @override
//   State<StatefulWidget> createState() => _StudentDashboard();
// }
//
// class _StudentDashboard extends State<StudentDashboard> {
//   PageController _pageController = PageController();
//   List<Widget> _screens = [StudentHomeScreen(), const StudentSetting()];
//
//   int _selectedIndex = 0;
//
//   void _onPageChange(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }
//
//   void _onItemTapped(int selectedIndex) {
//     _pageController.jumpToPage(selectedIndex);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//         child: Scaffold(
//           body: PageView(
//             controller: _pageController,
//             onPageChanged: _onPageChange,
//             physics: const NeverScrollableScrollPhysics(),
//             children: _screens,
//           ),
//           bottomNavigationBar: BottomNavigationBar(
//             onTap: _onItemTapped,
//             items: const <BottomNavigationBarItem>[
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.home),
//                 label: 'Home',
//               ),
//               BottomNavigationBarItem(
//                   icon: Icon(Icons.settings), label: 'Setting'),
//             ],
//             currentIndex: _selectedIndex,
//             selectedItemColor: Colors.green,
//           ),
//         )
//     );
//   }
// }