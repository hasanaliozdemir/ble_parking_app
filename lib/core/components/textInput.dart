import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../colors.dart';

// ignore: must_be_immutable
class TextInputSimple extends StatefulWidget {
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
  TextInputSimple(
      {Key key,
      bool secure,
      @required TextEditingController controller,
      List<TextInputFormatter> inputFormatters,
      Icon prefixIcon,
      String errorText,
      @required FocusNode focusNode,
      Function func,
      TextInputAction textInputAction,
      String hintText,
      Icon suffixIcon,
      Function suffixFunc,
      TextInputType keyBoardType})
      : super(key: key) {
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
  }

  @override
  _TextInputSimpleState createState() => _TextInputSimpleState();
}

class _TextInputSimpleState extends State<TextInputSimple> {
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
    return Obx(() => Container(
          width: Get.width / 375 * 343,
          height: Get.height / 812 * 44,
          decoration: BoxDecoration(
              border: _focused.value
                  ? Border.all(color: blue500)
                  : Border.all(color: Colors.transparent),
              boxShadow: [
                BoxShadow(
                  color: Color(0x33000000),
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
              borderRadius: BorderRadius.circular(8),
              color: white),
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 4,
          ),
          child: TextFormField(
            keyboardType: widget.keyBoardType,
            inputFormatters: widget.inputFormatters,
            textInputAction: widget.textInputAction ?? TextInputAction.done,
            focusNode: widget.focusNode,
            onFieldSubmitted: (term) {
              if (widget.func != null) {
                widget.func();
              }
            },
            obscureText: widget.secure ?? false,
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
    if (widget.suffixIcon == null) {
      return null;
    } else {
      return IconButton(
        icon: widget.suffixIcon,
        onPressed: () {
          if (widget.suffixFunc != null) {
            setState(() {
              widget.suffixFunc();
            });
          }
        },
      );
    }
  }
}
