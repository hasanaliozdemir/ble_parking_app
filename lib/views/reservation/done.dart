import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gesk_app/core/colors.dart';
import 'package:gesk_app/core/components/button.dart';
import 'package:gesk_app/models/park.dart';
import 'package:gesk_app/models/reservation.dart';
import 'package:gesk_app/models/tpa.dart';
import 'package:gesk_app/views/reservation/reservation_detail.dart';
import 'package:get/get.dart';

class DoneReservationPage extends StatefulWidget {
  final Reservation reservation;
  final Tpa tpa;
  final Park park;
  final DateTime date;
  final int start;
  final int end;
  const DoneReservationPage({ Key key, this.tpa, this.park, this.date, this.start, this.end, this.reservation }) : super(key: key);

  @override
  _DoneReservationPageState createState() => _DoneReservationPageState(tpa,park,date,start,end,reservation);
}

class _DoneReservationPageState extends State<DoneReservationPage> {
  final Tpa tpa;
  final Park park;
  final DateTime date;
  final int start;
  final int end;
  final Reservation reservation;

  _DoneReservationPageState(this.tpa, this.park, this.date, this.start, this.end, this.reservation);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 44,
              child: _buildBackButton(),
            ),
            Spacer(
              flex: 72,
            ),
            Expanded(
              flex: 90,
              child: Icon(CupertinoIcons.check_mark_circled,color: blue500,size: 90,),
            ),
            Spacer(
              flex: 22,
            ),
            Expanded(
              flex: 22,
              child: Text(
                "Otopark başarı ile kiralanmıştır",
                style: TextStyle(
                  color: blue600,
                  fontSize: 17,
                  fontFamily: "SF Pro Text",
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Spacer(
              flex: 16,
            ),
            Expanded(
              flex: 66,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal:16.0),
                child: Text(
                  "${date.day}.${date.month}.${date.year} tarihi $start:00-$end:00 saatleri arası ${park.name} otoparkı, ${tpa.tpaName} tekil park alanı başarı ile kiralanmıştır.",
                  textAlign: TextAlign.center,
        style: TextStyle(
            color: Color(0xff005edb),
            fontSize: 17,
        ),
                ),
              ),
            ),
            Spacer(
              flex: 110,
            ),
            Expanded(
              flex: 28,
              child: Text(
                "${park.price*(end-start)} ₺",
                style: TextStyle(
                  decoration: TextDecoration.lineThrough,
                  color: gray500,
                  fontFamily: "SF Pro Display",
                  fontWeight: FontWeight.w600,
                  fontSize: 22
                ),
              ),
            ),
            Spacer(
              flex: 8,
            ),
            Expanded(
              flex: 28,
              child: Text(
                "0.00 ₺",
                style: TextStyle(
                  fontSize: 22,
                  color: blue500,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Spacer(
              flex: 16,
            ),
            Expanded(
              flex: 22,
              child: Text(
        "Toplam Ücret Tutarı",
        textAlign: TextAlign.center,
        style: TextStyle(
            color: blue600,
            fontSize: 17,
        ),
    ),
            ),
            Spacer(
              flex: 67,
            ),
            Expanded(
              flex: 56,
              child: Button.active(text: "Rezervasyona Git", onPressed: gitRezervasyon),
            ),
            Spacer(
              flex: 50,
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

  _backButtonFunc() {
    Get.back();
  }

  gitRezervasyon(){
    Get.to(()=>ReservationDetail(park: park,tpa: tpa,date: date,start: start,end: end,reservation: reservation,),fullscreenDialog: true);
  }
}