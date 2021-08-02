import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gesk_app/core/colors.dart';
import 'package:gesk_app/core/components/button.dart';
import 'package:gesk_app/core/components/textInput.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:get/get.dart';

class SignUpScreen1 extends StatefulWidget {
  const SignUpScreen1({Key key}) : super(key: key);

  @override
  _SignUpScreen1State createState() => _SignUpScreen1State();
}

class _SignUpScreen1State extends State<SignUpScreen1> {
  var confirmed = false.obs;
  TextEditingController nameAndSurnameController = TextEditingController();
  TextEditingController phoneController= TextEditingController();
  TextEditingController mailController= TextEditingController();
  TextEditingController passwordController= TextEditingController();

  FocusNode nameFocus = FocusNode();
  FocusNode phoneFocus= FocusNode();
  FocusNode mailFocus= FocusNode();
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
          "Merhaba",
          style: TextStyle(
            color: Color(0xff99d8ff),
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
      child: Text(
          "Üye olmak için gerekli olan bilgilerinizi doldurunuz.",
          style: TextStyle(
              color: Colors.black,
              fontSize: 17,
          ),
      ),
    );
  }

  Widget _buildNameForm() {
    return TextInputSimple(
      textInputAction: TextInputAction.next,
      prefixIcon: Icon(CupertinoIcons.person),
      hintText: "İsim Soyisim",
      controller: nameAndSurnameController,
      focusNode: nameFocus,
      func: (){
        FocusScope.of(context).requestFocus(phoneFocus);
      },
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
              flex: 16,
            ),
            Expanded(
              flex: 60,
              child: _buildNameForm(),
            ),
            Spacer(
              flex: 16,
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
              child: _buildMailForm(),
            ),
            Spacer(
              flex: 16,
            ),
            Expanded(
              flex: 60,
              child: _buildPasswordForm(),
            ),
            Spacer(
              flex: 24,
            ),
            Expanded(
              flex: 24,
              child: _buildSecurityButton(confirmed),
            ),
            Spacer(
              flex: 40,
            ),
            Expanded(
              flex: 56,
              child: _buildSignUpButton(),
            ),
            Spacer(
              flex: 40,
            ),
            Expanded(
              flex: 56,
              child: _buildAlreadyHaveAccount(),
            ),
            Spacer(
              flex: 30,
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

  Widget _buildMailForm() {
    return TextInputSimple(
      controller: mailController,
      focusNode: mailFocus,
      hintText: "E-mail",
      prefixIcon: Icon(CupertinoIcons.mail),
      keyBoardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      );
  }

  Widget _buildPasswordForm() {
    var _focused = false.obs;
    var secure = false.obs;
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
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 0,
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

  Widget _buildSecurityButton(RxBool comfirmed) {
    return Obx(()=>
      Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Checkbox(value: comfirmed.value, onChanged: (val){
            comfirmed.value = val;
          }),
          InkWell(
            onTap: 
              _onTapGizlilik
            ,
            child: Text(
              "Gizlilik",
              style: TextStyle(
                color: blue500,
                fontWeight: FontWeight.w600
              ),
            ),
          ),
          Text(
            " ve "
          ),
          InkWell(
            onTap: _onTapHizmet,
            child: Text(
              "Hizmet Sözleşmelerini",
              style: TextStyle(color: blue500,fontWeight: FontWeight.w600),
            ),
          ),
          Text(
            " kabul ediyorum."
          )
        ],
      ),
    )
    );
  }

  Widget _buildSignUpButton() {
    return Button.active(text: "Üye Ol", onPressed: _signUp);
  }

  Widget _buildAlreadyHaveAccount() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Mevcur bir hesabınız var mı ? "
          ),
          InkWell(
            onTap: _turnSignIn,
            child: Text(
              "Oturumu Aç",
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

  void _onTapGizlilik(){
    print("gizlilik");
  }

  void _onTapHizmet(){
    print("hizmet");
  }

  void _signUp(){
    print("kayıt");
  }

  void _turnSignIn(){
    print("giriş yapma sayfasına");
  }
}//widget sonu