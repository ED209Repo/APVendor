import 'package:flutter/material.dart';
import 'MenuScreen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class AddItemsScreen extends StatefulWidget {
  final Color themeColor;
  final String categoryName;
  AddItemsScreen({required this.themeColor, required this.categoryName});

  @override
  _AddItemsScreenState createState() => _AddItemsScreenState();
}

class _AddItemsScreenState extends State<AddItemsScreen> {
  TimeOfDay? selectedTime;
  String? variationName;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.additems, style: TextStyle(color: Colors.white, fontSize: 20)),
          backgroundColor: widget.themeColor,
          centerTitle: true,
          elevation: 0,
        ),
        body: Column(
          children: [
            SizedBox(height: 16),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(25),
              ),
              child: TabBar(
                labelColor: Colors.white,
                unselectedLabelColor: widget.themeColor,
                indicator: BoxDecoration(
                  color: widget.themeColor,
                  borderRadius: BorderRadius.circular(25),
                ),
                tabs: [
                  Container(
                    height: 40, // Set the height as needed
                    alignment: Alignment.center,
                    child: Text(AppLocalizations.of(context)!.items),
                  ),
                  Container(
                    height: 40, // Set the height as needed
                    alignment: Alignment.center,
                    child: Text(AppLocalizations.of(context)!.addonsonly),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: TabBarView(
                children: [
                  AddItemsTab(categoryName: widget.categoryName, selectedTime: selectedTime, themeColor: widget.themeColor),
                  AddOnsTab(themeColor: widget.themeColor),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AddItemsTab extends StatefulWidget {
  final Color themeColor;
  final String categoryName;
  TimeOfDay? selectedTime;
  String? variationName;

  AddItemsTab({required this.categoryName, this.selectedTime, this.variationName, required this.themeColor});

  @override
  _AddItemsTabState createState() => _AddItemsTabState();
}

class _AddItemsTabState extends State<AddItemsTab> {
  late TextEditingController readyTimeController;
  late TextEditingController nameController;
  late TextEditingController priceController;

  List<String> variationNames = [];

  @override
  void initState() {
    super.initState();
    readyTimeController = TextEditingController();
    nameController = TextEditingController();
    priceController = TextEditingController();
  }

  void updateVariationNames(String newVariationName) {
    setState(() {
      variationNames.add(newVariationName);
    });
  }

  void _saveItemData() {
    var itemName = nameController.text;
    var itemPrice = priceController.text;

    var itemData = ItemData(
      itemName: itemName,
      itemPrice: itemPrice,
    );

    // Add the itemData to the MenuScreen.items list
    Navigator.of(context).pop(itemData);
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double buttonHeight = screenHeight * 0.06;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: widget.themeColor,
                    width: 3,
                  ),
                ),
                labelText: AppLocalizations.of(context)!.name,
                labelStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: priceController,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: widget.themeColor,
                          width: 3,
                        ),
                      ),
                      labelText: AppLocalizations.of(context)!.price,
                      labelStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: DropdownButtonFormField(
                    items: [widget.categoryName]
                        .map((String category) {
                      return DropdownMenuItem(
                        value: category,
                        child: Text(category),
                      );
                    }).toList(),
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: widget.themeColor,
                          width: 3,
                        ),
                      ),
                      labelText: AppLocalizations.of(context)!.itemcategory,
                      labelStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                    onChanged: (value) {
                      // Handle category selection
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: widget.themeColor,
                          width: 3,
                        ),
                      ),
                      labelText: AppLocalizations.of(context)!.readytime,
                      labelStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                    controller: readyTimeController,
                    onTap: () async {
                      final selectedTime = await showTimePicker(
                        context: context,
                        initialTime: this.widget.selectedTime ??
                            TimeOfDay.now(),
                      );

                      if (selectedTime != null) {
                        setState(() {
                          this.widget.selectedTime = selectedTime;
                          readyTimeController.text =
                          "${selectedTime.hour}:${selectedTime.minute}";
                        });
                      }
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Container(
                  width: 100,
                  child: GestureDetector(
                    onTap: () {
                      // Add Item Image Action
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 1),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: InputDecorator(
                        decoration: InputDecoration(
                          labelText: AppLocalizations.of(context)!.itemimage,
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
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: widget.themeColor,
                    width: 3,
                  ),
                ),
                labelText: AppLocalizations.of(context)!.description,
                labelStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
            ),
            SizedBox(height: 16),
            if (widget.variationName != null && widget.variationName!.isNotEmpty)
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: widget.themeColor, width: 2),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                padding: EdgeInsets.all(8.0),
                margin: EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (variationNames.isNotEmpty) ...[
                      Text(AppLocalizations.of(context)!.variations),
                      for (int i = 0; i < variationNames.length; i++)
                        Text('${i + 1}. ${variationNames[i]}'),
                    ],
                  ],
                ),
              ),
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton.icon(
                onPressed: () {
                  // Add Variations/Options Action
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddVariationsScreen(
                        onVariationNameChanged: (newVariationName) {
                          if (newVariationName.isNotEmpty) {
                            setState(() {
                              widget.variationName = newVariationName;
                            });
                            updateVariationNames(newVariationName);
                          }
                        },
                          themeColor: widget.themeColor),
                      ),
                  );
                },
                icon: Icon(Icons.add),
                label: Text(AppLocalizations.of(context)!.addoptions),
                style: TextButton.styleFrom(
                  foregroundColor: widget.themeColor,
                ),
              ),
            ),
            SizedBox(height: 16),
            TextButton(
              onPressed: () {
                // Save Item Data Action
                _saveItemData();
              },
              child: Text(
                AppLocalizations.of(context)!.saveitem,
                style: TextStyle(color: Colors.white),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(widget.themeColor),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                minimumSize: MaterialStateProperty.all<Size>(
                  Size(double.infinity, buttonHeight),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AddOnsTab extends StatelessWidget {
  final Color themeColor;

  AddOnsTab({required this.themeColor});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double buttonHeight = screenHeight * 0.06;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: TextField(
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: themeColor,
                            width: 3,
                          ),
                        ),
                        labelText: AppLocalizations.of(context)!.name,
                        labelStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: TextField(
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: themeColor,
                            width: 3,
                          ),
                        ),
                        labelText: AppLocalizations.of(context)!.price,
                        labelStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            DropdownButtonFormField(
              items: ['Category 1', 'Category 2', 'Category 3']
                  .map((String category) {
                return DropdownMenuItem(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: themeColor,
                    width: 3,
                  ),
                ),
                labelText: AppLocalizations.of(context)!.itemcategory,
                labelStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
              onChanged: (value) {
                // Handle category selection
              },
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Container(
                  width: 100,
                  child: GestureDetector(
                    onTap: () {
                      // Add Item Image Action
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 1),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: InputDecorator(
                        decoration: InputDecoration(
                          labelText: AppLocalizations.of(context)!.itemimage,
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
            SizedBox(height: 16),
            TextButton(
              onPressed: () {
                // Save Item Action
              },
              child: Text(
                AppLocalizations.of(context)!.saveitem,
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(themeColor),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                minimumSize: MaterialStateProperty.all<Size>(
                  Size(double.infinity, buttonHeight),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AddVariationsScreen extends StatefulWidget {
  final Color themeColor;
  final Function(String) onVariationNameChanged;

  AddVariationsScreen({required this.onVariationNameChanged, required this.themeColor});
  @override
  _AddVariationsScreenState createState() => _AddVariationsScreenState();
}

class _AddVariationsScreenState extends State<AddVariationsScreen> {
  bool isPriceDependent = false;
  String variationName = "";
  List<Map<String, String>> variationOptionsList = [];

  TextEditingController nameController = TextEditingController();
  TextEditingController annotationsController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController additionalPriceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double buttonHeight = screenHeight * 0.06;
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.addoptions, style: TextStyle(color: Colors.white, fontSize: 20)),
        backgroundColor: widget.themeColor,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onChanged: (value) {
                setState(() {
                  variationName = value;
                });
              },
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: widget.themeColor,
                    width: 3,
                  ),
                ),
                labelText: 'Variation Name',
                labelStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Text('Price Dependent?'),
                SizedBox(width: 16),
                Switch(
                  value: isPriceDependent,
                  onChanged: (value) {
                    setState(() {
                      isPriceDependent = value;
                    });
                  },
                  activeTrackColor: widget.themeColor,
                  activeColor: Colors.white,
                ),
              ],
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: variationOptionsList.length,
                itemBuilder: (context, index) {
                  var optionData = variationOptionsList[index];
                  return Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: widget.themeColor, width: 2),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    padding: EdgeInsets.all(8.0),
                    margin: EdgeInsets.symmetric(vertical: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Option Name: ${optionData['name']}'),
                        Text('Annotations: ${optionData['annotations']}'),
                        if (optionData.containsKey('price')) ...[
                          Text('Price: ${optionData['price']}'),
                          Text('Additional Price: ${optionData['additionalPrice']}'),
                        ],
                      ],
                    ),
                  );
                },
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton.icon(
                onPressed: () {
                  _showAddVariationOptionsPopup(context);
                },
                icon: Icon(Icons.add), // Add an appropriate icon here
                label: Text('Add Variation Options'),
                style: TextButton.styleFrom(
                  foregroundColor: widget.themeColor,
                ),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Save Action
                if (variationName.isNotEmpty) {
                  widget.onVariationNameChanged(variationName);
                  Navigator.pop(context); // Close the screen without passing any data
                } else {
                  // Show an error message or handle the case where variationName is empty
                }
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(widget.themeColor,),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                minimumSize: MaterialStateProperty.all<Size>(
                  Size(double.infinity, buttonHeight),
                ),
              ),
              child: Text('Save', style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddVariationOptionsPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Options'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: annotationsController,
                decoration: InputDecoration(labelText: 'Annotations'),
              ),
              if (isPriceDependent) ...[
                TextField(
                  controller: priceController,
                  decoration: InputDecoration(labelText: 'Price'),
                ),
                TextField(
                  controller: additionalPriceController,
                  decoration: InputDecoration(labelText: 'Additional Price'),
                ),
              ],
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  var optionData = {
                    'name': nameController.text,
                    'annotations': annotationsController.text,
                  };

                  if (isPriceDependent) {
                    optionData['price'] = priceController.text;
                    optionData['additionalPrice'] = additionalPriceController.text;
                  }

                  setState(() {
                    variationOptionsList.add(optionData);
                    // Clear the text fields
                    nameController.clear();
                    annotationsController.clear();
                    priceController.clear();
                    additionalPriceController.clear();
                  });
                  Navigator.pop(context); // Close the popup
                },
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                  backgroundColor: MaterialStateProperty.all<Color>(widget.themeColor),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
                child: Text('Save'),
              ),
            ],
          ),
        );
      },
    );
  }
}
