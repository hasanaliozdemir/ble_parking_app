import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gesk_app/backend/dataService.dart';
import 'package:gesk_app/core/colors.dart';
import 'package:gesk_app/core/components/button.dart';
import 'package:gesk_app/core/components/customSwitch.dart';
import 'package:gesk_app/core/components/textInput.dart';
import 'package:gesk_app/data_models/address.dart';

import 'package:gesk_app/models/park.dart';
import 'package:gesk_app/services/addressService.dart';
import 'package:gesk_app/services/imageService.dart';
import 'package:gesk_app/views/profil/park/addParkPage.dart';
import 'package:gesk_app/views/profil/profileScreen.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditParkPage extends StatefulWidget {
  Address address;
  Park park;

  EditParkPage({Key key, this.park, this.address}) : super(key: key);

  @override
  _EditParkPageState createState() => _EditParkPageState(park, address);
}

class _EditParkPageState extends State<EditParkPage> {
  Park _park;
  Address _address;
  var _formattedAdress = "";
  var dataService = DataService();
  var imageService = ImageService();

  TextEditingController _parkNameController = TextEditingController();
  TextEditingController _parkInfoController = TextEditingController();

  FocusNode _parkNameFocus = FocusNode();
  FocusNode _parkInfoFocus = FocusNode();

  var _isClosed = false.obs;
  var _isCam = false.obs;
  var _isWithSecurity = false.obs;
  var _isWithElectricity = false.obs;

  List<XFile> _imageFileList = List<XFile>.generate(5, (index) => null);
  List<Uint8List> _imageBytesList =
      List<Uint8List>.generate(5, (index) => null);

  final ImagePicker _picker = ImagePicker();

  _EditParkPageState(this._park, this._address);

  @override
  void initState() {
    super.initState();
    loadImageList();
    loadParkInfo();
    getAddress();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: _buildBody(context),
          )
        ],
      ),
    );
  }

  Padding _buildBody(BuildContext context) {
    return Padding(
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
          Spacer(
            flex: 200,
          )
        ],
      ),
    );
  }

  Container _builList(BuildContext context) {
    return Container(
      height: Get.height / 812 * 650,
      width: Get.width,
      child: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: ListView(
          physics: NeverScrollableScrollPhysics(),
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
                    flex: 65,
                    child: _buildParkName(),
                  ),
                  Spacer(
                    flex: 16,
                  ),
                  // Expanded(flex: 44,child: _buildTpaNumber(),),
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
                    flex: 65,
                    child: TextInputSimple(
                      controller: _parkInfoController,
                      focusNode: _parkInfoFocus,
                      hintText: "Otopark açıklaması/detayları",
                    ),
                  ),
                  Spacer(
                    flex: 8,
                  ),
                  Expanded(
                    flex: 56,
                    child: Button.active(text: "Kaydet", onPressed: _savePark),
                  ),
                  Spacer(
                    flex: 96,
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
                        image: (_imageBytesList != null)
                            ? _imageBytesList[index] == null
                                ? AssetImage("assets/images/carpark-image.png")
                                : MemoryImage(_imageBytesList[index])
                            : AssetImage("assets/images/carpark-image.png"),
                        fit: BoxFit.fill)),
              ),
            ),
          );
        },
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
      child: GestureDetector(
        onTap: _changeLocation,
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
                _formattedAdress,
                style: TextStyle(
                    color: gray900,
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                    fontFamily: "SF Pro Text"),
              ),
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
        "Sahip olduğunuz otopark alanı hakkında gerekli bilgileri doldurunuz.",
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
          "Otopark Düzenle",
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
    Get.back();
  }

  _pickImage(index) async {
    try {
          var newImage = await _picker.pickImage(source: ImageSource.gallery);
    var newBytes = await imageService.testCompressFile(File(newImage.path));

    setState(() {
      _imageFileList[index] = newImage;
      _imageBytesList[index] = newBytes;
    });
    } catch (e) {
      Get.snackbar("Error", e);
    }
  }

  void _savePark() async {
    _showLoading();

    SharedPreferences _prefs = await SharedPreferences.getInstance();
    var _userId = _prefs.getInt("userId");

    var _editPark = await dataService.editPark(
      context: context,
      userId: _userId,
      parkId: _park.id,
      isClosedPark: _isClosed.value,
      isWithCam: _isCam.value,
      isWithSecurity: _isWithSecurity.value,
      isWithElectricity: _isWithElectricity.value,
      name: _parkNameController.text,
      parkInfo: _parkInfoController.text
    );

    
      uploadPhotos(_editPark.id);
      Get.to(() => ProfileScreen(), fullscreenDialog: true);
    
  }

  uploadPhotos(int parkId) async {
    _imageBytesList.forEach((element) {
      if (element != null) {
        dataService.uploadParkPhoto(parkId: parkId, bytes: element);
      }
    });
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

  loadParkInfo() {
    _isCam.value = _park.isWithCam;
    _isClosed.value = _park.isClosedPark;
    _isWithElectricity.value = _park.isWithElectricity;
    _isWithSecurity.value = _park.isWithSecurity;
    _parkNameController.text = _park.name;
    _parkInfoController.text = (_park.info != null) ? _park.info : "";
    print(_park.info);
  }

  loadImageList() {
    var _ids = _park.imageUrls;

    _ids.forEach((id) async {
      dataService.downloadPhoto(parkId: _park.id, photoId: id).then((byte) {
        setState(() {
          _imageBytesList[_ids.indexWhere((element) => element == id)] = byte;
        });
      });
    });
  }

  getAddress() async {
    var _adres = await AdressService()
        .getFormatedAddress(LatLng(_park.latitude, _park.longitude));
    setState(() {
      _formattedAdress = _adres.formattedAddress;
    });
  }

  _changeLocation(){
    //TODO: Lokasyon değiştirme eklenecek
  }
}
