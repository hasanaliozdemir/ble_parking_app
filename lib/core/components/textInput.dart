import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../colors.dart';

// ignore: must_be_immutable
class TextInputSimple extends StatelessWidget {
  TextInputAction textInputAction;
  Function func;
  var _focused = false.obs;
  FocusNode focusNode;
  String errorText;
  TextEditingController controller;
  Icon prefixIcon;
  TextInputSimple({Key key, @required TextEditingController controller,Icon prefixIcon,String errorText,FocusNode focusNode,Function func,TextInputAction textInputAction}) : super(key: key){
    this.controller = controller;
    this.prefixIcon = prefixIcon;
    this.errorText = errorText;
    this.focusNode = focusNode;
    this.func = func;
    this.textInputAction = textInputAction;

  }

  @override
  Widget build(BuildContext context) {
    return Obx(()=>
    Container(
      width: Get.width/375*343,
      height:  Get.height/812*44,
      decoration: BoxDecoration(
        border: _focused.value ?  Border.all(color: blue500) : Border.all(color: Colors.transparent),
        boxShadow: [
            BoxShadow(
                color: Color(0x33000000),
                blurRadius: 10,
                offset: Offset(0, 4),
            ),],
            borderRadius: BorderRadius.circular(8),
            color: white
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4, ),
      child: TextFormField(
        textInputAction: textInputAction ?? TextInputAction.done,
        focusNode: focusNode,
        onTap: (){
          _focused.value = true;
        },
        onFieldSubmitted: (term){
          focusNode.unfocus();
          _focused.value = false;
          if (func!=null) {
            func();
          }
        },
        controller: controller,
        decoration: InputDecoration(
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          focusColor: blue500,
          prefixIcon: prefixIcon,
          suffixIcon: IconButton(
            icon: Icon(CupertinoIcons.multiply_circle_fill),
            onPressed: (){
              controller.clear();
            },
          ),
          errorText: errorText
        ),
      ),
    )
    );
  }
}