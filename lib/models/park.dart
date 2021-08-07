import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

enum Status { deselected, selected, admin, disable, owner }

class Park {
  final bool isWithCam;
  final bool isWithSecurity;
  final int id;
  final String name;
  final double price;
  final Status status;
  final bool isWeithElectricity;
  final double point;
  final int parkSpace;
  final int filledParkSpace;
  final double longitude;
  final double latitude;

  Park(
      {
      @required this.longitude,
      @required this.latitude,
      @required this.name,
      @required this.price,
      @required this.status,
      @required this.isWeithElectricity,
      @required this.id,
      @required this.point,
      @required this.isWithCam,
      @required this.isWithSecurity,
      @required this.parkSpace,
      @required this.filledParkSpace});
}
