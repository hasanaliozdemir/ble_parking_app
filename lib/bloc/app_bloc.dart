import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:gesk_app/data_models/address.dart';
import 'package:gesk_app/data_models/place.dart';
import 'package:gesk_app/data_models/place_search.dart';
import 'package:gesk_app/services/addressService.dart';
import 'package:gesk_app/services/geolocator_service.dart';
import 'package:gesk_app/services/place_service.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppBloc with ChangeNotifier{
  final placesService = PlaceServices();
  final geolocatorServices = GeolocatorService();
  final addressServices = AdressService();


  // variables
  Position currentLocation;
  List<PlaceSearch> searchResults;
  StreamController<Place> selectedLocation = StreamController<Place>.broadcast();
  StreamController<Address> selectedAddress = StreamController<Address>.broadcast();
  Place lastSelected;

  AppBloc(){
    setCurrentLocation();
  }

  setCurrentLocation() async {
    currentLocation = await geolocatorServices.getCurrentLocation();
    notifyListeners();
  }

  searchPlaces(String searchTerm) async{
    searchResults= await placesService.getAutoComplete(searchTerm);
    notifyListeners();
  }

  setSelectedLocation(String placeId) async{

    var _place = await placesService.getPlace(placeId);
    lastSelected = _place;
    selectedLocation.add(await placesService.getPlace(placeId));
    searchResults = null;
    notifyListeners();
  }

  clearSearch() async{
    searchResults = null;
    notifyListeners();
  }

  setSelectedAddress(LatLng latLng) async{
    var _loc = await addressServices.getFormatedAddress(latLng);
    selectedAddress.add(_loc);
    notifyListeners();
  }

  @override
  void dispose() { 
    selectedAddress.close();
    selectedLocation.close();
    super.dispose();
  }
}