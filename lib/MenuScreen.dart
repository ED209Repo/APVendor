import 'package:flutter/material.dart';
import 'package:vendor/Add_Items.dart';
import 'Widgets/AppColors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ItemData {
  final String itemName;
  final String itemPrice;

  ItemData({required this.itemName, required this.itemPrice});
  String getItemName() {
    return itemName;
  }

  String getItemPrice() {
    return itemPrice;
  }
}


class MenuScreen extends StatefulWidget {
  static List<ItemData> items = [];
  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  int _currentIndex = 0;
  ItemData? itemData;

  late List<String> _segments;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _segments = [
      AppLocalizations.of(context)!.allitems,
      AppLocalizations.of(context)!.deals,
      AppLocalizations.of(context)!.itemsaddons,
    ];
  }

  @override
  Widget build(BuildContext context) {
    print('Number of items: ${MenuScreen.items.length}');
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.menu),
        backgroundColor: AppColors.themeColor,
        automaticallyImplyLeading: false,
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.add, color: Colors.white),
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddItemsScreen(themeColor: AppColors.themeColor)),
              );
              if (result != null && result is ItemData) {
                setState(() {
                  MenuScreen.items.add(result);
                });
              }
            },
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 17, right: 17),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: AppColors.themeColor.withOpacity(0.7),
              ),
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: _segments
                    .asMap()
                    .entries
                    .map(
                      (MapEntry<int, String> entry) => GestureDetector(
                    onTap: () {
                      setState(() {
                        _currentIndex = entry.key;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: _currentIndex == entry.key
                            ? AppColors.themeColor
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        entry.value,
                        style: TextStyle(
                          color: _currentIndex == entry.key
                              ? Colors.white
                              : Colors.white,
                        ),
                      ),
                    ),
                  ),
                )
                    .toList(),
              ),
            ),
          ),
          // Add your other widgets below the segment control
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 17),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
                itemCount: MenuScreen.items.length,
                itemBuilder: (context, index) {
                  var item = MenuScreen.items[index];
                  return Card(
                    elevation: 2,
                    margin: EdgeInsets.all(8),
                    child: Container(
                      height: 150,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Replace 'placeholder.jpg' with the actual path to your photo
                          Image.asset(
                            'images/hardees2.png',
                            height: 110, // Adjust the height as needed
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 5.0, right: 5, bottom: 4),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.getItemName(),
                                  maxLines: 1, // Set the maximum number of lines
                                  overflow: TextOverflow.ellipsis, // Truncate the text with ellipsis (...) if it exceeds maxLines
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'SR ${item.getItemPrice()}',
                                  style: TextStyle(fontSize: 14, color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}