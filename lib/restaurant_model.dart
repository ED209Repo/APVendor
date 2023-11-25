import 'package:flutter/material.dart';
class Restaurant {
  final String name;
  final String type;
  final String slogan;
  final TimeOfDay? openingTime;
  final TimeOfDay? closingTime;
  final String location;

  Restaurant({
    required this.name,
    required this.type,
    required this.slogan,
    required this.openingTime,
    required this.closingTime,
    required this.location,
  });
}
