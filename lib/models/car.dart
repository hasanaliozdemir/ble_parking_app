import 'package:flutter/material.dart';

class Car {
  String plaka;
  String renk;
  int model;
  String size;

  String id;
  String userID;

  Car.withoutID(
      {@required this.plaka,
      @required this.renk,
      @required this.size,
      @required this.model});
  Car(
      {@required this.size,
      @required this.plaka,
      @required this.renk,
      @required this.model,
      @required this.id,
      @required this.userID});

  factory Car.fromJson(Map<String, dynamic> json) {
    int _checkInt(val) {
      if (val is int) {
        return val;
      } else {
        return int.parse(val);
      }
    }

    return Car(
        userID: json["ownerId"].toString(),
        id: json["carId"].toString(), //TODO: erenle konuş
        size: json["carSize"], //TODO: erenle konuş
        model: _checkInt(json["modelYear"]),
        renk: json["color"],
        plaka: json["plate"]);
  }
}
