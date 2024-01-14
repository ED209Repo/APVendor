import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'dart:async';
import 'OrdersModel.dart';
import 'Widgets/AppColors.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SlidingSegmentedControlDemo extends StatefulWidget {
  @override
  _SlidingSegmentedControlDemoState createState() =>
      _SlidingSegmentedControlDemoState();
}

class _SlidingSegmentedControlDemoState
    extends State<SlidingSegmentedControlDemo> {
  int _currentIndex = 0;
  int currentOrderIndex = 0;

  late List<String> _segments;
  late List<Order> orders;

  late Timer _timer1 = Timer(Duration.zero, () {});
  int _timerDuration1 = 0;
  bool showButtons1 = true;
  bool isOrderCompleted1 = false;
  bool isOrderCancelled1 = false;

  late Timer _timer2 = Timer(Duration.zero, () {});
  int _timerDuration2 = 0;
  bool showButtons2 = true;
  bool isOrderCompleted2 = false;
  bool isOrderCancelled2 = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _segments = [
      AppLocalizations.of(context)!.current,
      AppLocalizations.of(context)!.readytopick,
      AppLocalizations.of(context)!.history,
    ];

    orders = OrderModel.items;
  }

  void _startTimer1() {
    _timer1 = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_timerDuration1 <= 0) {
        timer.cancel();
        setState(() {
          isOrderCompleted1 = true;
        });
      } else {
        setState(() {
          _timerDuration1--;
        });
      }
    });
  }

  void _startTimer2() {
    _timer2 = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_timerDuration2 <= 0) {
        timer.cancel();
        setState(() {
          isOrderCompleted2 = true;
        });
      } else {
        setState(() {
          _timerDuration2--;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer1.cancel();
    _timer2.cancel();
    super.dispose();
  }

  void acceptOrder1() {
    if (_timerDuration1 == 0 && showButtons1) {
      setState(() {
        showButtons1 = false;
        _timerDuration1 = 5;
        _startTimer1();
      });
    }
  }

  void acceptOrder2() {
    if (_timerDuration2 == 0 && showButtons2) {
      setState(() {
        showButtons2 = false;
        _timerDuration2 = 5;
        _startTimer2();
      });
    }
  }

  void rejectOrder1() {
    if (showButtons1) {
      setState(() {
        showButtons1 = false;
        isOrderCancelled1 = true;
      });
    }
  }

  void rejectOrder2() {
    if (showButtons2) {
      setState(() {
        showButtons2 = false;
        isOrderCancelled2 = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.orderqueue),
        backgroundColor: AppColors.themeColor2,
        centerTitle: true,
        automaticallyImplyLeading: false,
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
                color: AppColors.themeColor2.withOpacity(0.7),
              ),
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: _segments
                    .asMap()
                    .entries
                    .map(
                      (MapEntry<int, String> entry) =>
                      GestureDetector(
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
          Expanded(
            child: IndexedStack(
              index: _currentIndex,
              children: [
                // Widget for the first segment
                Column(
                  children: [
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: SwipeActionCell(
                        key: ObjectKey(orders[currentOrderIndex]),
                        trailingActions: <SwipeAction>[
                          if (isOrderCompleted1)
                            SwipeAction(
                              performsFirstActionWithFullSwipe: true,
                              title: "Done",
                              onTap: (CompletionHandler handler) async {
                                handler(true);
                              },
                              color: AppColors.themeColor2,
                            ),
                        ],
                        child: ExpansionTileCard(
                          expandedColor: isOrderCancelled1
                              ? Colors.grey
                              : isOrderCompleted1
                              ? Colors.green
                              : AppColors.themeColor2,
                          expandedTextColor: Colors.white,
                          baseColor: isOrderCancelled1
                              ? Colors.grey
                              : isOrderCompleted1
                              ? Colors.green
                              : AppColors.themeColor2,
                          key: GlobalKey(),
                          leading: CircleAvatar(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12.0),
                              child: Image.asset(
                                orders[currentOrderIndex].imageUrl,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          title: Text(
                            '${orders[currentOrderIndex].title}',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          subtitle: Text(
                            'Order No: ${orders[currentOrderIndex].orderNo}',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          trailing: showButtons1
                              ? Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                height: 40,
                                width: 50,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.green,
                                ),
                                child: IconButton(
                                  onPressed: acceptOrder1,
                                  icon: Icon(Icons.done,
                                      color: Colors.white),
                                ),
                              ),
                              Container(
                                height: 40,
                                width: 50,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.red,
                                ),
                                child: IconButton(
                                  onPressed: rejectOrder1,
                                  icon: Icon(Icons.clear,
                                      color: Colors.white),
                                ),
                              ),
                            ],
                          )
                              : _timerDuration1 > 0
                              ? Text(
                            "${_timerDuration1 ~/ 60}:${(_timerDuration1 % 60)
                                .toString()
                                .padLeft(2, '0')}",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                            ),
                          )
                              : Text(
                            isOrderCancelled1
                                ? "Cancelled"
                                : "Ready to Pick",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                            ),
                          ),
                          children: <Widget>[
                            Divider(
                              thickness: 1.0,
                              height: 1.0,
                            ),
                            Column(
                              children: <Widget>[
                                ListTile(
                                  tileColor: isOrderCancelled1
                                      ? Colors.grey
                                      : AppColors.themeColor2,
                                  title: Text(
                                    '${orders[currentOrderIndex].description}',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                // Widget for the second segment
                Container(),

                // Widget for the third segment
                Container(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}