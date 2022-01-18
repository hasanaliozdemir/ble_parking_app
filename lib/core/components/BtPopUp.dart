import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gesk_app/core/components/button.dart';
import 'package:get/get.dart';

import '../colors.dart';

class BtPopUp extends StatefulWidget {
  const BtPopUp({Key key}) : super(key: key);

  @override
  _BtPopUpState createState() => _BtPopUpState();
}

class _BtPopUpState extends State<BtPopUp> {
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
              child: buildIcon(),
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
                    "Bluetooth Devre dışı",
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
                  "Bariyeri açabilmek için Bluetooth özelliğini aktifleştirmeniz gerekmektedir.",
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
              child: buildRow(),
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

  Widget buildRow(){
    
      return Button.active(text: "Tamam", onPressed: (){
        Navigator.pop(context);
      });
  }

  Widget buildIcon(){
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
          _buildImage()
        ],
      ),
    );
  }

  _buildImage(){

      return Center(
        child: Center(
          child: Container(
            height: Get.height/812*116,
            width: Get.width/375*116,
            child: Icon(CupertinoIcons.bluetooth,size: 60,color: blue500,),
          ),
        ),
      );

  }
}
