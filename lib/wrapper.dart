import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gesk_app/core/components/bottomBar.dart';
import 'package:gesk_app/core/components/popUp.dart';
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
          child: PopUp(
            icon: "assets/icons/maps.svg" ,
            single: false,
            yesFunc: null,
            title: "Otopark Konumunun Belirlenmesi",
            content: "Otoparkınız Evpark sistemine bu adres ile kaydedilecektir. Bu adresi kaydetmek için emin misiniz ?",
          )
        ),

        bottomNavigationBar: BottomBar()
      );
    }else{
      return Scaffold();
    }
  }
}