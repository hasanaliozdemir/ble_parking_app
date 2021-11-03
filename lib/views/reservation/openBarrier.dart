import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gesk_app/ble/bleService.dart';
import 'package:gesk_app/core/colors.dart';
import 'package:gesk_app/core/components/BtPopUp.dart';
import 'package:gesk_app/core/components/bottomBar.dart';
import 'package:gesk_app/core/components/button.dart';
import 'package:gesk_app/core/components/popUp.dart';
import 'package:gesk_app/models/reservation.dart';

import 'package:gesk_app/views/reservation/reviewScreen.dart';
import 'package:get/get.dart';

class OpenBarrierPage extends StatefulWidget {
  final DateTime end;
  final Reservation reservation;
  const OpenBarrierPage({Key key, this.end, this.reservation})
      : super(key: key);

  @override
  _OpenBarrierPageState createState() =>
      _OpenBarrierPageState(end, reservation);
}

class _OpenBarrierPageState extends State<OpenBarrierPage> {

  BleService _bleService = BleService();
  final DateTime _end;
  final Reservation _reservation;
  Timer _coundownTimer;

  bool _first = true;
  bool _opened = false;
  bool _finished = false;

  int pin1 = 0;
  int pin2 = 0;
  int pin3 = 0;
  int pin4 = 0;

  _OpenBarrierPageState(this._end, this._reservation);
  @override
  void initState() {
    super.initState();
    _setPins();
    _coundownTimer = Timer.periodic(Duration(minutes: 1), (timer) => _setPins);
  }

  @override
  void dispose() {
    _coundownTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: (_opened == true) ? _secondColumn() : _firstColumn(),
      ),
      bottomNavigationBar: BottomBar(index: 1),
    );
  }

  Column _secondColumn() {
    return Column(
      children: [
        Expanded(
          flex: 44,
          child: _buildBackButton(),
        ),
        Spacer(
          flex: 30,
        ),
        Expanded(
          flex: 170,
          child: Container(
            child: Stack(
              children: [
                Center(
                    child: SvgPicture.asset(
                  "assets/images/Vector.svg",
                  fit: BoxFit.cover,
                )),
                Center(
                  child: Container(
                      padding: EdgeInsets.all(Get.height / 812 * 50),
                      child: SvgPicture.asset("assets/logos/White.svg")),
                ),
              ],
            ),
          ),
        ),
        Spacer(
          flex: 59,
        ),
        _buildTitle(),
        _buildDescribtion(),
        Spacer(
          flex: 48,
        ),
        Expanded(
          flex: 64,
          child: _buildCountdown(),
        ),
        Spacer(
          flex: 48,
        ),
        _buildOpenBarrier(),
        Spacer(
          flex: 16,
        ),
        _buildFinishPark(),
        Spacer(
          flex: 19,
        )
      ],
    );
  }

  _buildFinishPark() {
    return Expanded(
        flex: 56,
        child: Button.backHover(text: "Parkı Bitir", onPressed: _finishPark));
  }

  _buildCountdown() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _pinContainer(pin1),
          _pinContainer(pin2),
          Container(
            child: Text(
              ":",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
          _pinContainer(pin3),
          _pinContainer(pin4),
        ],
      ),
    );
  }

  Widget _pinContainer(int pinCode) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        width: Get.width / 375 * 48,
        height: Get.height / 812 * 64,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            border: Border.all(width: 2, color: gray500)),
        child: Center(
          child: Text(
            pinCode.toString(),
            style: TextStyle(
                fontSize: 22,
                color: _finished ? gray500 : black,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Expanded _buildDescribtion() {
    return Expanded(
      flex: 44,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Text(
          "Aracınızı belirlediğiniz tekil park alanına park etmek için bariyeri aktif hale getiriniz.",
          style: TextStyle(color: black, fontSize: 17),
        ),
      ),
    );
  }

  Column _firstColumn() {
    return Column(
      children: [
        Expanded(
          flex: 44,
          child: _buildBackButton(),
        ),
        Spacer(
          flex: 30,
        ),
        Expanded(
          flex: 170,
          child: Container(
            child: Stack(
              children: [
                Center(
                    child: SvgPicture.asset(
                  "assets/images/Vector.svg",
                  fit: BoxFit.cover,
                )),
                Center(
                  child: Container(
                      padding: EdgeInsets.all(Get.height / 812 * 50),
                      child: SvgPicture.asset("assets/logos/White.svg")),
                ),
              ],
            ),
          ),
        ),
        Spacer(
          flex: 59,
        ),
        _buildTitle(),
        _buildDescribtion(),
        Spacer(
          flex: 36,
        ),
        _buildOpenBarrier(),
        Spacer(
          flex: 215,
        )
      ],
    );
  }

  Expanded _buildOpenBarrier() {
    return Expanded(
      flex: 56,
      child: Button.active(text: "Bariyeri Aç", onPressed: _openBarrier),
    );
  }

  Expanded _buildTitle() {
    return Expanded(
      flex: 30,
      child: Text(
        "Evpark Bariyer Sistemi",
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 17,
            fontFamily: "SF Pro Text",
            fontWeight: FontWeight.w600,
            color: blue500),
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

  _setPins() {
    if (DateTime.now().isBefore(_end)) {
      var _difference = _end.difference(DateTime.now()).inMinutes;
    print(_difference);
    var _minute = _difference % 60;
    var _hour = _difference ~/ 60;

    if (_minute < 10) {
      pin3 = 0;
      pin4 = _minute;
    } else {
      pin3 = _minute ~/ 10;
      pin4 = _minute % 10;
    }

    if (_hour < 10) {
      pin1 = 0;
      pin2 = _hour;
    } else {
      pin1 = _hour ~/ 10;
      pin2 = _hour % 10;
    }
    } else {
      pin1 =0;
      pin2 = 0;
      pin3 = 0;
      pin4=0;
    }
    setState(() {
      if (pin1==0 && pin2==0 && pin3==0 && pin4==0) {
        _finished = true;
      }
    });
  }

  _backButtonFunc() {
    Get.back();
  }

  _openBarrier(){
    _bleService.startScan();
  }

  _finishPark() {
    showDialog(
        context: context,
        builder: (context) {
          return PopUp(
              title: "Park Sonlandırılacak",
              content:
                  "Park sonlandırıldıktan sonra bariyer açılamaz. Parkı sonlandırmak istediğinize emin misiniz?",
              yesFunc: _yesFunc,
              realIcon: Icon(
                CupertinoIcons.drop_triangle,
                size: 60,
                color: blue500,
              ),
              noFunc: () {
                Navigator.pop(context);
              },
              single: false);
        });
  }

  _yesFunc() {
    print("park bitti");
    Get.to(() => ReviewScreen());
  }
}
