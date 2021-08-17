import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gesk_app/bloc/app_bloc.dart';
import 'package:gesk_app/data_models/geometry.dart';
import 'package:gesk_app/data_models/location.dart';
import 'package:gesk_app/data_models/place.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LiveLocationPage extends StatefulWidget {
  final bool searched;
  const LiveLocationPage({Key key, this.searched}) : super(key: key);

  @override
  _LiveLocationPageState createState() => _LiveLocationPageState(searched);
}

class _LiveLocationPageState extends State<LiveLocationPage> {
  final bool searched;
  Location place;
  CameraPosition cameraPosition;

  Completer<GoogleMapController> _mapController =
      Completer<GoogleMapController>();

  _LiveLocationPageState(this.searched);
  @override
  void initState() {
    final applicationBloc = Provider.of<AppBloc>(context, listen: false);

    super.initState();
  }

  @override
  void dispose() {
    final applicationBloc = Provider.of<AppBloc>(context, listen: false);

    applicationBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final applicationBloc = Provider.of<AppBloc>(context, listen: false);

    if (searched == false) {
      cameraPosition = CameraPosition(
          target: LatLng(applicationBloc.currentLocation.latitude,
              applicationBloc.currentLocation.longitude),
          zoom: 16);
    } else {
      cameraPosition = CameraPosition(
          target: LatLng(applicationBloc.currentLocation.latitude,
              applicationBloc.currentLocation.longitude),
          zoom: 16);
      _getPlace();
    }

    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: cameraPosition,
        onMapCreated: (GoogleMapController controller) {
          _mapController.complete(controller);
        },
      ),
    );
  }

  _getPlace() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final GoogleMapController _controller = await _mapController.future;

    var _lat = prefs.getDouble("lastPlaceLat");
    var _lng = prefs.getDouble("lastPlaceLng");
    setState(() {
      place = Location(lat: _lat, lng: _lng);
    });
    _controller.moveCamera(CameraUpdate.newLatLng(LatLng(_lat, _lng)));
  }
}
