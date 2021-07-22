import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../colors.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({ Key key }) : super(key: key);

  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  var screens = [
    
  ];

  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex:  _currentIndex,
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
            setState(() {
                          _currentIndex = index;
                        });
          },
        );
  }
}