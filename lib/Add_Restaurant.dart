import 'package:flutter/material.dart';
import 'package:vendor/Add_Items.dart';
import 'AddCategory.dart';
import 'Widgets/AppColors.dart';
import 'restaurant_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddRestaurantScreen extends StatefulWidget {
  final Restaurant? editRestaurant;

  AddRestaurantScreen({this.editRestaurant});

  @override
  _AddRestaurantScreenState createState() => _AddRestaurantScreenState();
}

class _AddRestaurantScreenState extends State<AddRestaurantScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController typeController = TextEditingController();
  final TextEditingController sloganController = TextEditingController();
  final TextEditingController businessController = TextEditingController();
  final TextEditingController licenseController = TextEditingController();
  List<String> selectedOffDays = [];
  TimeOfDay? openingTime;
  TimeOfDay? closingTime;
  final TextEditingController locationController = TextEditingController();

  String getCombinedTime() {
    if (openingTime != null && closingTime != null) {
      final openingTimeString = _formatTime(openingTime!);
      final closingTimeString = _formatTime(closingTime!);
      return '$openingTimeString - $closingTimeString';
    }
    return '';
  }

  String _formatTime(TimeOfDay time) {
    final hour = time.hourOfPeriod;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.period == DayPeriod.am ? 'AM' : 'PM';
    return '$hour:$minute $period';
  }

  InputDecoration _inputDecoration(String labelText) {
    return InputDecoration(
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: AppColors.themeColor2,
          width: 3,
        ),
      ),
      labelText: labelText,
      labelStyle: TextStyle(
        color: Colors.black,
        fontSize: 16,
      ),
    );
  }

  Future<void> _selectOffDays(BuildContext context) async {
    List<String>? newSelectedOffDays = await showDialog<List<String>>(
      context: context,
      builder: (BuildContext context) {
        List<String> days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
        List<String> selectedDays = List.from(selectedOffDays);

        return AlertDialog(
          title: Text('Select Off Days'),
          content: Wrap(
            spacing: 8.0,
            children: days.map((day) {
              return FilterChip(
                label: Text(day),
                selected: selectedDays.contains(day),
                onSelected: (isSelected) {
                  if (isSelected) {
                    selectedDays.add(day);
                  } else {
                    selectedDays.remove(day);
                  }
                },
              );
            }).toList(),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(selectedDays);
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );

    if (newSelectedOffDays != null) {
      setState(() {
        selectedOffDays = newSelectedOffDays;
      });
    }
  }
  Future<void> _sendApiRequest(Restaurant newRestaurant) async {
    final url = 'https://948b-206-84-147-31.ngrok-free.app/api/searchRest/Add_Resturant'; // Replace with your actual API endpoint

    final Map<String, dynamic> requestBody = {
      "resturant_Name": newRestaurant.name,
      "open_Close_Time": newRestaurant.combinedTime,
      "offdays": newRestaurant.offDays.join(', '), // Combine selected days into a single string
      "resturant_type": newRestaurant.type,
      "business_Id": newRestaurant.businessId,
      "licesnes_Id": newRestaurant.licenseId,
    };

    final response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(requestBody),
    );

    if (response.statusCode == 200) {
      // API call successful
      print('API Call Successful');
      print(response.body);
    } else {
      // API call failed
      print('API Call Failed');
      print(response.statusCode);
      print(response.body);
    }
  }


  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double buttonHeight = screenHeight * 0.06;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(AppLocalizations.of(context)!.addrestaurant,
            style: TextStyle(color: Colors.white, fontSize: 20)),
        backgroundColor: AppColors.themeColor2,
        automaticallyImplyLeading: true,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Text(
            AppLocalizations.of(context)!.restaurantdetails,
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
            ),
          ),
          SizedBox(height: 16),
          TextField(
            controller: nameController,
            decoration: _inputDecoration(AppLocalizations.of(context)!.name),
          ),
          SizedBox(height: 7),
          TextField(
            controller: typeController,
            decoration: _inputDecoration(AppLocalizations.of(context)!.type),
          ),
          SizedBox(height: 7),
          TextField(
            controller: sloganController,
            decoration: _inputDecoration(AppLocalizations.of(context)!.slogan),
          ),
          SizedBox(height: 7),
          TextButton(
            onPressed: () {
              _selectOffDays(context);
            },
            child: InputDecorator(
              decoration: _inputDecoration(AppLocalizations.of(context)!.offdays),
              child: Text(
                selectedOffDays.isNotEmpty ? '${selectedOffDays.join(', ')}' : '',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
          SizedBox(height: 7),
          TextField(
            controller: businessController,
            decoration: _inputDecoration(AppLocalizations.of(context)!.businessid),
          ),
          SizedBox(height: 7),
          TextField(
            controller: licenseController,
            decoration: _inputDecoration(AppLocalizations.of(context)!.licenseid),
          ),
          SizedBox(height: 7),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () async {
                    final pickedTime = await showTimePicker(
                      context: context,
                      initialTime: openingTime ?? TimeOfDay.now(),
                    );
                    if (pickedTime != null) {
                      setState(() {
                        openingTime = pickedTime;
                        // Reset closing time when changing opening time period
                        if (closingTime != null && openingTime!.period != closingTime!.period) {
                          closingTime = null;
                        }
                      });
                    }
                  },
                  child: InputDecorator(
                    decoration: _inputDecoration(AppLocalizations.of(context)!.opentime),
                    child: Text(
                      openingTime != null ? _formatTime(openingTime!) : '',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: GestureDetector(
                  onTap: () async {
                    final pickedTime = await showTimePicker(
                      context: context,
                      initialTime: closingTime ?? TimeOfDay.now(),
                    );
                    if (pickedTime != null) {
                      setState(() {
                        closingTime = pickedTime;
                      });
                    }
                  },
                  child: InputDecorator(
                    decoration: _inputDecoration(AppLocalizations.of(context)!.closetime),
                    child: Text(
                      closingTime != null ? _formatTime(closingTime!) : '',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 7),
          TextField(
            controller: locationController,
            decoration: _inputDecoration(AppLocalizations.of(context)!.location),
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Container(
                width: 100, // Adjust the width as needed
                child: GestureDetector(
                  onTap: () {
                    // Add Logo Action
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: InputDecorator(
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!.logoimage,
                        labelStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(Icons.camera_alt),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Align(
            alignment: Alignment.centerLeft,
            child: TextButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddCategoryScreen()),
                );
              },
              icon: Icon(Icons.add),
              label: Text(AppLocalizations.of(context)!.addcategory),
              style: TextButton.styleFrom(
                foregroundColor: AppColors.themeColor2,
              ),
            ),
          ),
          SizedBox(height: 10),
          Align(
            alignment: Alignment.centerLeft,
            child: TextButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddItemsScreen(themeColor: AppColors.themeColor2)),
                );
              },
              icon: Icon(Icons.add),
              label: Text(AppLocalizations.of(context)!.additems),
              style: TextButton.styleFrom(
                foregroundColor: AppColors.themeColor2,
              ),
            ),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () async {
              // Create a Restaurant object with the entered details
              Restaurant newRestaurant = Restaurant(
                name: nameController.text,
                type: typeController.text,
                slogan: sloganController.text,
                combinedTime: getCombinedTime(),
                offDays: selectedOffDays,
                businessId: businessController.text,
                licenseId: licenseController.text,
                location: locationController.text,
              );

              // Add the restaurant locally
              Navigator.pop(context, newRestaurant);

              // Send data to the backend API
              await _sendApiRequest(newRestaurant);
            },
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              backgroundColor: MaterialStateProperty.all<Color>(Color(0xff358597)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              minimumSize: MaterialStateProperty.all<Size>(
                Size(double.infinity, buttonHeight),
              ),
            ),
            child: Text(AppLocalizations.of(context)!.addrestaurant),
          ),
        ],
      ),
    );
  }
}
