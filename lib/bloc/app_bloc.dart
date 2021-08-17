import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:gesk_app/data_models/place.dart';
import 'package:gesk_app/data_models/place_search.dart';
import 'package:gesk_app/services/geolocator_service.dart';
import 'package:gesk_app/services/place_service.dart';

class AppBloc with ChangeNotifier{
  final placesService = PlaceServices();
  final geolocatorServices = GeolocatorService();


  // variables
  Position currentLocation;
  List<PlaceSearch> searchResults;
  StreamController<Place> selectedLocation = StreamController<Place>();

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
    selectedLocation.add(await placesService.getPlace(placeId));
    searchResults = null;
    notifyListeners();
  }

  clearSearch() async{
    searchResults = null;
    notifyListeners();
  }

  @override
  void dispose() { 
    selectedLocation.close();
    super.dispose();
  }
}