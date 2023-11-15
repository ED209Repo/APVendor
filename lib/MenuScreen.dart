import 'package:flutter/material.dart';
import 'OrdersModel.dart';
import 'Widgets/AppColors.dart';

class MenuScreen extends StatefulWidget {
  @override
  _MenuScreenState createState() =>
      _MenuScreenState();
}

class _MenuScreenState
    extends State<MenuScreen> {
  int _currentIndex = 0;
  int currentOrderIndex = 0;

  List<Order> orders = OrderModel.items;

  final List<String> _segments = ["   All items   ", "   Deals  ", "   Items+Addons   "];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Menu'
        ),
        backgroundColor: AppColors.themeColor,
        automaticallyImplyLeading: false,
        centerTitle: true,
        actions: [
    IconButton(
    icon: Icon(Icons.add, color: Colors.white),
    onPressed: () {}
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
        ],
      ),
    );
  }
}
