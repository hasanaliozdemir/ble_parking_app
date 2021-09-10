import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gesk_app/backend/dataService.dart';
import 'package:gesk_app/core/colors.dart';
import 'package:gesk_app/core/components/button.dart';
import 'package:gesk_app/core/components/passwordInput.dart';
import 'package:gesk_app/core/components/textInput.dart';
import 'package:gesk_app/models/user.dart';
import 'package:gesk_app/views/auth/signIn.dart';
import 'package:gesk_app/views/giris/MapScreen.dart';
import 'package:gesk_app/views/giris/MapScreen_readOnly.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpScreen1 extends StatefulWidget {
  const SignUpScreen1({Key key}) : super(key: key);

  @override
  _SignUpScreen1State createState() => _SignUpScreen1State();
}

class _SignUpScreen1State extends State<SignUpScreen1> {
  var dataService = DataService();
  var confirmed = false.obs;
  TextEditingController nameAndSurnameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController mailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  FocusNode nameFocus = FocusNode();
  FocusNode phoneFocus = FocusNode();
  FocusNode mailFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();

  PhoneNumber phoneNumber = PhoneNumber(isoCode: 'TR');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
      resizeToAvoidBottomInset: false,
    );
  }

  Widget _buildBackButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        child: GestureDetector(
          onTap: _backButtonFunc,
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
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
      func: () {
        FocusScope.of(context).requestFocus(phoneFocus);
      },
    );
  }

  Widget _buildBody() {
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
    return PasswordInput(
        hintText: "Parola",
        controller: passwordController,
        prefixIcon: Icon(CupertinoIcons.lock),
        focusNode: passwordFocus);
  }

  Widget _buildSecurityButton(RxBool comfirmed) {
    return Obx(() => Container(
          width: Get.width/375*343,
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Checkbox(
                  value: comfirmed.value,
                  onChanged: (val) {
                    comfirmed.value = val;
                  }),
              InkWell(
                onTap: _onTapGizlilik,
                child: Text(
                  "Gizlilik",
                  style: TextStyle(color: blue500, fontWeight: FontWeight.w600),
                ),
              ),
              Text(" ve "),
              InkWell(
                onTap: _onTapHizmet,
                child: Text(
                  "Hizmet Sözleşmelerini",
                  style: TextStyle(color: blue500, fontWeight: FontWeight.w600),
                ),
              ),
              Text(" kabul ediyorum.")
            ],
          ),
        ));
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
          Text("Mevcur bir hesabınız var mı ? "),
          InkWell(
            onTap: _turnSignIn,
            child: Text(
              "Oturumu Aç",
              style: TextStyle(color: blue500, fontWeight: FontWeight.w600),
            ),
          )
        ],
      ),
    );
  }

  void _backButtonFunc() {
    Get.to(() => MapScreenReadOnly());
  }

  void _onTapGizlilik() {
    print("gizlilik"); // TODO: Gizlilik sözleşmesi
  }

  void _onTapHizmet() {
    print("hizmet"); //TODO: Hizmet sözleşmesi
  }

  void _signUp() async {
    _showLoading();
    User _newUser = await dataService.registerUser(
        name:nameAndSurnameController.text,
        password:passwordController.text,
        phone:phoneNumber.phoneNumber,
        mail:mailController.text);

    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setInt("userId", _newUser.userId);

    bool _conf = await dataService.confirm(userId: _newUser.userId);

    if (_conf != null) {
      // TODO: false dönüyor
      _prefs.setBool("auth", true);

      Get.to(() => MapScreen(), fullscreenDialog: true);
    } else {
      Navigator.pop(context);
    }
  }

  void _turnSignIn() {
    Get.to(() => SignInScreen());
  }

  void _showLoading() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return Center(
            child: Container(
              width: Get.width / 375 * 50,
              height: Get.width / 375 * 50,
              decoration: BoxDecoration(
                  color: white, borderRadius: BorderRadius.circular(8)),
              child: CircularProgressIndicator.adaptive(),
            ),
          );
        });
  }
}//widget sonu