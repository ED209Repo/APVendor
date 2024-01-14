import 'package:flutter/material.dart';
class Restaurant {
  final String name;
  final String type;
  final String slogan;
  List<String>offDays=[];
  final TimeOfDay? openingTime;
  final TimeOfDay? closingTime;
  final String location;
  final String combinedTime;
  final String businessId;
  final String licenseId;

  Restaurant({
    required this.name,
    required this.type,
    required this.slogan,
    required this.openingTime,
    required this.closingTime,
    required this.offDays,
    required this.location, 
    required this.combinedTime, 
    required this.businessId, required this.licenseId,
  });
}
