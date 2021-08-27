import 'package:flutter/material.dart';
import 'package:gesk_app/core/colors.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class Button extends StatelessWidget {
  Color textColor;
  Color color;
  String text;
  VoidCallback onPressed;

  Button.active({@required String text, @required VoidCallback onPressed}) {
    this.text = text;
    this.color = blue500;
    this.textColor = white;
    this.onPressed = onPressed;
  }

  Button.passive({@required String text, @required VoidCallback onPressed}) {
    this.text = text;
    this.color = gray400;
    this.textColor = gray800;
    this.onPressed = onPressed;
  }

  Button.backHover({@required String text, @required VoidCallback onPressed}) {
    this.text = text;
    this.color = blue300;
    this.textColor = white;
    this.onPressed = onPressed;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
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
          child:Center(
            child: Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: textColor,
                  fontSize: 17,
                  fontFamily: "SF Pro Text",
                  fontWeight: FontWeight.w600,
                ),
              ),
          ),
        ));
  }
}
