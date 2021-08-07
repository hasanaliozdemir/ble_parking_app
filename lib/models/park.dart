import 'package:flutter/material.dart';

enum Status { deselected, selected, admin, disable, owner }

class Park {
  final bool isClosedPark;
  final bool isWithCam;
  final bool isWithSecurity;
  final int id;
  final String name;
  final double price;
  final Status status;
  final bool isWithElectricity;
  final double point;
  final int parkSpace;
  final int filledParkSpace;
  final double longitude;
  final double latitude;
  final List<String> imageUrls;
  final String location;

  Park(
      {
      @required this.location,
      @required this.imageUrls,
      @required this.isClosedPark,
      @required this.longitude,
      @required this.latitude,
      @required this.name,
      @required this.price,
      @required this.status,
      @required this.isWithElectricity,
      @required this.id,
      @required this.point,
      @required this.isWithCam,
      @required this.isWithSecurity,
      @required this.parkSpace,
      @required this.filledParkSpace});
}
