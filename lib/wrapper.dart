import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gesk_app/core/components/bottomBar.dart';
import 'package:gesk_app/core/components/customSwitch.dart';
import 'package:get/get.dart';



class Wrapper extends StatelessWidget {
  var value = false.obs;
  Wrapper({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var auth = true;
    if (auth) {
      return Scaffold(
        body: Center(
          child: CustomSwitch(
            activeIcon: Icon(Icons.ac_unit_outlined),
            func: ()=>print("hello"),
            value: value,
          )
        ),

        bottomNavigationBar: BottomBar()
      );
    }else{
      return Scaffold();
    }
  }
}