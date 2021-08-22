import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gesk_app/core/colors.dart';
import 'package:gesk_app/core/components/butonMini.dart';
import 'package:gesk_app/core/components/button.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class PopUp extends StatelessWidget {
  var _icon;
  Function _yesFunc;
  Function _noFunc;
  bool _single;
  String _title;
  String _content;
  PopUp({@required String title,@required String content,@required Function yesFunc,Function noFunc,@required bool single,@required var icon}) {
    this._title = title;
    this._content = content;
    this._yesFunc = yesFunc;
    this._noFunc=noFunc;
    this._single = single;
    this._icon = icon;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titlePadding: EdgeInsets.all(0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      title: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
        width: Get.width / 375 * 343,
        height: Get.height / 812 * 443,
        child: Column(
          children: [
            Spacer(
              flex: 24,
            ),
            Expanded(
              child: buildIcon(_icon),
              flex: 170,
            ),
            Spacer(
              flex: 34,
            ),
            Expanded(
              flex: 22,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    _title,
                    style: TextStyle(
                      color: black,
                      fontSize: 17,
                      fontFamily: "SF Pro Text",
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
            Spacer(
              flex: 8,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  _content,
                  style: TextStyle(
                    color: gray900,
                    fontSize: 17,
                  ),
                ),
              ),
              flex: 66,
            ),
            Spacer(
              flex: 30,
            ),
            Expanded(
              child: buildRow(_single),
              flex: 56,
            ),
            Spacer(
              flex: 32,
            )
          ],
        ),
      ),
    );
  }

  Widget buildRow(bool single){
    if(single){
      return Button.active(text: "Giriş Yap", onPressed: _yesFunc);
    }else{
      return Container(
        width: 
        Get.width/375 * 343,
        child: Row(
          children: [
            Expanded(child: ButtonMini.passive(text: "Hayır", onPressed: _noFunc)),
            Expanded(child: ButtonMini.active(text: "Evet", onPressed: (){
              _yesFunc();
            }),),
          ],
        ),
      );
    }
  }

  Widget buildIcon(String icon){
    return Center(
      child: Stack(
        children: [
          Center(child: Container(
            height: Get.height/812*170,
            width: Get.width/375*220,
            child: Image.asset("assets/images/Vector.png",
            fit: BoxFit.cover,),
          )
          
          ),
          Center(child: Center(child: Container(
            height: Get.height/812*116,
            width: Get.width/375*116,
            child: SvgPicture.asset(icon,
            fit: BoxFit.cover,
            color: blue600,),
          )))
        ],
      ),
    );
  }
}
