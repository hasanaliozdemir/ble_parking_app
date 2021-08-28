import 'package:flutter/services.dart';
import 'package:gesk_app/models/park.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ParkService{

  Future<Park> getPark() async{
    
    final String response = await rootBundle.loadString('assets/json/parks.json');
    final data = await json.decode(response);

    return Park.fromJson(data[0]);
  }
}