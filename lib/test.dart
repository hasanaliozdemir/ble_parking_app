import 'package:flutter/material.dart';
import 'package:gesk_app/ble/bleService.dart';
import 'package:gesk_app/ble/bleStatusService.dart';
import 'package:gesk_app/core/components/button.dart';



class TestPage extends StatelessWidget {


  TestPage({ Key key }) : super(key: key);
  BleService _bleService = BleService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 100,),
          Button.active(text: "dosm", onPressed: ()=>_bleService.startScan(context)),
        ],
      ),
    );
  }
}