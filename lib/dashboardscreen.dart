import 'package:flutter/material.dart';
import 'package:vendor/HomeScreen.dart';
import 'MenuScreen.dart';
import 'Widgets/AppColors.dart';
import 'chart2.dart';
import 'charts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _currentIndex = 0;

  late List<String> _drawerItems;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _drawerItems = [
      AppLocalizations.of(context)!.dashboard,
      AppLocalizations.of(context)!.reports,
      AppLocalizations.of(context)!.payments,
      AppLocalizations.of(context)!.menu,
      AppLocalizations.of(context)!.order,
    ];
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final boxWidth = screenWidth * 0.7;
    final drawerWidth = screenWidth * 0.7;

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.home),
        centerTitle: true,
        backgroundColor: AppColors.themeColor2,
      ),
      drawer: Container(
        width: drawerWidth,
        child: Drawer(
          child: Container(
            child: ListView.builder(
              itemCount: _drawerItems.length + 5,
              itemBuilder: (context, index) {
                if (index == 0) {
                  // Drawer header
                  return Container(
                    height: 85,
                    child: DrawerHeader(
                      decoration: BoxDecoration(
                        color: AppColors.themeColor2.withOpacity(0.8),
                      ),
                      child: Container(
                        alignment: Alignment.bottomLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                          // Replace this with your image widget
                            Image.asset(
                              'images/whiteicon.png',
                              height: 50,
                              width: 50,
                            ),
                        ]
                      )
                    )
                    ),
                  );
                } else if (index == _drawerItems.length + 1) {
                  // Divider after the main items
                  return Divider(thickness: 1, color: Colors.grey, indent: 20, endIndent: 20);
                } else if (index == _drawerItems.length + 2) {
                  // Account Pages header
                  return ListTile(
                    title: Text(AppLocalizations.of(context)!.accountpages),
                  );
                } else if (index == _drawerItems.length + 3) {
                  // Profile item
                  return ListTile(
                    leading: Icon(Icons.person),
                    title: Text(AppLocalizations.of(context)!.profile),
                    onTap: () {
                      // Add functionality for Profile
                    },
                  );
                } else if (index == _drawerItems.length + 4) {
                  // Logout item
                  return ListTile(
                    leading: Icon(Icons.logout),
                    title: Text(AppLocalizations.of(context)!.logout),
                    onTap: () {
                      // Add functionality for Logout
                    },
                  );
                } else {
                  // Regular drawer items
                  return ListTile(
                    title: Text(_drawerItems[index - 1]),
                    onTap: () {
                      setState(() {
                        switch (_drawerItems[index - 1]) {
                          case 'Menu':
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => MenuScreen()), // Replace with your ReportsScreen
                            );
                            break;
                          case 'Orders':
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => HomeScreen()), // Replace with your PaymentsScreen
                            );
                            break;
                        // Add more cases for other drawer items

                          default:
                            setState(() {
                              _currentIndex = index - 1;
                            });
                        // Add navigation logic here based on the selected item
                        // Example: Navigator.pushNamed(context, '/${_drawerItems[index - 1].toLowerCase()}');
                        }
                      });
                    },
                    tileColor: _currentIndex == index - 1 ? Colors.grey.withOpacity(0.5) : null,
                    leading: _getDrawerIcon(index - 1),
                  );
                }
              },
            ),
          ),
        ),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 4.0, 16.0, 16.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 10),
                  _buildDashboardBox(
                    title: 'Today\'s Sales',
                    value: '\SR 500  +25',
                    color: Colors.transparent,
                    boxWidth: boxWidth,
                  ),
                  SizedBox(height: 10),
                  _buildDashboardBox(
                    title: 'Today\'s Items Sold',
                    value: '100 +20',
                    color: Colors.transparent,
                    boxWidth: boxWidth,
                  ),
                  SizedBox(height: 10),
                  _buildDashboardBox(
                    title: 'New Orders',
                    value: '5 +1',
                    color: Colors.transparent,
                    boxWidth: boxWidth,
                  ),
                  SizedBox(height: 10),
                  LineChartSample1(),
                  SizedBox(height: 20),
                  HistogramDefault(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDashboardBox({
    required String title,
    required String value,
    required Color color,
    required double boxWidth,
  }) {
    List<String> parts = value.split('+');
    String mainValue = parts[0].trim();
    String additionalValue = '+' + parts[1].trim();

    return Container(
      height: 55,
      width: boxWidth,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.themeColor2, width: 2),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      letterSpacing: 1,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        mainValue,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black38,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        additionalValue,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.green,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(width: 5),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.black38,
            ),
          ],
        ),
      ),
    );
  }

  Widget _getDrawerIcon(int index) {
    switch (index) {
      case 0:
        return Icon(Icons.dashboard);
      case 1:
        return Icon(Icons.bar_chart);
      case 2:
        return Icon(Icons.credit_card);
      case 3:
        return Icon(Icons.restaurant);
      case 4:
        return Icon(Icons.timer_sharp);
      default:
        return Icon(Icons.error);
    }
  }
}
