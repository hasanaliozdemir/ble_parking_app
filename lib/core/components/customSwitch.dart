import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:gesk_app/core/colors.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class CustomSwitch extends StatelessWidget {
  VoidCallback func;
  Color activeToggleColor;
  Color passiveToggleColor;
  RxBool sw;
  Icon activeIcon;
  Icon passiveIcon;

  CustomSwitch({
  Key key, @required value,
  VoidCallback func,
  Color activeToggleColor,
  Color passiveToggleColor,
  Icon activeIcon,
  Icon passiveIcon
  }) : super(key: key) {
    this.sw = value;
    this.func = func;
    this.activeToggleColor = activeToggleColor;
    this.passiveToggleColor = passiveToggleColor;
    this.activeIcon = activeIcon;
    this.passiveIcon=passiveIcon;
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => FlutterSwitch(
        width: Get.width/375* 51,
        height: Get.height/812*31,
        value: sw.value,
        onToggle: (val) {
          sw.value = val;
          // ignore: unnecessary_statements
          func();
        },
        switchBorder: Border.all(color: gray400),
        
        inactiveColor: white,
        activeIcon: activeIcon,
        inactiveIcon: passiveIcon,
        activeColor: blue500,
        activeToggleColor: activeToggleColor,
        inactiveToggleColor: passiveToggleColor,
        ));
  }
}
