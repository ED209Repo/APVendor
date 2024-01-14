import 'package:flutter/material.dart';
import 'Add_Items.dart';
import 'Widgets/AppColors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
          ],
        ),
      ),
    );
  }
}
