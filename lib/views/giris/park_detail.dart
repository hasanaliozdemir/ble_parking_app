import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gesk_app/core/colors.dart';
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
            Spacer(flex: 13,),
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
            Spacer(flex: 13,),
            Expanded(
              flex: 1,
              child: Container(
                color: gray400,
                height: Get.height / 812 * 1,
                width: Get.width,
              ),
            ),
            Expanded(
              flex: 580,
              child: ListView(
                children: [],
              ),
            )
          ],
        ));
  }
}
