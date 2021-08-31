import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gesk_app/backend/dataService.dart';
import 'package:gesk_app/core/colors.dart';
import 'package:gesk_app/core/components/button.dart';
import 'package:gesk_app/core/components/customSwitch.dart';
import 'package:gesk_app/core/components/textInput.dart';
import 'package:gesk_app/data_models/address.dart';
import 'package:gesk_app/data_models/location.dart';
import 'package:gesk_app/views/profil/park/addParkPage.dart';
import 'package:gesk_app/views/profil/profileScreen.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddParkDetails extends StatefulWidget {
  final Address address;
  final Location location;

  const AddParkDetails({Key key, this.address,this.location}) : super(key: key);

  @override
  _AddParkDetailsState createState() => _AddParkDetailsState(address: address,location: location);
}

class _AddParkDetailsState extends State<AddParkDetails> {
  final Location location;
  final Address address;
  var dataService = DataService();

  TextEditingController _parkNameController = TextEditingController();
  TextEditingController _tpaNumberController = TextEditingController();
  TextEditingController _parkInfoController = TextEditingController();

  FocusNode _parkNameFocus = FocusNode();
  FocusNode _tpaNumberFocus = FocusNode();
  FocusNode _parkInfoFocus = FocusNode();

  var _isClosed = false.obs;
  var _isCam = false.obs;
  var _isWithSecurity = false.obs;
  var _isWithElectricity = false.obs;

  List<XFile> _imageFileList = List<XFile>.generate(5, (index) => null);

  set _imageFile(XFile value) {
    _imageFileList = value == null ? null : [value];
  }

  final ImagePicker _picker = ImagePicker();

  _AddParkDetailsState({this.address,this.location});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).padding.top,
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
              child: _buildtitle(),
            ),
            Expanded(
              flex: 44,
              child: _buildDesc(),
            ),
            Spacer(
              flex: 8,
            ),
            Expanded(
              flex: 480,
              child: _builList(context),
            ),
          ],
        ),
      ),
    );
  }

  Container _builList(BuildContext context) {
    return Container(
              height: Get.height / 812 * 596,
              width: Get.width,
              child: MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Container(
                      height: Get.height / 812 * 700,
                      child: Column(
                        children: [
                          Expanded(
                            flex: 44,
                            child: _buildFormattedAddress(),
                          ),
                          Spacer(
                            flex: 16,
                          ),
                          Expanded(
                            flex: 44,
                            child: _buildParkName(),
                          ),
                          Spacer(
                            flex: 16,
                          ),
                          Expanded(
                            flex: 44,
                            child: _buildTpaNumber(),
                          ),
                          Spacer(
                            flex: 16,
                          ),
                          Expanded(
                            flex: 44,
                            child: _buildListTile1(),
                          ),
                          Spacer(
                            flex: 8,
                          ),
                          Expanded(
                            flex: 44,
                            child: _buildListTile2(),
                          ),
                          Spacer(
                            flex: 8,
                          ),
                          Expanded(
                            flex: 44,
                            child: _buildListTile3(),
                          ),
                          Spacer(
                            flex: 8,
                          ),
                          Expanded(
                            flex: 44,
                            child: _buildListTile4(),
                          ),
                          Spacer(
                            flex: 16,
                          ),
                          Expanded(
                            flex: 96,
                            child: _buildImagePicker(),
                          ),
                          Spacer(
                            flex: 16,
                          ),
                          Expanded(
                            flex: 120,
                            child: TextInputSimple(
                              controller: _parkInfoController,
                              focusNode: _parkInfoFocus,
                              hintText:
                                  "Otopark hakkında ek bilgi ekleyebilirsiniz.",
                            ),
                          ),
                          Spacer(
                            flex: 16,
                          ),
                          Expanded(
                            flex: 56,
                            child: Button.active(
                                text: "Kaydet", onPressed: _savePark),
                          ),
                          Spacer(
                            flex: 36,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
  }

  Container _buildImagePicker() {
    return Container(
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: GestureDetector(
              onTap: () {
                _pickImage(index);
              },
              child: Container(
                width: Get.width / 375 * 96,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    image: DecorationImage(
                        image: _imageFileList[index] == null
                            ? AssetImage("assets/images/carpark-image.png")
                            : FileImage(File(_imageFileList[index].path)),
                        fit: BoxFit.fill)),
              ),
            ),
          );
        },
      ),
    );
  }

  Padding _buildTpaNumber() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: TextInputSimple(
        controller: _tpaNumberController,
        focusNode: _tpaNumberFocus,
        hintText: "Tekil Park Alanı Sayısı",
        keyBoardType: TextInputType.number,
      ),
    );
  }

  Padding _buildParkName() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: TextInputSimple(
        controller: _parkNameController,
        focusNode: _parkNameFocus,
        hintText: "Otopark Adı",
      ),
    );
  }

  Padding _buildFormattedAddress() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        decoration: BoxDecoration(border: Border.all(color: gray600)),
        child: ListTile(
          leading: Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: SvgPicture.asset(
              "assets/icons/adressPin.svg",
              color: blue500,
            ),
          ),
          title: Container(
            alignment: Alignment.topCenter,
            child: Text(
              address.formattedAddress,
              style: TextStyle(
                  color: gray900,
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                  fontFamily: "SF Pro Text"),
            ),
          ),
        ),
      ),
    );
  }

  Padding _buildDesc() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        "Sahip olduğunuz otopark alanını hakkında gerekli bilgileri doldurunuz.",
        style: TextStyle(
            fontFamily: "SF Pro Text",
            fontSize: 17,
            fontWeight: FontWeight.w400,
            color: black),
      ),
    );
  }

  Padding _buildtitle() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          "Otopark Ekle",
          textAlign: TextAlign.left,
          style: TextStyle(
              fontFamily: "SF Pro Display",
              fontWeight: FontWeight.w700,
              fontSize: 31,
              color: blue500),
        ),
      ),
    );
  }

  Widget _buildListTile1() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ListTile(
        leading: Container(
          width: Get.width / 375 * 36,
          height: Get.width / 375 * 36,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(width: 2, color: blue500)),
          child: Icon(
            CupertinoIcons.square_grid_3x2_fill,
            color: blue500,
          ),
        ),
        title: Text(
          "Kapalı Otopark",
          style: TextStyle(
            color: black,
            fontSize: 17,
          ),
        ),
        trailing: Container(
          width: Get.width / 375 * 50,
          child: CustomSwitch(
            value: _isClosed,
            passiveToggleColor: gray700,
          ),
        ),
      ),
    );
  }

  Widget _buildListTile2() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ListTile(
        leading: Container(
          width: Get.width / 375 * 36,
          height: Get.width / 375 * 36,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(width: 2, color: blue500)),
          child: Icon(
            CupertinoIcons.video_camera_solid,
            color: blue500,
          ),
        ),
        title: Text(
          "Güvenlik Kamerası",
          style: TextStyle(
            color: black,
            fontSize: 17,
          ),
        ),
        trailing: Container(
          width: Get.width / 375 * 50,
          child: CustomSwitch(
            value: _isCam,
            passiveToggleColor: gray700,
          ),
        ),
      ),
    );
  }

  Widget _buildListTile3() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ListTile(
        leading: Container(
          width: Get.width / 375 * 36,
          height: Get.width / 375 * 36,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(width: 2, color: blue500)),
          child: Icon(
            CupertinoIcons.bolt_fill,
            color: blue500,
          ),
        ),
        title: Text(
          "Elektrikli Şarj İstasyonu",
          style: TextStyle(
            color: black,
            fontSize: 17,
          ),
        ),
        trailing: Container(
          width: Get.width / 375 * 50,
          child: CustomSwitch(
            value: _isWithElectricity,
            passiveToggleColor: gray700,
          ),
        ),
      ),
    );
  }

  Widget _buildListTile4() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ListTile(
        leading: Container(
          width: Get.width / 375 * 36,
          height: Get.width / 375 * 36,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(width: 2, color: blue500)),
          child: Icon(
            CupertinoIcons.shield_lefthalf_fill,
            color: blue500,
          ),
        ),
        title: Text(
          "Güvenlik Personeli",
          style: TextStyle(
            color: black,
            fontSize: 17,
          ),
        ),
        trailing: Container(
          width: Get.width / 375 * 50,
          child: CustomSwitch(
            value: _isWithSecurity,
            passiveToggleColor: gray700,
          ),
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

  void _backButtonFunc() {
    Get.to(() => AddParkPage());
  }

  _pickImage(index) async {
    var newImage = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _imageFileList[index] = newImage;
    });
    _imageFileList.forEach((element) {
      print(element);
    });
  }

  void _savePark()async {
    _showLoading();

    SharedPreferences _prefs = await SharedPreferences.getInstance();
    var _userId = _prefs.getString("userId");

    
    var _newPark = await dataService.addPark(
      userId: _userId, 
      isClosedPark:_isClosed.value,
      isWithCam: _isCam.value, 
      isWithSecurity: _isWithSecurity.value, 
      isWithElectricity: _isWithElectricity.value, 
      name: _parkNameController.text, 
      longitude: address.latLng.longitude, 
      latitude: address.latLng.latitude, 
      location: address.mahalle);

    if(_newPark.name != null){
      Get.to(()=> ProfileScreen(),fullscreenDialog: true);
    }else{
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
