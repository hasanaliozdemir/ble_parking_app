import 'package:flutter/material.dart';

enum Status { deselected, selected, admin, disable, owner }

class Park {
  final bool isClosedPark;
  final bool isWithCam;
  final bool isWithSecurity;
  final int id;
  final int ownerId;
  final String name;
  final double price;
  final Status status;
  final bool isWithElectricity;
  final double point;
  final int parkSpace;
  final int filledParkSpace;
  final double longitude;
  final double latitude;
  final List imageUrls;
  final String location;
  String info;

  Park(
      {
      @required this.ownerId,
      @required this.location,
      this.imageUrls,
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
      @required this.filledParkSpace,
      this.info
      });

  factory Park.fromJson(Map<String,dynamic> json){
    _organizeStatus(int stat){
    switch (stat) {
      case 0:
        return Status.admin;
        break;
      case 1:
        return Status.deselected;
        break;
      case 2:
        return Status.selected;
        break;
      case 3:
        return Status.disable;
        break;
      case 4:
        return Status.owner;
        break;
      
      default:
      return Status.disable;
    }
  }

  fixId(val){
    if (val is String) {
      return int.parse(val);
    }else{
      return val;
    }
  }

    return Park(
      ownerId: fixId(json['ownerId']),
      location: json['location'], 
      //imageUrls: json['imageUrls'] as List<Uint8List>, 
      isClosedPark: json['isClosedPark'], 
      longitude: json['longtitude'], 
      latitude: json['latitude'], 
      name: json['name'], 
      price: json['price'], 
      status: _organizeStatus(json['status']), 
      isWithElectricity: json['isWithElectricity'], 
      id: fixId(json['parkId']), 
      point: json['point'], 
      isWithCam: json['isWithCam'], 
      isWithSecurity: json['isWithSecurity'], 
      parkSpace: json['parkSpace'], 
      filledParkSpace: json['filledParkSpace'],
      
      );
  }

  
}


