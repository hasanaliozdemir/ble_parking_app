import 'package:google_maps_flutter/google_maps_flutter.dart';
enum Status{
  deselected,
  selected,
  admin,
  disable,
  owner
}



class Park{
  final String name;
  final LatLng position;
  final int price;
  final Status status;
  final bool isWeithElectricity;

  Park(this.name, this.position, this.price, this.status, this.isWeithElectricity);
  
}