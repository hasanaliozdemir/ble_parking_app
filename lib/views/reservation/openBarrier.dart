import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gesk_app/core/colors.dart';
import 'package:gesk_app/core/components/button.dart';
import 'package:get/get.dart';

class OpenBarrierPage extends StatefulWidget {
  const OpenBarrierPage({ Key key }) : super(key: key);

  @override
  _OpenBarrierPageState createState() => _OpenBarrierPageState();
}

class _OpenBarrierPageState extends State<OpenBarrierPage> {
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
              flex: 30,
            ),
            Expanded(
              flex:170,
              child: Container(
                child: SvgPicture.asset("assets/images/Vector.svg"),
              ),
            ),
            Spacer(
              flex: 59,
            ),
            Expanded(
              flex: 30,
              child: Text(
                "Evpark Bariyer Sistemi",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 17,
            fontFamily: "SF Pro Text",
            fontWeight: FontWeight.w600,
            color: blue500
                ),
              ),
            ),
            Expanded(
              flex: 44,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal:16.0),
                child: Text(
                  "Aracınızı belirlediğiniz tekil park alanına park etmek için bariyeri aktif hale getiriniz.",
                  style: TextStyle(
                    color: black,
                    fontSize: 17
                  ),
                ),
              ),
            ),
            Spacer(
              flex: 36,
            ),
            Expanded(
              flex: 56,
              child: Button.active(text: "Bariyeri Aç", onPressed: _openBarrier),
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

  _openBarrier()async{

  }
}