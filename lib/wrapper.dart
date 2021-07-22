import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gesk_app/core/components/bottomBar.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var auth = true;
    if (auth) {
      return Scaffold(
        bottomNavigationBar: BottomBar()
      );
    }else{
      return Scaffold();
    }
  }
}