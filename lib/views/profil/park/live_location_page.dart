import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gesk_app/bloc/app_bloc.dart';
import 'package:gesk_app/data_models/user_location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class LiveLocationPage extends StatefulWidget {
  const LiveLocationPage({ Key key }) : super(key: key);

  @override
  _LiveLocationPageState createState() => _LiveLocationPageState();
}

class _LiveLocationPageState extends State<LiveLocationPage> {

  StreamSubscription locationSubscription;
  CameraPosition cameraPosition;
  @override
  void initState() { 
    
    final applicationBloc = Provider.of<AppBloc>(context,listen: false);
    
    locationSubscription =  applicationBloc.selectedLocation.stream.listen((place) {
      if (place != null) {
        cameraPosition = CameraPosition(
          target: LatLng(place.geometry.location.lat,place.geometry.location.lng),
          zoom: 17
        );
      }else{
        cameraPosition = CameraPosition(
          target: LatLng(applicationBloc.currentLocation.latitude,applicationBloc.currentLocation.longitude),
          zoom: 17
        );
      }
    });
    super.initState();
  }

  @override
  void dispose() { 
    final applicationBloc = Provider.of<AppBloc>(context,listen: false);

    applicationBloc.dispose();
    locationSubscription.cancel();

    
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    

    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: cameraPosition,
      ),
    );
  }
}