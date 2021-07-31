import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gesk_app/views/auth/authCode.dart';
import 'package:gesk_app/views/auth/forgot_password.dart';
import 'package:gesk_app/views/auth/signUp2_.dart';
import 'package:gesk_app/views/auth/signUp_1.dart';
import 'package:gesk_app/views/diger/othersScreen.dart';
import 'package:gesk_app/views/giris/MapScreen.dart';
import 'package:gesk_app/views/profil/profileScreen.dart';



class Wrapper extends StatelessWidget {

  Wrapper({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var auth = true;
    if (auth) {
      return ProfileScreen();
    }else{
      return Scaffold();
    }
  }
}