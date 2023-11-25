import 'package:flutter/material.dart';
import 'package:vendor/Add_Restaurant.dart';
import 'Widgets/AppColors.dart';
import 'restaurant_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class LocationScreen extends StatefulWidget {
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  List<Restaurant> restaurants = []; // List to store restaurants
  List<Restaurant> filteredRestaurants = []; // List to store filtered restaurants

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.themeColor2,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
        title: Text(AppLocalizations.of(context)!.locations, style: TextStyle(color: Colors.white, fontSize: 24)),
        actions: [
          IconButton(
            icon: Icon(Icons.add, color: Colors.white),
            onPressed: () async {
              final addedRestaurant = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddRestaurantScreen()),
              );

              if (addedRestaurant != null) {
                setState(() {
                  restaurants.add(addedRestaurant);
                  filteredRestaurants = List.from(restaurants); // Update filtered list
                });
              }
            },
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 16.0),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xff358597).withOpacity(0.3),
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: TextField(
                onChanged: (query) {
                  setState(() {
                    // Filter the restaurants based on the search query
                    filteredRestaurants = restaurants
                        .where((restaurant) =>
                        restaurant.name.toLowerCase().contains(query.toLowerCase()))
                        .toList();
                  });
                },
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)!.searchlocation,
                  prefixIcon: Icon(Icons.search),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Expanded(
            child: RestaurantList(restaurants: filteredRestaurants),
          ),
        ],
      ),
    );
  }
}

class RestaurantList extends StatelessWidget {
  final List<Restaurant> restaurants;

  RestaurantList({required this.restaurants});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: restaurants.length,
      itemBuilder: (context, index) {
        var restaurant = restaurants[index];
        return RestaurantCard(
          restaurant: restaurant,
          onEditPressed: () async {
            final updatedRestaurant = await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddRestaurantScreen(editRestaurant: restaurant)),
            );

            if (updatedRestaurant != null) {
              // Update the existing restaurant with the edited details
              restaurant = updatedRestaurant;
            }
          },
        );
      },
    );
  }
}

class RestaurantCard extends StatefulWidget {
  final Restaurant restaurant;
  final VoidCallback onEditPressed;

  RestaurantCard({required this.restaurant, required this.onEditPressed});

  @override
  _RestaurantCardState createState() => _RestaurantCardState();
}

class _RestaurantCardState extends State<RestaurantCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      color: AppColors.themeColor2.withOpacity(0.5),
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.restaurant.name,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                ElevatedButton.icon(
                  onPressed: widget.onEditPressed,
                  icon: Icon(Icons.edit),
                  label: Text(''),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: Image.asset(
                'images/mcdd.jpg', // Replace with your asset image path
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 8),
            Text(
              widget.restaurant.slogan,
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${widget.restaurant.type}',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
                Text(
                  '${widget.restaurant.location}',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
