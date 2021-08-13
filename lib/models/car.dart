import 'package:flutter/material.dart';

class Car {
  String plaka;
  String renk;
  int model;

  int id;
  String userID;

  Car.withoutID({
    @required this.plaka, 
    @required this.renk, 
    @required this.model});
  Car({
    @required this.plaka, 
    @required this.renk, 
    @required this.model, 
    @required this.id, 
    @required this.userID});
}
