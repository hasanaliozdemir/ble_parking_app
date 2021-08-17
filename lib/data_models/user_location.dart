import 'package:flutter/material.dart';

class UserLocation with ChangeNotifier{
  final double latitude;
  final double longitude;

  UserLocation({this.latitude, this.longitude});


  @override
  void dispose() { 
    
    super.dispose();
  }
  
}