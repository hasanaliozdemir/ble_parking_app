import 'package:flutter/material.dart';
import 'package:gesk_app/bloc/app_bloc.dart';
import 'package:gesk_app/views/giris/MapScreen.dart';
import 'package:gesk_app/views/giris/SplashScreen.dart';
import 'package:gesk_app/views/profil/tpa/addTpa.dart';

import 'package:get/get.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context)=> AppBloc(),
        )
      ],
      child: GetMaterialApp(
        theme: ThemeData(fontFamily: 'SF Pro Text'),
        home: SplashScreen(),
      ),
    );
  }
}
