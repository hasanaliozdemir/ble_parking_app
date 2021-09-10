import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gesk_app/core/colors.dart';

class Widgets{
  showAlert(BuildContext context,String text){
    showBottomSheet(context: context, builder: (context){
      return Container(
        decoration: BoxDecoration(
          color: yellow100,
        ),
        child: Row(
          children: [
            Icon(CupertinoIcons.info_circle_fill),
            Text(
              text
            )
          ],
        ),
      );
    });
  }
}