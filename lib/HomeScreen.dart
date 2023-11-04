import 'package:flutter/material.dart';
import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:vendor/Widgets/AppColors.dart';
import 'package:vendor/HomeScreenTabbar.dart';

import 'employee_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  // Define your content screens here.
  final List<Widget> _screens = [
    // Screen for 'Order' tab
    Container(
      color: AppColors.themeColor,
      alignment: Alignment.center,
      child:    DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: const Text("Order Queue",style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.black
            ),),
            centerTitle: true,
          ),
          body: Container(
            child: SlidingSegmentedControlDemo(),
          )
        ),
      ),
    ),
    // Screen for 'Employee' tab
    Container(
      child: EmployeesScreen(),
    ),
    // Screen for 'Locations' tab
    Container(
      color: AppColors.themeColor,
      alignment: Alignment.center,
      child: const Text("This is the content of the 'dashboard' tab"),
    ),
    // Screen for 'Settings' tab
    Container(
      color: AppColors.themeColor2,
      alignment: Alignment.center,
      child: const Text("This is the content of the 'Location' tab"),
    ),
    Container(
      color: AppColors.themeColor2,
      alignment: Alignment.center,
      child: const Text("This is the content of the 'Settings' tab"),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex], // Display the selected screen.
      bottomNavigationBar: FlashyTabBar(
        animationDuration: const Duration(milliseconds: 500),
        selectedIndex: _selectedIndex,
        showElevation: true,
        onItemSelected: (index) => setState(() {
          _selectedIndex = index;

        }),
        items:  [
          FlashyTabBarItem(
            icon: Icon(Icons.access_time, color: _selectedIndex == 0 ? AppColors.themeColor2 : AppColors.themeColor2),
            title: Text('Order', style: TextStyle(color: _selectedIndex == 0 ?  AppColors.themeColor2 : AppColors.themeColor2)),
          ),
          FlashyTabBarItem(
            icon: Icon(Icons.person, color: _selectedIndex == 1 ?  AppColors.themeColor2 : AppColors.themeColor2),
            title: Text('Employee', style: TextStyle(color: _selectedIndex == 1 ?  AppColors.themeColor2 : AppColors.themeColor2)),
          ),
          FlashyTabBarItem(
            icon: Icon(Icons.home, color: _selectedIndex == 3 ?  AppColors.themeColor2 : AppColors.themeColor2),
            title: Text('Dashboard', style: TextStyle(color: _selectedIndex == 3 ?  AppColors.themeColor : AppColors.themeColor)),
          ),
          FlashyTabBarItem(
            icon: Icon(Icons.near_me_outlined, color: _selectedIndex == 2 ?  AppColors.themeColor2 : AppColors.themeColor2),
            title: Text('Locations', style: TextStyle(color: _selectedIndex == 2 ?  AppColors.themeColor2 : AppColors.themeColor2)),
          ),
          FlashyTabBarItem(
            icon: Icon(Icons.restaurant, color: _selectedIndex == 3 ?  AppColors.themeColor2 : AppColors.themeColor2),
            title: Text('Settings', style: TextStyle(color: _selectedIndex == 3 ?  AppColors.themeColor : AppColors.themeColor2)),
          ),
        ],
      ),
    );
  }
}
