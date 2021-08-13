import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gesk_app/views/auth/signUp.dart';
import 'package:gesk_app/views/giris/MapScreen.dart';
import 'package:gesk_app/views/giris/MapScreen_readOnly.dart';
import 'package:gesk_app/views/giris/SplashScreen.dart';




class Wrapper extends StatelessWidget {

  Wrapper({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var auth = true;
    if (auth) {
      return MapScreen();
    }else{
      return MapScreenReadOnly();
    }
  }
}