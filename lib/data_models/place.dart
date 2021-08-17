import 'package:gesk_app/data_models/geometry.dart';

class Place{
  final Geometry geometry;
  final String name;
  final String vicinity;

  Place({this.geometry, this.name, this.vicinity});

  factory Place.fromJson(Map<String,dynamic> parsedJson){
    return Place(
      geometry: Geometry.fromJason(parsedJson['geometry']),
      name: parsedJson['formatted_address'],
      vicinity: parsedJson['vicinity']
    );
  }

}