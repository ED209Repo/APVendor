import 'package:flutter/material.dart';
import 'package:vendor/Add_Items.dart';
import 'AddCategory.dart';
import 'Widgets/AppColors.dart';
import 'restaurant_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
  TimeOfDay? openingTime;
  TimeOfDay? closingTime;
  final TextEditingController locationController = TextEditingController();


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

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double buttonHeight = screenHeight * 0.06;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(AppLocalizations.of(context)!.addrestaurant, style: TextStyle(color: Colors.white, fontSize: 20)),
        backgroundColor: AppColors.themeColor2,
        automaticallyImplyLeading: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
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
              decoration: _inputDecoration('Name'),
            ),
            SizedBox(height: 7),
            TextField(
              controller: typeController,
              decoration: _inputDecoration('Type'),
            ),
            SizedBox(height: 7),
            TextField(
              controller: sloganController,
              decoration: _inputDecoration('Slogan'),
            ),
            SizedBox(height: 7),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () async {
                      final pickedTime = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if (pickedTime != null) {
                        setState(() {
                          openingTime = pickedTime;
                        });
                      }
                    },
                    child: InputDecorator(
                      decoration: _inputDecoration('Open Time'),
                      child: Text(
                        openingTime != null
                            ? "${openingTime!.hour}:${openingTime!.minute}"
                            : '',
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
                        initialTime: TimeOfDay.now(),
                      );
                      if (pickedTime != null) {
                        setState(() {
                          closingTime = pickedTime;
                        });
                      }
                    },
                    child: InputDecorator(
                      decoration: _inputDecoration('Close Time'),
                      child: Text(
                        closingTime != null
                            ? "${closingTime!.hour}:${closingTime!.minute}"
                            : '',
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
              decoration: _inputDecoration('Location'),
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
                          labelText: ' Add Logo',
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
                label: Text('Add Categories'),
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
                // Perform necessary actions when adding a restaurant

                // Create a Restaurant object with the entered details
                Restaurant newRestaurant = Restaurant(
                  name: nameController.text,
                  type: typeController.text,
                  slogan: sloganController.text,
                  openingTime: openingTime,
                  closingTime: closingTime,
                  location: locationController.text,
                );

                // Navigate back to the previous screen and pass the new restaurant
                Navigator.pop(context, newRestaurant);
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
      ),
    );
  }
}
