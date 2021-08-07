import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gesk_app/views/giris/MapScreen.dart';




class Wrapper extends StatelessWidget {

  Wrapper({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var auth = true;
    if (auth) {
      return MapScreen();
    }else{
      return Scaffold();
    }
  }
}