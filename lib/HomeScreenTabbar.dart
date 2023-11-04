import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:vendor/Widgets/AppColors.dart';
import 'OrdersModel.dart';

class SlidingSegmentedControlDemo extends StatefulWidget {
  @override
  _SlidingSegmentedControlDemoState createState() =>
      _SlidingSegmentedControlDemoState();
}

class _SlidingSegmentedControlDemoState
    extends State<SlidingSegmentedControlDemo> {
  int _currentIndex = 0;
  final GlobalKey<ExpansionTileCardState> cardA = GlobalKey();
  bool orderAccepted = false;
  int currentOrderIndex = 0;

  List<Order> orders = OrderModel.items;

  final List<String> _segments = ["Current", "Ready to Pick", "History"];

  @override
  Widget build(BuildContext context) {
    bool allOrdersProcessed = currentOrderIndex >= orders.length;
    final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
      ),
    );
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 20,right: 20),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: const Color(0xff00A4B4), // Change to your desired color
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
                          ? AppColors.themeColor2
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
        const SizedBox(height: 20),
        IndexedStack(
          index: _currentIndex,
          children: <Widget>[
            // Content for Segment 1
            Container(
              height: 300,
              width: double.infinity,
              child: allOrdersProcessed
                  ? Center(
                child: Text(
                  "All orders have been processed.",
                  style: TextStyle(
                    color: AppColors.themeColor2,
                    fontSize: 18.0,
                  ),
                ),
              ) : ListView(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: ExpansionTileCard(
                      expandedColor: AppColors.themeColor2,
                      expandedTextColor: Colors.white,
                      baseColor: AppColors.themeColor2,
                      key: cardA,
                      leading:  CircleAvatar(child:  ClipRRect(
                        borderRadius: BorderRadius.circular(12.0),
                        child: Image.asset(
                          orders[currentOrderIndex].imageUrl, // Access imageUrl for the current order
                          fit: BoxFit.cover,
                        ),
                      ),),
                      title:  Text('Title: ${orders[currentOrderIndex].title}',
                        style: const TextStyle(
                          color: Colors.white,
                        ),),
                      subtitle: Text('Order No: ${orders[currentOrderIndex].orderNo}', style: const TextStyle(
                        color: Colors.white,
                      ),),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min, // Ensure buttons are close together
                        children: [
                          Container(
                            height: 40,
                            width: 50,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.green,
                            ),
                            child: IconButton(
                              style: flatButtonStyle,
                              onPressed: () {
                                // Handle Accept button
                                // You can add your logic here to handle the order acceptance
                                // For this example, we'll move to the next order in the list
                                if (currentOrderIndex < orders.length - 1) {
                                  currentOrderIndex++;
                                  setState(() {});
                                }
                              },
                              icon: const Icon(Icons.done,color: Colors.white,),
                            ),
                          ),
                          Container(
                            height: 40,
                            width: 50,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.red,
                            ),
                            child: IconButton(
                              style: flatButtonStyle,
                              onPressed: () {
                                // Handle Reject button
                                // You can add your logic here to handle order rejection
                                // For this example, we'll move to the next order in the list
                                if (currentOrderIndex < orders.length - 1) {
                                  currentOrderIndex++;
                                  setState(() {});
                                }
                              },
                              icon: const Icon(Icons.clear,color: Colors.white,),
                            ),
                          ),
                        ],
                      ),
                      children: <Widget>[
                        const Divider(
                          thickness: 1.0,
                          height: 1.0,
                        ),
                        Column(
                          children: <Widget>[
                            ListTile(
                              tileColor: AppColors.themeColor2,
                              title:  Text('${orders[currentOrderIndex].description}',style: const TextStyle(
                                color: Colors.white,
                              ),),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Content for Segment 2
            Container(
              height: 300,
              width: double.infinity,
              child: const Center(
                child: Text("Segment 2 Content"),
              ),
            ),
            // Content for Segment 3
            Container(
              height: 300,
              width: double.infinity,
              child: const Center(
                child: Text("Segment 3 Content"),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
