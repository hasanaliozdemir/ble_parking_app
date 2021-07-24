import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gesk_app/core/colors.dart';
import 'package:get/get.dart';

class ButtonIcon extends StatelessWidget {
  Color textColor;
  Color color;
  String text;
  VoidCallback onPressed;

  ButtonIcon({@required text,@required onPressed}){
    this.color = blue500;
    this.textColor = white;
    this.text= text;
    this.onPressed = onPressed;
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Container(
        width: Get.width/375* 343,
          height: Get.height/812 *56,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: color,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 17,
          ),
          child:Row(
            children: [
              Expanded(child: Icon(CupertinoIcons.paperplane_fill),flex: 2,),
              Expanded(child: Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: textColor,
                  fontSize: 17,
                  fontFamily: "SF Pro Text",
                  fontWeight: FontWeight.w600,
                ),
              ),
              flex: 13,),
              Spacer(flex: 2,)
            ], 
          ),
      ),
      
    );
  }
}
