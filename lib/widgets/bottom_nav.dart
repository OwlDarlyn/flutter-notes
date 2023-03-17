import 'package:flutter/material.dart';

import '../screens/calendar_screen.dart';
import '../screens/home_screen.dart';
import '../screens/search_screen.dart';
import '../screens/settings_screen.dart';

class BottomNavBar extends StatefulWidget {
  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  List<Widget> screens = [
    HomeScreen(),
    SearchScreen(),
    CalendarScreen(),
    SettingsScreen(),
  ];

  int selectedIndex = 0;

  void onTap(int index) {
    selectedIndex = index;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.black87,
        selectedFontSize: 15,
        unselectedItemColor: Colors.grey[700],
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month), label: 'Calendar'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'Settings'),
        ],
        onTap: onTap,
      ),
    );
  }
}

// (currentIndex) {
//           if (currentIndex == 0) {
//             Navigator.pushReplacement(
//               context,
//               MaterialPageRoute(
//                 builder: (_) => HomeScreen(),
//               ),
//             );
//           } else if (currentIndex == 1) {
//             Navigator.pushReplacement(
//               context,
//               MaterialPageRoute(
//                 builder: (_) => SearchScreen(),
//               ),
//             );
//           } else if (currentIndex == 2) {
//             Navigator.pushReplacement(
//               context,
//               MaterialPageRoute(
//                 builder: (_) => CalendarScreen(),
//               ),
//             );
//           } else if (currentIndex == 3) {
//             Navigator.pushReplacement(
//               context,
//               MaterialPageRoute(
//                 builder: (_) => SettingsScreen(),
//               ),
//             );
//           }
//         },