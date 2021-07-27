import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gesk_app/core/components/bottomBar.dart';
import 'package:gesk_app/core/components/popUp.dart';
import 'package:gesk_app/core/components/textInput.dart';
import 'package:gesk_app/views/giris/SplashScreen.dart';
import 'package:get/get.dart';



class Wrapper extends StatelessWidget {

  FocusNode focusNode = FocusNode();
  TextEditingController controller = TextEditingController();
  Wrapper({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var auth = true;
    if (auth) {
      return SplashScreen();
    }else{
      return Scaffold();
    }
  }
}