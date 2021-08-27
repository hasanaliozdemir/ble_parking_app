import 'package:flutter/material.dart';

class Car {
  String plaka;
  String renk;
  int model;
  String size;

  int id;
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
}
