import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gesk_app/core/colors.dart';
import 'package:gesk_app/core/components/button.dart';
import 'package:gesk_app/core/components/textInput.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:get/get.dart';

class SignUpScreen2 extends StatefulWidget {
  const SignUpScreen2({Key key}) : super(key: key);

  @override
  _SignUpScreen2State createState() => _SignUpScreen2State();
}

class _SignUpScreen2State extends State<SignUpScreen2> {
  @override
  void initState() {
    super.initState();
    passwordFocus.addListener(_onFocusChange);
  }
  var _focused = false.obs;
  var confirmed = false.obs;
  
  TextEditingController phoneController= TextEditingController();
  TextEditingController passwordController= TextEditingController();

  FocusNode phoneFocus= FocusNode();
  FocusNode passwordFocus= FocusNode();

  var _secure = false.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
      resizeToAvoidBottomInset: false
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
          "Hoşgeldiniz",
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
            "Mevcut hesabınız ile giriş yapabilirsiniz.",
            style: TextStyle(
                color: Colors.black,
                fontSize: 17,
            ),
        ),
      ),
    );
  }


  Widget _buildBody(){
    return Container(
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
              child: _buildBackButton(),
            ),
            Spacer(
              flex: 8,
            ),
            Expanded(
              flex: 41,
              child: _buildHello(),
            ),
            Spacer(
              flex: 16,
            ),
            Expanded(
              flex: 44,
              child: _buildDescription(),
            ),
            Spacer(
              flex: 40,
            ),
            Expanded(
              flex: 60,
              child: _buildPhoneForm(),
            ),
            Spacer(
              flex: 16,
            ),
            Expanded(
              flex: 60,
              child: _buildPasswordForm(),
            ),
            Spacer(flex: 8,),
            Expanded(
              flex: 16,
              child: Padding(
                padding: EdgeInsets.only(
                  right: 16
                ),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                  onTap: _forgotPassword,
                  child: Text(
                    "Parolamı unuttum."
                    ,style: TextStyle(
                      color: gray900,
                      fontWeight: FontWeight.w400
                    ),
                  ),
            ),
                ),
              )),
            Spacer(
              flex: 40,
            ),
            Expanded(
              flex: 56,
              child: _buildSignInButton(),
            ),
            Spacer(
              flex: 236,
            ),
            Expanded(
              flex: 56,
              child: _buildCreateAccount(),
            ),
            Spacer(
              flex: 16,
            ),
            SizedBox(
              height: MediaQuery.of(context).padding.bottom,
            )
          ],
        ),
      );
  }

  Widget _buildPhoneForm() {
    return TextInputSimple(
      hintText: "Telefon Numarası",
      prefixIcon: Icon(CupertinoIcons.phone),
      controller: phoneController,
      focusNode: phoneFocus,
      textInputAction: TextInputAction.next,
      keyBoardType: TextInputType.phone,
      inputFormatters: [
        PhoneInputFormatter(
          onCountrySelected:  (PhoneCountryData countryData) {
            print(countryData.country);}
        )
      ],
      );
  }

    void _onFocusChange() {
    if (passwordFocus.hasFocus) {
      _focused.value = true;
    } else {
      _focused.value = false;
    }
  }

  Widget _buildPasswordForm() {
    
    String errorText ="";



    return Obx(() => Container(
          width: Get.width / 375 * 343,
          height: Get.height / 812 * 44,
          decoration: BoxDecoration(
              border: _focused.value
                  ? Border.all(color: blue500)
                  : Border.all(color: Colors.transparent),
              boxShadow: [
                BoxShadow(
                  color: Color(0x33000000),
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
              borderRadius: BorderRadius.circular(8),
              color: white),
          padding: EdgeInsets.only(
            right: 8,
            left: 8,

          ),
          child: TextFormField(
            keyboardType: TextInputType.visiblePassword,
            textInputAction: TextInputAction.done,
            focusNode: passwordFocus,
            obscureText: _secure.value,
            controller: passwordController,
            decoration: InputDecoration(
                hintText: "Parola",
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                focusColor: blue500,
                prefixIcon: Icon(CupertinoIcons.lock),
                suffixIcon: Container(
                  height: Get.height/812 *30,
                  child: IconButton(
                    icon: _secure.value ? Icon(CupertinoIcons.eye_slash) : Icon(CupertinoIcons.eye),
                    onPressed: (){
                      _secure.value = !_secure.value;
                    },
                  ),
                ),
                errorText: errorText),
          ),
        ));
  }


  Widget _buildSignInButton() {
    return Button.active(text: "Giriş yap", onPressed: _signIn);
  }

  Widget _buildCreateAccount() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Üye değil misiniz ? "
          ),
          InkWell(
            onTap: _turnRegister,
            child: Text(
              "Üye Ol",
              style: TextStyle(
                color: blue500,
                fontWeight: FontWeight.w600
              ),
            ),
          )
        ],
      ),
    );
  }

  void _backButtonFunc() {
    print("back");
  }


  void _signIn(){
    print("giriş");
  }

  void _turnRegister(){

  }

  void _forgotPassword(){

  }
}//widget sonu