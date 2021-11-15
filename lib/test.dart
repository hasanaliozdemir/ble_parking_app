import 'package:flutter/material.dart';
import 'package:gesk_app/ble/bleService.dart';
import 'package:gesk_app/ble/bleStatusService.dart';
import 'package:gesk_app/core/components/button.dart';
import 'package:gesk_app/core/components/dateSelector.dart';



class TestPage extends StatelessWidget {

  List<DateTime> days = [
    DateTime.now(),
    DateTime.now().add(Duration(days: 2)),
    DateTime.now().add(Duration(days: 250)),
    DateTime.now().add(Duration(days: 20)),
  ];
  TestPage({ Key key }) : super(key: key);
  BleService _bleService = BleService();
  @override
  Widget build(BuildContext context) {
    print(days[2]);
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 100,),
          Button.active(text: "dosm", onPressed: (){
            showModalBottomSheet(context: context, builder: (context){
                return DateSelector(days: days,);
            });
          }),
        ],
      ),
    );
  }
}