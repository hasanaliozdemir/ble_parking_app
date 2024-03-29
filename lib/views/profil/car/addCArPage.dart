import 'package:flutter/cupertino.dart';
import 'package:gesk_app/backend/dataService.dart';
import 'package:gesk_app/core/components/textInput.dart';
import 'package:gesk_app/views/profil/profileScreen.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:gesk_app/core/colors.dart';
import 'package:gesk_app/core/components/button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddCArPage extends StatefulWidget {
  const AddCArPage({ Key key }) : super(key: key);

  @override
  _AddCArPageState createState() => _AddCArPageState();
}

class _AddCArPageState extends State<AddCArPage> {
  var dataService = DataService();
  var _filled = 0.obs;
  String validatedPlate = "";
  String plateError = "";

  TextEditingController plakaController = TextEditingController();
  TextEditingController modelController = TextEditingController();

  FocusNode plakaFocus = FocusNode();
  FocusNode modelFocus = FocusNode();

  var _currentSelectedColor;
  var _currentSelectedSize;

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
            Expanded(flex:65,child: TextInputSimple(
              onTap: (){
                
                _filled.value = _filled.value +1;
              },
              errorText: (plateError=="") ? null : plateError,
              controller: plakaController,
              focusNode: plakaFocus,
              hintText: "Araç Plakası",
            )),
            
            Spacer(flex: 16,),
            //_modelYearBuilder(),
            //Spacer(flex: 16,),
            Expanded(flex:60,child: _buildColorDropDown()),
            Spacer(flex: 16,),
            Expanded(flex:60,child: _buildSizeDropDown()),
            Spacer(flex: 40,),
            Expanded(child: _buildConfirmButton(),flex: 56,),
            Spacer(flex: 174+76,),
            SizedBox(
              height: MediaQuery.of(context).padding.bottom,
            )
          ],
        ),
      ),
    );
  }

  Expanded _modelYearBuilder() {
    return Expanded(flex:60,child: TextInputSimple(
            onTap: (){
              
              _filled.value = _filled.value +1;
            },
            controller: modelController,
            focusNode: modelFocus,
            hintText: "Model",
          ));
  }

  bool validatePlate(String plate){
  plate = plate.replaceAll(' ', '');
  plate = plate.toUpperCase();
  print(plate);
  if(plate.length<4){
    return false;
  }else{
  var _everyChar = plate.split("");
   if(int.tryParse(_everyChar[0]) is int && int.tryParse(_everyChar[1]) is int && !(int.tryParse(_everyChar[2]) is int)){
    try{
    
   var _refLetter = _everyChar.toList();
   List<int> _refInts = [];
   _everyChar.forEach((element){
      if(int.tryParse(element) is int){
        _refInts.add(int.tryParse(element));
      }
   });
   _refInts.forEach((element){
    _refLetter.remove(element.toString());
   });
  var _regionPart = "${_refInts[0]}${_refInts[1]}";
  var _letterPart = _refLetter.join();
  var _lastPart = _refInts.sublist(2).join();
  validatedPlate = _regionPart+" "+ _letterPart + " " + _lastPart;
  return true;
   } catch(e){
   print(e);
   return false;
   }
   }else{
    return false;
   }
}
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

  List<String> _colors =[
    "Siyah",
    "Beyaz",
    "Gri",
    "Kırmızı",
    "Mavi",
    "Sarı",
    "Yeşil",
    "Mor",
    "Kahverengi",
    "Turuncu"
  ];

  List<String> _sizes =[
    "Sedan",
    "SUV",
    "Hatchback"
  ];

  Widget _buildColorDropDown(){
    return Container(
      height: Get.height / 812 * 44,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: gray600
        ),
        color: white
      ),
      padding: EdgeInsets.all(8),
      width: Get.width/375*343,
      child: DropdownButton<String>(
        icon: Icon(CupertinoIcons.chevron_down),
        isExpanded: true,
        underline: SizedBox(),
        items: _colors.map((String dropDownStringItem) {
          return DropdownMenuItem<String>(
            value: dropDownStringItem,
            child: Text(dropDownStringItem),
          );
        }).toList(),
        onChanged: (String newValueSelected){
          setState(() {
            _filled.value = _filled.value + 1;
                    _currentSelectedColor = newValueSelected;
                  });
        },
        value: _currentSelectedColor,
        hint: Text("Renk"),
      ),
    );
  }

  Widget _buildSizeDropDown(){
    return Container(
      height: Get.height / 812 * 44,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: gray600
        ),
        color: white
      ),
      padding: EdgeInsets.all(8),
      width: Get.width/375*343,
      child: DropdownButton<String>(
        icon: Icon(CupertinoIcons.chevron_down),
        isExpanded: true,
        underline: SizedBox(),
        items: _sizes.map((String dropDownStringItem) {
          return DropdownMenuItem<String>(
            value: dropDownStringItem,
            child: Text(dropDownStringItem),
          );
        }).toList(),
        onChanged: (String newValueSelected){
          setState(() {
            _filled.value = _filled.value + 1;
                    _currentSelectedSize = newValueSelected;
                  });
        },
        value: _currentSelectedSize,
        hint: Text("Boyut"),
      ),
    );
  }

  void _backButtonFunc() {
    Get.to(()=>ProfileScreen());
  }

  void _saveButtonFunc()async{
    _showLoading();
    if (validatePlate(plakaController.text)) {
      SharedPreferences _prefs = await SharedPreferences.getInstance();
    var _res = dataService.addCar(
      userId: _prefs.getInt("userId"),
      plate: validatedPlate,
      modelYear: "2021", //modelController.text,
      color: _currentSelectedColor,
      size: _currentSelectedSize
      
    );
    if (_res == null) {
      Navigator.pop(context);
    } else {
      _prefs.setString("carPlate",validatedPlate);
      Get.to(()=> ProfileScreen(),fullscreenDialog: true);
    }
    } else {
      setState(() {
        plateError = "Lütfen geçerli bir plaka giriniz";
      });
      Navigator.pop(context);
    }
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
}