import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gesk_app/core/colors.dart';
import 'package:gesk_app/core/components/button.dart';
import 'package:gesk_app/core/components/customSwitch.dart';
import 'package:gesk_app/data_models/address.dart';
import 'package:gesk_app/data_models/place.dart';
import 'package:gesk_app/models/park.dart';
import 'package:gesk_app/models/tpa.dart';
import 'package:gesk_app/services/addressService.dart';
import 'package:gesk_app/views/profil/profileScreen.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ParkPage extends StatefulWidget {
  final Park park;

  const ParkPage({Key key, this.park}) : super(key: key);

  @override
  _ParkPageState createState() => _ParkPageState(park);
}

class _ParkPageState extends State<ParkPage> {
  final Park park;
  Address parkAddress;
  String formattedAddress;

  List<Tpa> tpaList = [
    Tpa(
        avaliable: true.obs,
        tapId: 0,
        tpaName: "A-126",
        hourlyPrice: 18,
        isWithElectricity: true),
    Tpa(
        avaliable: true.obs,
        tapId: 0,
        tpaName: "A-127",
        hourlyPrice: 18,
        isWithElectricity: true),
    Tpa(
        avaliable: true.obs,
        tapId: 1,
        tpaName: "A-128",
        hourlyPrice: 18,
        isWithElectricity: true)
  ];

  @override
  void initState() {
    _getAddress();
    super.initState();
  }

  _ParkPageState(this.park);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _layerOne(context),
          _layerTwo(context)
        ],
      ),
    );
  }

  Padding _layerOne(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).padding.top,
          ),
          Expanded(
            flex: 44,
            child: _buildBackButton(),
          ),
          Spacer(
            flex: 24,
          ),
          Expanded(
            flex: 166,
            child: _titleCard(),
          ),
          Spacer(
            flex: 32,
          ),
          Expanded(
            flex: 44,
            child: _buildFormattedAddress(),
          ),
          Spacer(
            flex: 32,
          ),
          Expanded(
            flex:  60,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: gray600),
                  borderRadius: BorderRadius.circular(8)
                ),
              ),
            ),
          ),
          Spacer(
            flex: 190,
          ),
          Expanded(
            flex: 56,
            child: Button.backHover(text: "Otoparkı Düzenle", onPressed: _onTapButton),
          ),
          Spacer(
            flex: 24,
          ),
          Expanded(
            flex: 18,
            child: InkWell(
              onTap: _deletePark,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Bu otoparkı kalıcı olarak",
              style: TextStyle(
                fontFamily: "SF Pro Text",
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: gray900
              ),
              ),
              Text(" silmek ",
              style: TextStyle(
                fontFamily: "SF Pro Text",
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: gray900
              ),
              ),
              Text("istiyorum.",
              style: TextStyle(
                fontFamily: "SF Pro Text",
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: gray900
              ),
              ),
                ],
              ),
            )
          ),
          Spacer(
            flex: 40,
          ),
          SizedBox(
            height: MediaQuery.of(context).padding.bottom,
          ),
        ],
      ),
    );
  }

  Widget _layerTwo(BuildContext context){
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).padding.top,
          ),
          SizedBox(
            height: Get.height/812*350,
          ),
          Container(
            child: _buildTpaList(),
          )
        ],
      ),
    );
  }


  Padding _titleCard() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: Get.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8), color: gray400),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: Get.width / 375 * 96,
                height: Get.width / 375 * 96,
                decoration: BoxDecoration(
                    color: blue500, borderRadius: BorderRadius.circular(8)),
                child: Padding(
                    padding: EdgeInsets.all(24),
                    child: SvgPicture.asset(
                      "assets/icons/park_icon.svg",
                      color: white,
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                park.name,
                style: TextStyle(
                    fontFamily: "SF Pro Display",
                    fontSize: 22,
                    fontWeight: FontWeight.w600),
              ),
            )
          ],
        ),
      ),
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

  Widget _buildFormattedAddress() {
    return formattedAddress == null
        ? SizedBox()
        : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: gray600),
                  borderRadius: BorderRadius.circular(8)),
              child: ListTile(
                leading: Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: SvgPicture.asset(
                    "assets/icons/adressPin.svg",
                    color: blue500,
                  ),
                ),
                title: Container(
                  padding: EdgeInsets.only(bottom: 8),
                  child: Text(
                    formattedAddress,
                    style: TextStyle(
                        color: gray900,
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        fontFamily: "SF Pro Text"),
                  ),
                ),
              ),
            ),
          );
  }

  Widget _buildTpaList() {
    return Theme(
      data: ThemeData().copyWith(dividerColor: Colors.transparent),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: ExpansionTile(
          initiallyExpanded: true,
          title: Text(
            "Tekil Park Alanı",
            style: TextStyle(
                fontFamily: "SF Pro Text",
                fontWeight: FontWeight.w400,
                fontSize: 17,
                color: black),
          ),
          leading: SvgPicture.asset("assets/icons/carCircle.svg"),
          trailing: Icon(
            CupertinoIcons.chevron_down,
            color: blue500,
          ),
          children: [
            Container(
              height: Get.height / 812 * 165,
              child: Column(
                children: [
                  Container(
                    height: Get.height / 812 * 115,
                    child: MediaQuery.removePadding(
                      context: context,
                      removeTop: true,
                      removeBottom: true,
                      child: ListView.separated(
                          shrinkWrap: true,
                          separatorBuilder: (context, i) {
                            return Container(
                              height: Get.height / 812 * 1,
                              width: Get.width / 375 * 343,
                              color: gray400,
                            );
                          },
                          itemBuilder: (context, index) {
                            return ListTile(
                              leading: SvgPicture.asset(
                                  "assets/icons/park_icon.svg"),
                              title: Text(
                                tpaList[index].tpaName,
                                style: TextStyle(
                                    fontFamily: "SF Pro Text",
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400),
                              ),
                              trailing: Container(
                                width: Get.width / 375 * 50,
                                child: CustomSwitch(
                                  value: tpaList[index].avaliable,
                                  activeIcon: Icon(
                                    CupertinoIcons.lock_open,
                                    color: blue500,
                                  ),
                                  passiveIcon: Icon(
                                    CupertinoIcons.lock,
                                    color: blue500,
                                  ),
                                  func: () {
                                    print(
                                        "switch: $index : ${tpaList[index].avaliable}");
                                  },
                                ),
                              ),
                            );
                          },
                          itemCount: tpaList.length),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: blue500,
                        borderRadius:
                            BorderRadius.vertical(bottom: Radius.circular(8))),
                    child: ListTile(
                      title: Text(
                        "Tekil Park Alanı Ekle",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 17,
                            fontFamily: "SF Pro Text",
                            color: white),
                      ),
                      leading: Icon(
                        CupertinoIcons.add_circled,
                        color: white,
                      ),
                      trailing: Icon(
                        CupertinoIcons.chevron_right,
                        color: white,
                      ),
                      onTap: () {
                        _addTpaFunc();
                      },
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _backButtonFunc() {
    Get.to(() => ProfileScreen());
  }

  _getAddress() async {
    var _adres = await AdressService()
        .getFormatedAddress(LatLng(park.latitude, park.longitude));

    formattedAddress = _adres.formattedAddress;

    setState(() {});
  }

  _addTpaFunc() {
    print("tpa ekle");
  }

  _onTapButton(){
    print("düzenle");
  }

  _deletePark(){
    print("sil");
  }
}
