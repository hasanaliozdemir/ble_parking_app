import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gesk_app/views/diger/othersScreen.dart';
import 'package:gesk_app/views/giris/MapScreen.dart';
import 'package:gesk_app/views/giris/SplashScreen.dart';
import 'package:gesk_app/views/profil/profileScreen.dart';
import 'package:gesk_app/views/reservation/reservationsScreen.dart';
import 'package:get/get.dart';

import '../colors.dart';

// ignore: must_be_immutable
class BottomBar extends StatefulWidget {
  int _index;
  BottomBar({ Key key,@required int index }){
    this._index=index;
  }

  @override
  _BottomBarState createState() => _BottomBarState(_index);
}

class _BottomBarState extends State<BottomBar> {
  _BottomBarState(int index){
    this._index = index;
  }

  int _index;

  var screens = [
    
  ];

  
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex:  _index,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.house_fill,color: gray800,),
              activeIcon: Icon(CupertinoIcons.house_fill,color: blue500,),
              label: "Anasayfa"
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.clock,color: gray800),
              activeIcon: Icon(CupertinoIcons.clock,color: blue500),
              label: "Rezervasyon"
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.person_crop_circle,color: gray800),
              activeIcon: Icon(CupertinoIcons.person_crop_circle,color: blue500),
              label: "Profil"
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.ellipsis_circle,color: gray800),
              activeIcon: Icon(CupertinoIcons.ellipsis_circle,color: blue500),
              label: "Diğer"
            ),
          ],
          onTap: (index){
            switch (index) {
              case 0:
                Get.off(()=>SplashScreen(),fullscreenDialog: true);
                break;
              case 1:
                Get.to(()=>ReservationsScreen(),fullscreenDialog: true);
                break;
              case 2:
                Get.to(()=>ProfileScreen(),fullscreenDialog: true);
                break;
              case 3:
                Get.to(()=>OthersScreen(),fullscreenDialog: true);
                break;
              
              default:
            }
          }
        );
  }
  
}