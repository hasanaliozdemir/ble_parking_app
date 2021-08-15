import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gesk_app/core/colors.dart';
import 'package:gesk_app/core/components/buttonIcon.dart';
import 'package:gesk_app/core/components/searchBar.dart';
import 'package:gesk_app/views/profil/park/live_location_page.dart';
import 'package:gesk_app/views/profil/profileScreen.dart';
import 'package:get/get.dart';

class AddParkPage extends StatefulWidget {
  const AddParkPage({ Key key }) : super(key: key);

  @override
  _AddParkPageState createState() => _AddParkPageState();
}

class _AddParkPageState extends State<AddParkPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children:[ _buildLayerOne(context),
                  Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).padding.top,
                      ),
                      SizedBox(
                        height: Get.height/812*190,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal:16.0),
                        child: Container(
                          alignment: Alignment.center,
                          width: Get.width/375*343,
                          child: SearchBar()),
                      )
                    ],
                  )
        ]
      ),
        
    );
  }

  Column _buildLayerOne(BuildContext context) {
    return Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).padding.top,
          ),
          Spacer(
            flex: 22,
          ),
          Expanded(
            flex: 44,
            child: _buildBackButton(),
          ),
          Spacer(
            flex: 8,
          ),
          Expanded(
            flex: 41,
            child: _buildTitle(),
          ),
          Spacer(
            flex: 16,
          ),
          Expanded(
            flex: 44,
            child: _buildDescb(),
          ),
          Spacer(
            flex:92
          ),
          Expanded(
            flex: 84,
            child: _buildUseLiveLocation(),
          ),
          Spacer(
            flex: 470,
          ),
          
        ],
      );
  }

  Widget _buildBackButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        child: GestureDetector(
          onTap: () => _backButtonFunc(),
          child: Row(
            children: [
              Icon(CupertinoIcons.left_chevron, color: blue500),
              Text(
                "Geri",
                style: TextStyle(fontSize: 17, color: blue500),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitle(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:16.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          "Otopark Ekle",
          style: TextStyle(
            fontFamily: "SF Pro Display",
            fontSize: 34,
            color: blue500,
            fontWeight: FontWeight.w700
          ),
          
        ),
      ),
    );
  }

  Widget _buildDescb(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:16.0),
      child: Text("Sahip olduğunuz otopark alanını eklemek için konum bilgisini paylaşınız.",
      style: TextStyle(
        fontFamily: "SF Pro Text",
        fontWeight: FontWeight.w400,
        fontSize: 17
      ),
      ),
    );
  }

  Widget _buildUseLiveLocation(){
    return ButtonIcon(text: "Mevcut Konumu Kullan", onPressed: _onPressedLiveLocation);
  }

  void _backButtonFunc() {
    Get.to(()=>ProfileScreen());
  }

  void _onPressedLiveLocation() {
    Get.to(()=>LiveLocationPage());
  }
}