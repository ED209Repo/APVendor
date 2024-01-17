import 'dart:convert';
import 'package:flutter/material.dart';
import 'Add_Items.dart';
import 'Widgets/AppColors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:http/http.dart' as http;

class AddCategoryScreen extends StatefulWidget {
  @override
  _AddCategoryScreenState createState() => _AddCategoryScreenState();
}

class _AddCategoryScreenState extends State<AddCategoryScreen> {
  final TextEditingController categoryNameController = TextEditingController();
  final TextEditingController categoryDescriptionController = TextEditingController();

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
  Future<void> _addCategory() async {
    final String categoryName = categoryNameController.text;
    final String categoryDescription = categoryDescriptionController.text;

    // Replace the URL with your actual API endpoint
    final String apiUrl = 'https://00f3-154-192-64-39.ngrok-free.app/api/ResturantCategory/ResturantCategory';

    // Replace this with the actual request payload
    final Map<String, dynamic> requestData = {
      'rest_Cat_id': '',
      'rest_id': '',
      'cat_temp_id': '',
      'name': categoryName,
      'parent_Category': '',
      'categoryDescription': categoryDescription,
    };

    try {
      final http.Response response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestData),
      );

      if (response.statusCode == 200) {
        // API call was successful, you can handle the response if needed
        print('Category added successfully');
      } else {
        // API call failed, handle the error
        print('Failed to add category. Status code: ${response.statusCode}');
      }
    } catch (error) {
      // Handle other errors such as network errors
      print('Error during API call: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.addcategory, style: TextStyle(color: Colors.white, fontSize: 20)),
        backgroundColor: AppColors.themeColor2,
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: categoryNameController,
              decoration: _inputDecoration(AppLocalizations.of(context)!.categoryname),
            ),
            SizedBox(height: 16),
            TextField(
              controller: categoryDescriptionController,
              decoration: _inputDecoration(AppLocalizations.of(context)!.categorydescription),
            ),
            SizedBox(height: 16),
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton.icon(
                onPressed: () async {
                  await _addCategory(); // Call the API to add the category

                  // After adding the category, navigate to the AddItemsScreen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddItemsScreen(
                        themeColor: AppColors.themeColor2,
                        categoryName: categoryNameController.text,
                      ),
                    ),
                  );
                },
                icon: Icon(Icons.add),
                label: Text(AppLocalizations.of(context)!.additems),
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.themeColor2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
