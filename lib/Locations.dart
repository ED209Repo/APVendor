import 'package:flutter/material.dart';

import 'Widgets/AppColors.dart';

class LocationScreen extends StatefulWidget {
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.themeColor2,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
        title: Text('Locations', style: TextStyle(color: Colors.white, fontSize: 24)),
        actions: [
          IconButton(
            icon: Icon(Icons.add, color: Colors.white),
            onPressed: () {
              // Navigator.push(context, MaterialPageRoute(builder: (context) => AddEmployeeScreen(
              //     onEmployeeAdded: (Employee? newEmployee) {
              //       if (newEmployee != null) {
              //         setState(() {
              //           employees.add(newEmployee);
              //         });
              //       }
              //     }
              // )));
            },
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 16.0),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Container( // Wrap the TextField with a Container
              decoration: BoxDecoration(
                color: Color(0xff358597).withOpacity(0.3), // Set the desired color and opacity
                borderRadius: BorderRadius.circular(20.0), // Adjust the radius as needed
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search your locations',
                  prefixIcon: Icon(Icons.search),
                  border: InputBorder.none, // Remove the border to let the container's decoration handle it
                ),
              ),
            ),
          ),
          // Expanded(
          //   child: EmployeeList(employees: employees),
          // ),
        ],
      ),
    );
  }
}
