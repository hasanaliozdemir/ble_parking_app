import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gesk_app/core/colors.dart';
import 'package:gesk_app/core/components/button.dart';
import 'package:gesk_app/core/components/customSwitch.dart';

import 'package:gesk_app/models/filter_modal.dart';
import 'package:gesk_app/views/giris/MapScreen.dart';
import 'package:gesk_app/views/giris/SplashScreen.dart';
import 'package:get/get.dart';

class FilterDetail extends StatefulWidget {
  const FilterDetail({Key key, this.location, this.parks,@required this.filterModel}) : super(key: key);
  final location;
  final parks;
  final FilterModel filterModel;
  @override
  _FilterDetailState createState() => _FilterDetailState();
}

class _FilterDetailState extends State<FilterDetail> {




  var _isClosed = false.obs;
  var _isCam = false.obs;
  var _isWithSecurity = false.obs;
  var _isWithElectricity = false.obs;
  String _size;

  var _minPrice = 20.obs;
  var _maxPrice = 80.obs;

  RangeValues _values = RangeValues(20.0, 80.0);
  @override
  void initState() { 
    super.initState();
    _isClosed.value = widget.filterModel.isClosed;
    _isCam.value = widget.filterModel.isWithCam;
    _isWithSecurity.value = widget.filterModel.isWithSecurity;
    _isWithElectricity.value = widget.filterModel.isWithElectricity;

    _size = widget.filterModel.size;
    _minPrice.value = widget.filterModel.minPrice;
    _maxPrice.value = widget.filterModel.maxPrice;
    _values = RangeValues(widget.filterModel.minPrice.toDouble(), widget.filterModel.maxPrice.toDouble());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height / 812 * 732,
      decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10))),
      child: Column(
        children: [
          Spacer(
            flex: 8,
          ),
          Expanded(
            flex: 5,
            child: Container(
              width: 40,
              height: 5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Color(0xffaeaeb2),
              ),
            ),
          ),
          Spacer(
            flex: 16,
          ),
          Expanded(
            flex: 36,
            child: Row(
              children: [
                Spacer(
                  flex: 56,
                ),
                Expanded(
                  flex: 263,
                  child: Text(
                    "Filtre",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontFamily: "SF Pro Text",
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Spacer(
                  flex: 8,
                ),
                Expanded(
                  flex: 36,
                  child: Center(
                    child: IconButton(
                      icon: Icon(
                        CupertinoIcons.multiply_circle_fill,
                        color: gray900,
                        size: 24,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),
                Spacer(
                  flex: 8,
                ),
              ],
            ),
          ),
          Spacer(
            flex: 16,
          ),
          Expanded(
            flex: 1,
            child: Container(
              color: gray400,
              width: Get.width,
            ),
          ),
          Spacer(
            flex: 13,
          ),
          Expanded(
            flex: 48,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Fiyat Aralığı",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                    fontFamily: "SF Pro Text",
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              color: gray400,
              width: Get.width,
            ),
          ),
          Expanded(
              flex: 106,
              child: Container(
                height: Get.height / 812 * 106,
                child: Column(
                  children: [
                    Spacer(),
                    Expanded(
                      child: _buildRange(),
                    ),
                    Spacer(),
                    Expanded(child: _buildLabel())
                  ],
                ),
              )),
          Spacer(
            flex: 16,
          ),
          Expanded(
            flex: 48,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Otopark Özellikleri",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                    fontFamily: "SF Pro Text",
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              color: gray400,
              width: Get.width,
            ),
          ),
          Expanded(
            flex: 224,
            child: _buildList(),
          ),
          Spacer(
            flex: 8,
          ),
          Expanded(
            flex: 44,
            child: _buildSizeDropDown(),
          ),
          Spacer(
            flex: 24,
          ),
          Expanded(
            flex: 56,
            child: _buildButton(),
          ),
          Spacer(
            flex: 40,
          ),
          SizedBox(
            height: MediaQuery.of(context).padding.bottom,
          )
        ],
      ),
    );
  }

  Widget _buildRange() {
    return SliderTheme(
      data: SliderThemeData(
        activeTrackColor: Colors.white,
        inactiveTrackColor: Colors.grey,
        trackShape: RectangularSliderTrackShape(),
        trackHeight: 4.0,
        thumbColor: Colors.redAccent,
        thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12.0),
        overlayColor: Colors.grey,
        overlayShape: RoundSliderOverlayShape(overlayRadius: 28.0),
      ),
      child: RangeSlider(
          values: _values,
          min: 0,
          max: 100,
          activeColor: blue500,
          inactiveColor: gray500,
          onChanged: (RangeValues values) {
            setState(() {
              _values = values;
              _minPrice.value = values.start.toInt();
              _maxPrice.value = values.end.toInt();
            });
          }),
    );
  }

  Widget _buildLabel() {
    return Obx(() => Container(
          height: Get.height / 812 * 15,
          child: Row(
            children: [
              Spacer(
                flex: 16,
              ),
              Expanded(
                flex: _minPrice.value,
                child: Text(
                  _minPrice.value.toString() + "₺",
                  textAlign: TextAlign.right,
                  style: TextStyle(
                      fontFamily: "SF Pro Text",
                      fontWeight: FontWeight.w600,
                      fontSize: 13),
                ),
              ),
              Spacer(
                flex: (_maxPrice.value - _minPrice.value),
              ),
              Expanded(
                flex: 100 - _maxPrice.value,
                child: Text(
                  _maxPrice.value.toString() + "₺",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontFamily: "SF Pro Text",
                      fontWeight: FontWeight.w600,
                      fontSize: 13),
                ),
              ),
              Spacer(
                flex: 16,
              )
            ],
          ),
        ));
  }

  Widget _buildList() {
    return ListView(
      children: [
        _buildListTile1(),
        _buildListTile2(),
        _buildListTile3(),
        _buildListTile4(),
      ],
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

  List<String> _sizes = ["Sedan", "SUV", "Hatchback"];

  Widget _buildSizeDropDown() {
    return Container(
      height: Get.height / 812 * 44,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: gray600),
          color: white),
      padding: EdgeInsets.all(8),
      width: Get.width / 375 * 343,
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
        onChanged: (String newValueSelected) {
          setState(() {
            _size = newValueSelected;
          });
        },
        value: _size,
        hint: Text("Boyut"),
      ),
    );
  }

  Widget _buildButton(){
    return Button.active(text: "Otopark Ara", onPressed: (){
      FilterModel _filter = FilterModel(
        isClosed: _isClosed.value,
        isWithCam: _isCam.value,
        isWithElectricity: _isWithElectricity.value,
        isWithSecurity: _isWithSecurity.value,
        minPrice: _minPrice.value,
        maxPrice: _maxPrice.value,
        size: _size
      );

      Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => MapScreen(filterModel: _filter,firstParks: widget.parks,location: widget.location,)),
  );
      
      print(_filter.maxPrice);
    });
  }

  
}
