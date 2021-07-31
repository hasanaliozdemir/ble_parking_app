import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gesk_app/core/colors.dart';
import 'package:gesk_app/core/components/button.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class AuthCodePage extends StatefulWidget {
  final String phoneNumber;
  AuthCodePage({ Key key, this.phoneNumber }) : super(key: key);

  @override
  _AuthCodePageState createState() => _AuthCodePageState();
}

class _AuthCodePageState extends State<AuthCodePage> {
  var authCode;
  var phoneNumber;
  var _filled = false.obs;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).padding.top,
            ),
            Spacer(
              flex: 8,
            ),
            Expanded(
              flex: 44,
              child:_buildBackButton(),
            ),
            Spacer(
              flex: 8,
            ),
            Expanded(child: _buildHello(),flex: 41,),
            Spacer(flex: 16,),
            Expanded(child: _buildDescription(),flex: 66,),
            Spacer(flex: 60,),
            Expanded(child: _buildPins(),flex: 64,),
            Spacer(flex: 80,),
            Expanded(child: _buildConfirmButton(),flex: 56,),
            Spacer(flex: 292,),
            SizedBox(
              height: MediaQuery.of(context).padding.bottom,
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

  Widget _buildHello() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:16.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          "Doğrulama Kodu",
          style: TextStyle(
            color: blue200,
            fontSize: 34,
            fontFamily: "SF Pro Display",
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  Widget _buildDescription() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:16.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
            "Giriş yapmak ve onaylamak için telefonunuza SMS olarak gönderilen doğrulama kodunu giriniz. $phoneNumber",
            style: TextStyle(
                color: Colors.black,
                fontSize: 17,
            ),
        ),
      ),
    );
  }

  Widget _buildConfirmButton() {
    return Obx((){
      if (_filled.value) {
        return Button.active(text: "Onayla", onPressed: _comfirmCode);
      } else {
        return Button.passive(text: "Onayla", onPressed: null);
      }
    });
  }

  Widget _buildPins(){
    return Container(
      padding: EdgeInsets.only(right: 65,left: 70 ),
      child: PinCodeTextField(
        appContext: context, 
        length: 4, 
        onChanged: (val){
          _filled.value = false;
        },
        keyboardType: TextInputType.number,
        cursorColor: blue500,
        pinTheme: PinTheme(
          inactiveFillColor: gray900,
          selectedFillColor: gray900,
          shape: PinCodeFieldShape.box,
          fieldHeight: Get.height/812*64,
          fieldWidth: Get.width/375*48,
          borderRadius: BorderRadius.circular(4),
          
          inactiveColor: gray900,
          activeColor: Colors.transparent,
          activeFillColor: brown100
        ),
        onCompleted: (String val){
          _filled.value = true;
          authCode = val;
        },
      ),
    );
  }

  void _backButtonFunc() {
    print("back");
  }

  void _comfirmCode(){
    print("sıfırla kod: $authCode");
  }

}