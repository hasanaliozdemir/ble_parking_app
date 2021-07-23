import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gesk_app/core/components/bottomBar.dart';
import 'package:gesk_app/core/components/searchBar.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController controller;
    var auth = true;
    if (auth) {
      return Scaffold(
        body: Center(
          child: SearchBar()
        ),
        bottomNavigationBar: BottomBar()
      );
    }else{
      return Scaffold();
    }
  }
}