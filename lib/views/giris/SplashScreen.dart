import 'dart:async';
import 'package:flutter_svg/svg.dart';
import 'package:gesk_app/wrapper.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  
  const SplashScreen({Key key}) : super(key: key);

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

    Timer(
      Duration(seconds: 5), 
      (){
        
        Get.to(()=>Wrapper(),fullscreenDialog: true);
      });

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
}