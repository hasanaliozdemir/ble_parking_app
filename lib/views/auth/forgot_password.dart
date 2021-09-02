import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gesk_app/core/colors.dart';
import 'package:gesk_app/core/components/button.dart';
import 'package:gesk_app/core/components/textInput.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:gesk_app/views/auth/signIn.dart';
import 'package:gesk_app/views/auth/signUp.dart';
import 'package:get/route_manager.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key key}) : super(key: key);

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {

  // var _focused = false.obs;

  
  TextEditingController phoneController= TextEditingController();

  FocusNode phoneFocus= FocusNode();




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
          "Parolamı Unuttum",
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
            "Sisteme üye olmak için kullandığınız telefon numaranızı yazınız. Şifre için telefonuna SMS ile doğrulama kodu göndereceğiz.",
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
              flex: 66,
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
              flex: 40,
            ),
            Expanded(
              flex: 56,
              child: _buildResetPasswordButton(),
            ),
            Spacer(
              flex: 288,
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
    phoneController.text = "(+90) ";
    return TextInputSimple(
      hintText: "Telefon Numarası",
      prefixIcon: Icon(CupertinoIcons.phone),
      controller: phoneController,
      focusNode: phoneFocus,
      textInputAction: TextInputAction.next,
      keyBoardType: TextInputType.phone,
      inputFormatters: [
        MaskedInputFormatter(
          '(+90) ###-###-##-##'
        )
      ],
      );
  }





  Widget _buildResetPasswordButton() {
    return Button.active(text: "Gönder", onPressed: _resetPassword);
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
    Get.to(()=>SignInScreen(),fullscreenDialog: true);
  }


  void _resetPassword(){
    print("sıfırla: ${phoneController.text}"); //Şifre sıfırlama kodu gönderilip kontrol edilcek
  }

  void _turnRegister(){
    Get.to(()=>SignUpScreen1());
  }

}//widget sonu