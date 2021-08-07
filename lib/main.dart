import 'package:flutter/material.dart';
import 'package:gesk_app/data_models/user_location.dart';
import 'package:gesk_app/services/location.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

import 'wrapper.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserLocation>(
      initialData: UserLocation(latitude: 40.355,longitude:27.971 ),
      create: (context)=> LocationService().locationStream,
      child: GetMaterialApp(
        theme: ThemeData(fontFamily: 'SF Pro Text'),
        home: Wrapper(),
      ),
    );
  }
}