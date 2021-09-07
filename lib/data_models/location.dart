class Location{
  double lat;
  double lng;

  Location({this.lat, this.lng});

  factory Location.fromJson(Map<String,dynamic> parsedJson){
    return Location(
      lat: parsedJson['lat'],
      lng: parsedJson['lng'],
    );
  } 
}