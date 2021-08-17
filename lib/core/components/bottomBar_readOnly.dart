import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gesk_app/core/components/popUp.dart';
import 'package:gesk_app/views/auth/signUp.dart';

import 'package:get/get.dart';

import '../colors.dart';

// ignore: must_be_immutable
class BottomBarRead extends StatefulWidget {
  int _index;
  BottomBarRead({ Key key,@required int index }){
    this._index=index;
  }

  @override
  _BottomBarReadState createState() => _BottomBarReadState(_index);
}

class _BottomBarReadState extends State<BottomBarRead> {
  _BottomBarReadState(int index){
    this._index = index;
  }

  int _index;

  
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex:  _index,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.home,color: gray800,),
              activeIcon: Icon(CupertinoIcons.home,color: blue500,),
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
            showDialog(context: context, builder: (context){
          return PopUp(
            title: "Devam etmek için giriş yapmalısınız.",
            icon: "assets/icons/singin-popup-people.svg",
            content: "Otopark alanını kiralamak ve otopark bariyer sistemini aktif hale getirmek için üye olunuz.",
            single: true,
            yesFunc: (){
              Get.to(()=> SignUpScreen1());
            },
          );
        });
          }
        );
  }
}