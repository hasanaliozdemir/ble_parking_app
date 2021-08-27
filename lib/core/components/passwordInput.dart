import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../colors.dart';

// ignore: must_be_immutable
class PasswordInput extends StatefulWidget {
  Function onChange;
  bool readOnly;
  Function onTap;
  bool secure;
  List<TextInputFormatter> inputFormatters;
  TextInputType keyBoardType;
  TextInputAction textInputAction;
  Function func;
  FocusNode focusNode;
  String errorText;
  String hintText;
  TextEditingController controller;
  Icon prefixIcon;
  Icon suffixIcon;
  Function suffixFunc;
  PasswordInput(
      {Key key,
      Function onChange,
      bool readOnly,
      bool secure,
      @required TextEditingController controller,
      List<TextInputFormatter> inputFormatters,
      Icon prefixIcon,
      String errorText,
      @required FocusNode focusNode,
      Function onTap,
      Function func,
      TextInputAction textInputAction,
      String hintText,
      Icon suffixIcon,
      Function suffixFunc,
      TextInputType keyBoardType})
      : super(key: key) {
        this.onChange =onChange;
    this.readOnly = readOnly;
    this.controller = controller;
    this.prefixIcon = prefixIcon;
    this.errorText = errorText;
    this.focusNode = focusNode;
    this.func = func;
    this.textInputAction = textInputAction;
    this.hintText = hintText;
    this.suffixIcon = suffixIcon;
    this.suffixFunc = suffixFunc;
    this.keyBoardType = keyBoardType;
    this.inputFormatters = inputFormatters;
    this.secure = secure;
    this.onTap =onTap;
  }

  @override
  _PasswordInputState createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
  var _secure = true.obs;

  @override
  void initState() {
    super.initState();
    widget.focusNode.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    if (widget.focusNode.hasFocus) {
      _focused.value = true;
    } else {
      _focused.value = false;
    }
  }

  var _focused = false.obs;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width / 375 * 343,
      height: Get.height / 812 * 60,
      padding: EdgeInsets.only(
        
      ),
      child: Stack(
        children: [
          Obx(()=>Container(
            width: Get.width / 375 * 343,
            height: Get.height / 812 * 44,
            decoration: BoxDecoration(
            border: _focused.value
                ? Border.all(color: blue500)
                : Border.all(color: gray600),
            //boxShadow: [BoxShadow(color: Color(0x33000000),blurRadius: 10,offset: Offset(0, 4),),],
            borderRadius: BorderRadius.circular(8),
            color: white),
            padding: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 4,
        ),
          ),),
          _buildObx()
        ],
      ),
    );
  }

  Obx _buildObx() {
    return Obx(() => Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 4,
      ),
      
      
      child: TextFormField(
        onTap: (){
          if (widget.onTap != null) {
            widget.onTap();
          }
        },
        onChanged: (val){
          if(widget.onChange!=null){
            widget.onChange();
          }
        },
        keyboardType: widget.keyBoardType,
        readOnly: widget.readOnly ?? false,
        inputFormatters: widget.inputFormatters,
        textInputAction: widget.textInputAction ?? TextInputAction.done,
        focusNode: widget.focusNode,
        onFieldSubmitted: (term) {
          if (widget.func != null) {
            widget.func();
          }
        },
        obscureText: _secure.value,
        controller: widget.controller,
        decoration: InputDecoration(
            hintText: widget.hintText,
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            focusColor: blue500,
            prefixIcon: widget.prefixIcon,
            suffixIcon: _buildSuffix(),
            errorText: widget.errorText),
      ),
    ));
  }

  _buildSuffix() {
    return IconButton(
      icon: _secure.value ? Icon(CupertinoIcons.eye_slash_fill) : Icon(CupertinoIcons.eye_fill), 
      onPressed: (){
        _secure.value = !_secure.value;
      }
      );
}
}