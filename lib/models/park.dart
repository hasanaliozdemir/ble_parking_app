import 'dart:convert';

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
  Status status;
  final bool isWithElectricity;
  final double point;
  final int parkSpace;
  final int filledParkSpace;
  final double longitude;
  final double latitude;
  final List imageUrls;
  final String location;
  String info;
  String distance;
  String avaliableTime;

  Park(
      {@required this.ownerId,
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
      this.distance,
      this.avaliableTime,
      this.info});

  factory Park.fromJson(Map<String, dynamic> json) {

    _organizeStatus(int stat) {
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

    fixId(val) {
      if (val is String) {
        return int.parse(val);
      } else {
        return val;
      }
    }

    fixPoint(val){
      if (val is int) {
        return val.toDouble();
      } else {
        return val;
      }
    }

    return Park(
        ownerId: fixId(json['ownerId']),
        location: json['location'],
        imageUrls: jsonDecode(json['imageUrls']) as List,
        isClosedPark: json['isClosedPark'],
        longitude: json['longtitude'],
        latitude: json['latitude'],
        name: json['name'],
        price: json['price'],
        status: _organizeStatus(1), 
        isWithElectricity: json['isWithElectricity'],
        id: fixId(json['parkId']),
        point: fixPoint(json['point']),
        isWithCam: json['isWithCam'],
        isWithSecurity: json['isWithSecurity'],
        parkSpace: json['parkSpace'],
        filledParkSpace: json['filledParkSpace'],
        info: json['parkInfo'],
        distance: "");
  }

  factory Park.fromJsonWDistance(Map<String, dynamic> json) {
    var _distance = "";

    _organizeStatus(int stat) {
      switch (stat) {
        case 0:
          return Status.admin;
          break;
        case 1:
          if (json['parkSpace'] == json['filledParkSpace']) {
            return Status.deselected;
          } else {
            return Status.deselected;
          }
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

    fixId(val) {
      if (val is String) {
        return int.parse(val);
      } else {
        return val;
      }
    }

    fixPoint(val){
      if (val is int) {
        return val.toDouble();
      } else {
        return val;
      }
    }

    return Park(
        ownerId: fixId(json['ownerId']),
        location: json['location'],
        imageUrls: jsonDecode(json['imageUrls']) as List,
        isClosedPark: json['isClosedPark'],
        longitude: json['longtitude'],
        latitude: json['latitude'],
        name: json['name'],
        price: json['price'],
        status: _organizeStatus(1), 
        isWithElectricity: json['isWithElectricity'],
        id: fixId(json['parkId']),
        point: fixPoint(json['point']),
        isWithCam: json['isWithCam'],
        isWithSecurity: json['isWithSecurity'],
        parkSpace: json['parkSpace'],
        filledParkSpace: json['filledParkSpace'],
        distance: _distance);
  }

  factory Park.fromJsonForAvaliable(Map<String, dynamic> json) {

    _organizeStatus(int stat) {
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

    fixId(val) {
      if (val is String) {
        return int.parse(val);
      } else {
        return val;
      }
    }

    fixPoint(val){
      if (val is int) {
        return val.toDouble();
      } else {
        return val;
      }
    }

    return Park(
        ownerId: fixId(json['ownerId']),
        location: json['location'],
        imageUrls: jsonDecode(json['imageUrls']) as List,
        isClosedPark: json['isClosedPark'],
        longitude: json['longtitude'],
        latitude: json['latitude'],
        name: json['name'],
        price: json['price'],
        status: _organizeStatus(1), 
        isWithElectricity: json['isWithElectricity'],
        id: fixId(json['parkId']),
        point: fixPoint(json['point']),
        isWithCam: json['isWithCam'],
        isWithSecurity: json['isWithSecurity'],
        parkSpace: json['parkSpace'],
        filledParkSpace: json['filledParkSpace'],
        avaliableTime: json['availableForUsersWithTime'],
        distance: "");
  }
}
