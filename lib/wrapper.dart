import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gesk_app/data_models/location.dart';
import 'package:gesk_app/models/park.dart';
import 'package:gesk_app/views/giris/MapScreen.dart';
import 'package:gesk_app/views/giris/MapScreen_readOnly.dart';





// ignore: must_be_immutable
class Wrapper extends StatelessWidget {
  bool auth;
  var _location;
  List<Park> _firstParks;
  Wrapper({Key key,bool auth,var location,List<Park> firstParks}) : super(key: key){
    this.auth = auth;
    this._location = location;
    this._firstParks=firstParks;
  }

  

  @override
  Widget build(BuildContext context) {
    
    if (auth) {
      return MapScreen(location: _location,firstParks:_firstParks);
    }else{
      return MapScreenReadOnly(location: _location,firstParks:_firstParks);
    }
  }
}