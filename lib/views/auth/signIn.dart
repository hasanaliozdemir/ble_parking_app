import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gesk_app/backend/dataService.dart';
import 'package:gesk_app/core/colors.dart';
import 'package:gesk_app/core/components/button.dart';
import 'package:gesk_app/core/components/passwordInput.dart';
import 'package:gesk_app/core/components/textInput.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:gesk_app/core/widgets.dart';

import 'package:gesk_app/views/auth/forgot_password.dart';
import 'package:gesk_app/views/auth/signUp.dart';
import 'package:gesk_app/views/giris/MapScreen.dart';
import 'package:gesk_app/views/giris/MapScreen_readOnly.dart';
import 'package:gesk_app/wrapper.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
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

  var dataService =DataService();

  PhoneNumber phoneNumber = PhoneNumber(isoCode: 'TR');
  
  @override
  Widget build(BuildContext context) {
    phoneController.text = "(+90)";
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
    return Container(
      width: Get.width / 375 * 343,
      height: Get.height / 812 * 60,
      child: Stack(
        children: [
          Container(
            width: Get.width / 375 * 343,
            height: Get.height / 812 * 44,
            decoration: BoxDecoration(
                color: white,
                border: Border.all(color: gray600),
                borderRadius: BorderRadius.circular(8)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: InternationalPhoneNumberInput(
              onInputChanged: (PhoneNumber number) {
                phoneNumber = number;
              },
              countries: ["TR"],
              formatInput: true,
              autoValidateMode: AutovalidateMode.disabled,
              hintText: "Telefon Numarası",
              maxLength: 13,
              validator: (String val) {
                if (val.length == 10) {
                  return val;
                } else {
                  return "non";
                }
              },
              inputDecoration: InputDecoration(border: InputBorder.none),
            ),
          )
        ],
      ),
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
    
    



    return PasswordInput(
      controller: passwordController, 
      focusNode: passwordFocus,
      prefixIcon: Icon(CupertinoIcons.lock),
      hintText: "Parola",
    );
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
    Get.to(()=>MapScreenReadOnly());
  }


  void _signIn() async{
    _showLoading();
    var _newUser = await dataService.login(context: context,phoneNumber:phoneNumber.phoneNumber, password:passwordController.text);
    if (_newUser == null) {
      print("helo");
      Widgets().showAlert(context, "Bir hata oluştu");
    } else {
      SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setInt("userId", _newUser.userId);

    var _conf = await dataService.confirm(userId: _newUser.userId);
    if (_conf) {
      _prefs.setBool("auth", true);
      Get.to(()=>MapScreen(),fullscreenDialog: true);
    }else{
      Navigator.pop(context);
      print("yanlış");
    }
    }
  }

  void _turnRegister(){
    Get.to(()=>SignUpScreen1());
  }

  void _forgotPassword(){
    Get.to(()=>ForgotPasswordPage());
  }

  void _showLoading(){
    showDialog(
      barrierDismissible: false,
      context: context, 
    builder: (context){
      return Center(
        child: Container(
          width: Get.width/375*50,
          height: Get.width/375*50,
          decoration: BoxDecoration(
            color: white,
            borderRadius: BorderRadius.circular(8)
          ),
          child: CircularProgressIndicator.adaptive(),
        ),
      );
    });
  }
}//widget sonu