import 'package:flutter/cupertino.dart';
import 'package:gesk_app/core/components/textInput.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:gesk_app/core/colors.dart';
import 'package:gesk_app/core/components/button.dart';

class AddCArPage extends StatefulWidget {
  const AddCArPage({ Key key }) : super(key: key);

  @override
  _AddCArPageState createState() => _AddCArPageState();
}

class _AddCArPageState extends State<AddCArPage> {
  var _filled = 0.obs;

  TextEditingController plakaController = TextEditingController();
  TextEditingController renkController = TextEditingController();
  TextEditingController modelController = TextEditingController();

  FocusNode plakaFocus = FocusNode();
  FocusNode renkFocus = FocusNode();
  FocusNode modelFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).padding.top,
            ),Spacer(
              flex: 8,
            ),
            Expanded(child: _buildBackButton(),flex: 44,),
            Spacer(flex: 8,),
            Expanded(child: _buildHello(),flex: 41,),
            Spacer(flex: 16,),
            Expanded(child: _buildDescription(),flex: 44,),
            Spacer(flex: 16,),
            Expanded(flex:60,child: TextInputSimple(
              onTap: (){
                
                _filled.value = _filled.value +1;
              },
              controller: plakaController,
              focusNode: plakaFocus,
              hintText: "Araç Plakası",
            )),
            Spacer(flex: 16,),
            Expanded(flex:60,child: TextInputSimple(
              onTap: (){
                
                _filled.value = _filled.value +1;
              },
              controller: renkController,
              focusNode: renkFocus,
              hintText: "Renk",

            )),
            Spacer(flex: 16,),
            Expanded(flex:60,child: TextInputSimple(
              onTap: (){
                
                _filled.value = _filled.value +1;
              },
              controller: modelController,
              focusNode: modelFocus,
              hintText: "Model",
            )),
            Spacer(flex: 40,),
            Expanded(child: _buildConfirmButton(),flex: 56,),
            Spacer(flex: 250,),
            SizedBox(
              height: MediaQuery.of(context).padding.bottom,
            )
          ],
        ),
      ),
    );
  }


  Widget _buildConfirmButton(){
    return Obx((){
      if (_filled.value>2) {
      return Button.active(text: "Kaydet", onPressed: _saveButtonFunc);
    } else {
      return Button.passive(text: "Kaydet", onPressed: null);
    }
    });
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
          "Araç Ekle",
          style: TextStyle(
            color: blue500,
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
            "Otopark kiralamak ve bariyeri kaldırmak için araç eklemelisiniz.",
            style: TextStyle(
                color: Colors.black,
                fontSize: 17,
            ),
        ),
      ),
    );
  }

  void _backButtonFunc() {
    print("back");
  }

  void _saveButtonFunc(){

  }
}