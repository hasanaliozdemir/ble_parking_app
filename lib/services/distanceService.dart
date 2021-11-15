
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class DistanceService{
  final _key = "AIzaSyCN6F8cD7cwSoJ5h8Cl5c1U7EKG_oU5XZw";

  
  Future<String> getDistance(LatLng location, LatLng target) async {
    var url = Uri.parse("https://maps.googleapis.com/maps/api/distancematrix/json?units=metric&origins=${location.latitude},${location.longitude}&destinations=${target.latitude},${target.longitude}&key=$_key");   
    
    var response = await http.get(url);
    
    var json = convert.jsonDecode(response.body);

    var jsonResult = json['rows'][0]['elements'][0]['distance']['text'];

    return jsonResult;
  }
}