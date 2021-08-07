import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gesk_app/core/colors.dart';
import 'package:gesk_app/core/components/button.dart';
import 'package:gesk_app/models/park.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class ParkDetail extends StatefulWidget {
  var _park;
  ParkDetail({@required Park park}) {
    this._park = park;
  }

  @override
  _ParkDetailState createState() => _ParkDetailState(_park);
}

class _ParkDetailState extends State<ParkDetail> {
  Park _park;
  _ParkDetailState(Park park) {
    this._park = park;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: Get.height / 812 * 732,
        decoration: BoxDecoration(
            color: white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10))),
        child: Column(
          children: [
            Spacer(
              flex: 8,
            ),
            Expanded(
              flex: 5,
              child: Container(
                width: 40,
                height: 5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Color(0xffaeaeb2),
                ),
              ),
            ),
            Spacer(
              flex: 16,
            ),
            Expanded(
              flex: 36,
              child: Row(
                children: [
                  Spacer(
                    flex: 56,
                  ),
                  Expanded(
                    flex: 263,
                    child: Text(
                      _park.name,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                        fontFamily: "SF Pro Text",
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Spacer(
                    flex: 8,
                  ),
                  Expanded(
                    flex: 36,
                    child: Center(
                      child: IconButton(
                        icon: Icon(
                          CupertinoIcons.multiply_circle_fill,
                          color: gray900,
                          size: 24,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),
                  Spacer(
                    flex: 8,
                  ),
                ],
              ),
            ),
            Spacer(
              flex: 16,
            ),
            Expanded(
              flex: 1,
              child: Container(
                color: gray400,
                height: Get.height / 812 * 1,
                width: Get.width,
              ),
            ),
            Spacer(
              flex: 13,
            ),
            Expanded(
              flex: 48,
              child: Row(
                children: [
                  Spacer(
                    flex: 16,
                  ),
                  Expanded(
                      flex: 22,
                      child: Icon(
                        CupertinoIcons.clock_fill,
                        color: blue200,
                      )),
                  Spacer(
                    flex: 4,
                  ),
                  Expanded(
                      flex: 155,
                      child: Text(
                        "1 Saat Ücreti",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                        ),
                      )),
                  Spacer(
                    flex: 8,
                  ),
                  Expanded(
                    flex: 155,
                    child: Text(
                      _park.price.toString() + " ₺",
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: Color(0xff007aff),
                        fontSize: 17,
                        fontFamily: "SF Pro Text",
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Spacer(
                    flex: 16,
                  )
                ],
              ),
            ),
            Spacer(
              flex: 13,
            ),
            Expanded(
              flex: 1,
              child: Container(
                color: gray400,
                height: Get.height / 812 * 1,
                width: Get.width,
              ),
            ),
            Expanded(flex: 580, child: _buildListView())
          ],
        ));
  }

  _buildListView() {
    return ListView(
      children: [
        SizedBox(
          height: Get.height / 926 * 24,
        ),
        _buildGallery(),
        SizedBox(
          height: Get.height / 812 * 24,
        ),
        _buildTitle1(),
        Container(
          color: gray400,
          height: 1,
        ),
        Container(
          child: Column(
            children: [
              _buildListTile1(),
              _buildListTile2(),
              _buildListTile3(),
              _buildListTile4()
              ],
          ),
        ),
        SizedBox(
          height: Get.height / 812 * 16,
        ),
        _buildTitle2(),
        Container(
          color: gray400,
          height: 1,
        ),
        Container(
          child: Column(
            children: [
              _buildListTile2_1(),
              _buildListTile2_2()
            ],
          ),
        ),
        SizedBox(
          height: Get.height/812*60,
        ),
        Container(
          child: Button.active(text: "Park Alanı Kirala", onPressed: _rentParkSpace),
        ),
        SizedBox(
          height: Get.height/812*16,
        ),
        Container(
          child: Button.backHover(text: "Rezervasyon Yap", onPressed: _reserveParkSpace),
        ),
        SizedBox(
          height: Get.height/812*24,
        ),
      ],
    );
  }

  _buildGallery() {
    return Container(
      height: Get.height / 812 * 155,
      child: CarouselSlider.builder(
          itemCount: _park.imageUrls.length,
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

  _buildTitle1() {
    return Container(
      width: 375,
      height: 48,
      color: Colors.white,
      padding: const EdgeInsets.only(
        top: 13,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 343,
            child: Text(
              "Otopark Özellikleri",
              style: TextStyle(
                color: Colors.black,
                fontSize: 17,
                fontFamily: "SF Pro Text",
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(height: 13),
          Container(
            width: 375,
            height: 1,
          ),
        ],
      ),
    );
  }

  _buildTitle2() {
    return Container(
      width: 375,
      height: 48,
      color: Colors.white,
      padding: const EdgeInsets.only(
        top: 13,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 343,
            child: Text(
              "Tekil Park Alanı",
              style: TextStyle(
                color: Colors.black,
                fontSize: 17,
                fontFamily: "SF Pro Text",
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(height: 13),
          Container(
            width: 375,
            height: 1,
          ),
        ],
      ),
    );
  }

  _buildListTile1() {
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

  _buildListTile2() {
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


  _buildListTile3() {
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
          "Kapalı Otopark",
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

  _buildListTile4() {
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
          "Kapalı Otopark",
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

  _buildListTile2_1() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: Container(
          width: Get.width / 375 * 36,
          height: Get.width / 375 * 36,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                  width: 2, color: blue500)),
          child: Icon(
                          CupertinoIcons.car_detailed,
                          color: blue500,
                        )
                      
        ),
        title: Text(
          "Boş Park Alanı Sayısı",
          style: TextStyle(
            color:  black,
            fontSize: 17,
          ),
        ),
        trailing: Text(
          (_park.parkSpace-_park.filledParkSpace).toString(),
          style: TextStyle(
            color: blue500,
            fontSize: 17,
            fontFamily: "SF Pro Text",
                    fontWeight: FontWeight.w600,
          ),
        )
      ),
    );
  }

  _buildListTile2_2() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: Container(
          width: Get.width / 375 * 36,
          height: Get.width / 375 * 36,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                  width: 2, color: gray700)),
          child: Icon(
                          CupertinoIcons.car_detailed,
                          color: gray700,
                        )
                      
        ),
        title: Text(
          "Dolu Park Alanı Sayısı",
          style: TextStyle(
            color:  gray800,
            fontSize: 17,
          ),
        ),
        trailing: Text(
          (_park.filledParkSpace).toString(),
          style: TextStyle(
            color: gray700,
            fontSize: 17,
            fontFamily: "SF Pro Text",
                    fontWeight: FontWeight.w600,
          ),
        )
      ),
    );
  }

  void _rentParkSpace(){

  }

  void _reserveParkSpace(){

  }
}
