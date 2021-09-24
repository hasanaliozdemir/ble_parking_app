import 'package:flutter/material.dart';
import 'package:gesk_app/core/components/button.dart';
import 'package:gesk_app/services/bleService.dart';

class TestPage extends StatelessWidget {
  NewBleService newBleService = NewBleService();

  TestPage({ Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 100,),
          Button.active(text: "dosm", onPressed: ()=>newBleService.start()),
        ],
      ),
    );
  }
}