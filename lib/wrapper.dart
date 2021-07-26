import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gesk_app/core/components/bottomBar.dart';
import 'package:gesk_app/core/components/textInput.dart';
import 'package:get/get.dart';



class Wrapper extends StatelessWidget {

  FocusNode focusNode = FocusNode();
  TextEditingController controller = TextEditingController();
  Wrapper({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var auth = true;
    if (auth) {
      return Scaffold(
        body: Center(
          child: TextInputSimple(
            controller: controller,
            focusNode: focusNode,
            textInputAction: TextInputAction.emergencyCall,
          )
        ),

        bottomNavigationBar: BottomBar()
      );
    }else{
      return Scaffold();
    }
  }
}