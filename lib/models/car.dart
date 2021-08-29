import 'package:flutter/material.dart';

class Car {
  String plaka;
  String renk;
  int model;
  String size;

  String id;
  String userID;

  Car.withoutID({
    @required this.plaka, 
    @required this.renk,
    @required this.size, 
    @required this.model});
  Car({
    @required this.size,
    @required this.plaka, 
    @required this.renk, 
    @required this.model, 
    @required this.id, 
    @required this.userID});

    factory Car.fromJson(Map<String, dynamic> json){
      return Car(
        userID: json["ownerId"],
        id: "", //TODO: erenle konuş
        size: "Sedan", //TODO: erenle konuş
        model: int.tryParse(json["modelYear"]),
        renk: json["color"],
        plaka: json["plate"]
      );
    }
}
