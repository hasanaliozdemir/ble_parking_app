import 'package:google_maps_flutter/google_maps_flutter.dart';
enum Status{
  deselected,
  selected,
  admin,
  disable,
  owner
}



class Park{
  final String id;
  final String name;
  final LatLng position;
  final double price;
  final Status status;
  final bool isWeithElectricity;
  final double point;

  Park(this.name, this.position, this.price, this.status, this.isWeithElectricity, this.id, this.point);
  
}