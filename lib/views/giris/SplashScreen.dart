import 'dart:async';
import 'package:flutter_svg/svg.dart';
import 'package:gesk_app/wrapper.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  
  const SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  var _auth;
@override
void initState() { 
  super.initState();
  _getAuth();
}

  @override
  Widget build(BuildContext context) {
    var height = 190.obs;
    var height2 = 400.obs;

    const oneSec = const Duration(seconds:1);
    new Timer.periodic(oneSec, (Timer t) {
      if (height.value == 190) {
        height.value = 250;
        height2.value = 500;
      }else{
        height.value=190;
        height2.value=400;

      }
    } );

    _timer();

    return Scaffold(
      body: Obx(()=> Center(
        child: Stack(
            children: [
              Center(
                child: AnimatedContainer(
                  duration: Duration(seconds: 1),
                  height: height.value.toDouble(),
                  
                  child: Center(
                    child: SvgPicture.asset("assets/logos/Color.svg",fit: BoxFit.fitHeight,),
                  )
                ),
              ),
              Center(
                child: AnimatedContainer(
                  duration: Duration(seconds: 1),
                  height: height2.value.toDouble(),

                  child: Center(child: SvgPicture.asset("assets/logos/Elips.svg",fit: BoxFit.fitHeight,)),
                ),
              )
            ],
          ),
      ),
      )
    );
  }

  _getAuth()async{
    SharedPreferences _prefs = await SharedPreferences.getInstance();

    _auth = _prefs.getBool("auth");
    
    if (_auth==null) {
      _auth = false;
    }
    
  }

  _timer(){
    Timer(
      Duration(seconds: 3), 
      (){
        print("help im here");
        Get.to(()=>Wrapper(auth:_auth),fullscreenDialog: true);
      });
  }
}