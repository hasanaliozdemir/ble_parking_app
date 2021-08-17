import 'package:gesk_app/data_models/location.dart';

class Geometry{
  final Location location;

  Geometry({this.location});

  factory Geometry.fromJason(Map<String,dynamic> parsedJson){
    return Geometry(
      location: Location.fromJson(parsedJson['location'])
    );
  }
}