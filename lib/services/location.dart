import 'dart:async';

import 'package:gesk_app/data_models/user_location.dart';
import 'package:location/location.dart';

class LocationService {
  UserLocation _currentLocation;

  Location location = Location();

  // continiously get location
  // ignore: close_sinks
  StreamController<UserLocation> _locationController = 
      StreamController<UserLocation>.broadcast();

  LocationService(){
    location.requestPermission().then((PermissionStatus status) {
      if (status==PermissionStatus.granted) {
        location.onLocationChanged.listen((locationData){
          if (locationData !=null) {
            _locationController.add(UserLocation(latitude: locationData.latitude,longitude: locationData.longitude));
          }
        });
      } else {
      }
    });
  }

  Stream<UserLocation> get locationStream => _locationController.stream;


  // get user location function
  Future<UserLocation> getLocation() async{
    try {
      var userLocation = await location.getLocation();
      _currentLocation = UserLocation(
        latitude: userLocation.latitude,
        longitude: userLocation.longitude
      );
    } catch (e) {
      print("Could not get the location");
      print(e.toString());
    }

    return _currentLocation;
  }
}

