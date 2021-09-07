import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:gesk_app/core/colors.dart';
import 'package:gesk_app/core/components/bottomBar.dart';
import 'package:gesk_app/core/components/button.dart';
import 'package:gesk_app/models/park.dart';
import 'package:gesk_app/models/reservation.dart';
import 'package:gesk_app/views/reservation/reservationsScreen.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class ReservationDetail extends StatefulWidget {
  ReservationDetail({Key key}) : super(key: key);

  @override
  _ReservationDetailState createState() => _ReservationDetailState();
}

class _ReservationDetailState extends State<ReservationDetail> {
  var _near = false.obs;
  Park _park;
  Reservation _reservation;
  

  @override
  void initState() {
    super.initState();
    _readyPark();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: BottomBar(
        index: 1,
      ),
      body: _buildBody()
    );
  }

  Widget _buildBody(){
    if (_park == null) {
      return CircularProgressIndicator.adaptive();
    }else{
      return Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).padding.top,
          ),
          Expanded(
            child: Column(
              children: [
                Expanded(
                  flex: 44,
                  child: _buildBackButton(),
                ),
                Spacer(
                  flex: 16,
                ),
                Expanded(
                  flex: 30,
                  child: _buildTitle(),
                ),
                Spacer(
                  flex: 8,
                ),
                Expanded(
                  flex: 533 + 48,
                  child: _buildList(),
                )
              ],
            ),
          )
        ],
      );
    }
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

  Widget _buildTitle() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          "Erenköy 2 Otopark", //TODO: get park name from api
          style: TextStyle(
              fontFamily: "SF Pro Display",
              fontSize: 22,
              fontWeight: FontWeight.w600,
              color: blue500),
        ),
      ),
    );
  }

  Widget _buildList() {
    return ListView(
      children: [
        _buildReservation(),
        _space(),
        _buildGallery(),
        _space(),
        _buildTitle2(),
        _buildListTile1(),
        _buildListTile2(),
        _buildListTile3(),
        _buildListTile4(),
        _space(),
        _buildButtonGoPark(),
        _space(),
        _buildButtonOpenBarrier(),
        _space(),
        _space(),
        _buildDeleteText(),
        _space()
      ],
    );
  }

  Widget _space() {
    return SizedBox(
      height: Get.height / 926 * 24,
    );
  }

  Widget _buildReservation() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        height: Get.height / 812 * 56,
        width: Get.width / 375 * 343,
        decoration: BoxDecoration(
            border: Border.all(color: gray600),
            borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  Widget _buildGallery() {
    if (_park == null) {
      return CircularProgressIndicator.adaptive();
    } else {
      return Container(
        height: Get.height / 812 * 155,
        child: CarouselSlider.builder(
            itemCount: (_park == null) ? 0 : _park.imageUrls.length,
            itemBuilder: (context, itemIndex, pageIndex) {
              return Container(
                margin: EdgeInsets.only(
                  right: 32,
                ),
                width: Get.width / 375 * 240,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        image: NetworkImage(_park.imageUrls[itemIndex]),
                        fit: BoxFit.cover)),
              );
            },
            options: CarouselOptions(
              pageSnapping: true,
              disableCenter: true,
              enableInfiniteScroll: false,
            )),
      );
    }
  }

  Widget _buildTitle2(){
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: gray600
          )
        )
      ),
      height: Get.height/812*48,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Otopark Özellikleri",
            style: TextStyle(
              fontFamily: "SF Pro Text",
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: black
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildListTile1() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: Container(
          width: Get.width / 375 * 36,
          height: Get.width / 375 * 36,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                  width: 2, color: _park.isClosedPark ? blue500 : gray800)),
          child: _park.isClosedPark
                      ? Icon(
                          CupertinoIcons.square_grid_3x2_fill,
                          color: blue500,
                        )
                      : Icon(
                          CupertinoIcons.square_grid_3x2_fill,
                          color: gray700,
                        ),
        ),
        title: Text(
          "Kapalı Otopark",
          style: TextStyle(
            color: _park.isClosedPark ? black : gray700,
            fontSize: 17,
          ),
        ),
        trailing: _park.isClosedPark
            ? Icon(
                CupertinoIcons.check_mark_circled_solid,
                color: blue500,
              )
            : Icon(
                CupertinoIcons.check_mark_circled_solid,
                color: gray800,
              ),
      ),
    );
  }

  Widget _buildListTile2() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: Container(
          width: Get.width / 375 * 36,
          height: Get.width / 375 * 36,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                  width: 2, color: _park.isWithCam ? blue500 : gray800)),
          child: _park.isWithCam
                      ? Icon(
                          CupertinoIcons.video_camera_solid,
                          color: blue500,
                        )
                      : Icon(
                          CupertinoIcons.video_camera_solid,
                          color: gray700,
                        ),
        ),
        title: Text(
          "Güvenlik Kamerası",
          style: TextStyle(
            color: _park.isWithCam ? black : gray700,
            fontSize: 17,
          ),
        ),
        trailing: _park.isWithCam
            ? Icon(
                CupertinoIcons.check_mark_circled_solid,
                color: blue500,
              )
            : Icon(
                CupertinoIcons.check_mark_circled_solid,
                color: gray800,
              ),
      ),
    );
  }


  Widget _buildListTile3() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: Container(
          width: Get.width / 375 * 36,
          height: Get.width / 375 * 36,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                  width: 2, color: _park.isWithElectricity ? blue500 : gray800)),
          child: _park.isWithElectricity
                      ? Icon(
                          CupertinoIcons.bolt_fill,
                          color: blue500,
                        )
                      : Icon(
                          CupertinoIcons.bolt_fill,
                          color: gray700,
                        ),
        ),
        title: Text(
          "Elektrikli Şarj İstasyonu",
          style: TextStyle(
            color: _park.isWithElectricity ? black : gray700,
            fontSize: 17,
          ),
        ),
        trailing: _park.isWithElectricity
            ? Icon(
                CupertinoIcons.check_mark_circled_solid,
                color: blue500,
              )
            : Icon(
                CupertinoIcons.check_mark_circled_solid,
                color: gray800,
              ),
      ),
    );
  }

  Widget _buildListTile4() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: Container(
          width: Get.width / 375 * 36,
          height: Get.width / 375 * 36,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                  width: 2, color: _park.isWithSecurity ? blue500 : gray800)),
          child: _park.isWithSecurity
                      ? Icon(
                          CupertinoIcons.shield_lefthalf_fill,
                          color: blue500,
                        )
                      : Icon(
                          CupertinoIcons.shield_lefthalf_fill,
                          color: gray700,
                        ),
        ),
        title: Text(
          "Güvenlik Personeli",
          style: TextStyle(
            color: _park.isWithSecurity ? black : gray700,
            fontSize: 17,
          ),
        ),
        trailing: _park.isWithSecurity
            ? Icon(
                CupertinoIcons.check_mark_circled_solid,
                color: blue500,
              )
            : Icon(
                CupertinoIcons.check_mark_circled_solid,
                color: gray800,
              ),
      ),
    );
  }

  Widget _buildButtonGoPark(){
    return Button.active(text: "Otoparka Git", onPressed: (){
      print("go park");
    });
  }

  Widget _buildButtonOpenBarrier(){
    return Obx((){
      if (_near.value == true) {
      return Button.active(text: "Bariyeri Aç", onPressed: _openBarrier);
    } else {
      return Button.backHover(text: "Bariyeri Aç", onPressed: null);
    }
    });
  }

  Widget _buildDeleteText(){
    return Padding(
      padding:  EdgeInsets.only(left: Get.width/375* 50.0),
      child: InkWell(
        onTap: _deleteReservation,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Bu rezervasyonu kalıcı olarak",
              style: TextStyle(
                fontFamily: "SF Pro Text",
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: gray900
              ),
              ),
              Text(
                " silmek ",
                style: TextStyle(
                  fontFamily: "SF Pro Text",
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: gray900
                ),
              ),
              Text(
                "istiyorum.",
                style: TextStyle(
                  fontFamily: "SF Pro Text",
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: gray900
                ),
              )
          ],
        ),
      ),
    );
  }

  _backButtonFunc() {
    Get.to(() => ReservationsScreen(), fullscreenDialog: true);
  }

  _readyPark() async {
    
    setState(() {});
  }

  _openBarrier(){
    print("bariyeri aç bakam");
  }

  _deleteReservation(){
    print( "delete");
  }
}
