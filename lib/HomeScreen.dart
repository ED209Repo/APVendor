import 'package:flutter/material.dart';
import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:vendor/Locations.dart';
import 'package:vendor/MenuScreen.dart';
import 'package:vendor/Widgets/AppColors.dart';
import 'package:vendor/HomeScreenTabbar.dart';
import 'dashboardscreen.dart';
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
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.themeColor2,
            elevation: 0,
            automaticallyImplyLeading: false,
            title: const Text("Order Queue", style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.white,
            )),
            centerTitle: true,
          ),
          body: Column(
            children: [
              SizedBox(height: 10), // Add a gap here
              Container(
                child: SlidingSegmentedControlDemo(),
              ),
            ],
          ),
        ),
      ),
    ),
    // Screen for 'Employee' tab
    Container(
      child: EmployeesScreen(),
    ),
    // Screen for 'Locations' tab
    Container(
      child: DashboardScreen(),
    ),
    // Screen for 'Settings' tab
    Container(
      child: LocationScreen(),
    ),
    Container(
      child: MenuScreen(),
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
            icon: Icon(Icons.shopping_cart, color: _selectedIndex == 0 ? AppColors.themeColor2 : AppColors.themeColor2),
            title: Text('Order', style: TextStyle(color: _selectedIndex == 0 ?  AppColors.themeColor2 : AppColors.themeColor2)),
          ),
          FlashyTabBarItem(
            icon: Icon(Icons.person, color: _selectedIndex == 1 ?  AppColors.themeColor2 : AppColors.themeColor2),
            title: Text('Employee', style: TextStyle(color: _selectedIndex == 1 ?  AppColors.themeColor2 : AppColors.themeColor2)),
          ),
          FlashyTabBarItem(
            icon: Icon(Icons.home, color: _selectedIndex == 3 ?  AppColors.themeColor2 : AppColors.themeColor2),
            title: Text('Home', style: TextStyle(color: _selectedIndex == 3 ?  AppColors.themeColor2 : AppColors.themeColor2)),
          ),
          FlashyTabBarItem(
            icon: Icon(Icons.near_me, color: _selectedIndex == 2 ?  AppColors.themeColor2 : AppColors.themeColor2),
            title: Text('Locations', style: TextStyle(color: _selectedIndex == 2 ?  AppColors.themeColor2 : AppColors.themeColor2)),
          ),
          FlashyTabBarItem(
            icon: Icon(Icons.restaurant, color: _selectedIndex == 3 ?  AppColors.themeColor2 : AppColors.themeColor2),
            title: Text('Menu', style: TextStyle(color: _selectedIndex == 3 ?  AppColors.themeColor : AppColors.themeColor)),
          ),
        ],
      ),
    );
  }
}
