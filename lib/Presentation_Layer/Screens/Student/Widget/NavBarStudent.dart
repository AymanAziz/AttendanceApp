import 'package:attandance_app/Presentation_Layer/Screens/Student/Home/StudentHomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../HomeScreen/HomeScreen.dart';
import '../Setting/StudentSetting.dart';




class NavbarStudent extends StatefulWidget {
  const NavbarStudent({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _NavbarStudentState createState() => _NavbarStudentState();
}

class _NavbarStudentState extends State<NavbarStudent> {
  final PersistentTabController _controller =
  PersistentTabController(initialIndex: 0);

//Screens for each nav items.
  List<Widget> _navScreens() {
    return [
      //homepage
      // const StudentHomeScreen(),
      const HomeScreen(),
      ///second page
      //about page
      const StudentSetting()
      // const TestSearch()
      // MyForm()
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(LineIcons.home),
        title: ("Home"),
        activeColorPrimary: Colors.white,
        inactiveColorPrimary: Colors.black,
        activeColorSecondary: Colors.black,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(LineIcons.cog),
        title: ("About"),
        activeColorPrimary: Colors.white,
        inactiveColorPrimary: Colors.black,
        activeColorSecondary: Colors.black,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Center(
            child: PersistentTabView(
              context,
              screens: _navScreens(),
              controller: _controller,
              items: _navBarsItems(),
              confineInSafeArea: true,
              backgroundColor:  Colors.white,
              handleAndroidBackButtonPress: true,
              resizeToAvoidBottomInset: true,
              hideNavigationBarWhenKeyboardShows: true,
              stateManagement: true,
              decoration: const NavBarDecoration(
                //borderRadius: BorderRadius.circular(10.0),
              ),
              popAllScreensOnTapOfSelectedTab: true,
              navBarStyle: NavBarStyle.style13,
            )),
        onWillPop: () async => false);
  }
}
