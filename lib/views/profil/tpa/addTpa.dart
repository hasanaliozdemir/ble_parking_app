import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gesk_app/backend/dataService.dart';
import 'package:gesk_app/core/colors.dart';
import 'package:gesk_app/core/components/button.dart';
import 'package:gesk_app/core/components/textInput.dart';
import 'package:gesk_app/data_models/time_range.dart';
import 'package:gesk_app/models/park.dart';
import 'package:gesk_app/views/profil/profileScreen.dart';
import 'package:get/get.dart';

class AddTpaPage extends StatefulWidget {
  final Park park;
  const AddTpaPage({Key key, this.park}) : super(key: key);

  @override
  _AddTpaPageState createState() => _AddTpaPageState(park);
}

class _AddTpaPageState extends State<AddTpaPage> {
  final Park park;

  var _filled = 0.obs;

  DataService _dataService = DataService();

  int selectedHourStart = 0;
  int selectedHourEnd = 0;

  int selectedMinuteStart = 0;
  int selectedMinuteEnd = 0;

  // ignore: deprecated_member_use
  List<TimeRange> timeRanges = List<TimeRange>();

  TextEditingController _tpaNameController = TextEditingController();
  

  FocusNode _tpaNameFocus = FocusNode();
  

  var _currentSelectedSize;
  

  _AddTpaPageState(this.park);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: _buildBody(),
    );
  }

  _buildBody() {
    return Column(
      children: [
        SizedBox(height: MediaQuery.of(context).padding.top),
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
          flex: 44,
          child: _buildTitle(),
        ),
        Spacer(
          flex: 16,
        ),
        Expanded(
          flex: 44,
          child: _buildDesc(),
        ),
        Spacer(
          flex: 24,
        ),
        Expanded(
          child: _buildParkName(),
          flex: 44,
        ),
        Spacer(
          flex: 24,
        ),
        Expanded(
          child: _buildTpaName(),
          flex: 60,
        ),
        Spacer(
          flex: 24,
        ),
        Expanded(
          child: _buildSizeDropDown(),
          flex: 44,
        ),
        Spacer(
          flex: 24,
        ),
        Expanded(
          child: _buildTimeRange(),
          flex: 44,
        ),
        Spacer(
          flex: 24,
        ),
        Expanded(
          flex: 50,
          child: _buildTimeZones(),
        ),
        Spacer(
          flex: 16,
        ),
        // Expanded(flex: 44,child: _buildElectricity(),),
        Spacer(
          flex: 16+68,
        ),
        Expanded(
          flex: 56,
          child: _buildButton(),
        ),
        Spacer(
          flex: 40,
        )
      ],
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

  _buildTitle() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "TPA Ekle",
            style: TextStyle(
                color: blue500,
                fontFamily: "SF Pro Display",
                fontWeight: FontWeight.w700,
                fontSize: 34),
          ),
        ),
      ),
    );
  }

  _buildDesc() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Sahip olduğunuz tekil park alanını hakkında gerekli bilgileri doldurunuz.",
            style: TextStyle(
                color: black,
                fontFamily: "SF Pro Text",
                fontWeight: FontWeight.w400,
                fontSize: 17),
          ),
        ),
      ),
    );
  }

  _buildParkName() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
            border: Border.all(color: gray600),
            borderRadius: BorderRadius.circular(8)),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            park.name??"",
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 17,
            ),
          ),
        ),
      ),
    );
  }

  _buildTpaName() {
    return Container(
      child: TextInputSimple(
        focusNode: _tpaNameFocus,
        controller: _tpaNameController,
        hintText: "Otopark Alan No",
        onTap: (){
          _filled.value = _filled.value +1;
          setState(() {
                      
                    });
        },
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
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: DropdownButton<String>(
            icon: Icon(
              CupertinoIcons.chevron_down,
              color: blue500,
            ),
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
                _currentSelectedSize = newValueSelected;
                
              });
            },
            value: _currentSelectedSize,
            hint: Text("Maks. Boyut"),
          ),
        ));
  }

  _buildTimeRange() {
    return Container(child: _buildTimePicker());
  }

  _buildTimeZones() {
    return Padding(
      padding:  const EdgeInsets.symmetric(horizontal:16.0),
      child: Container(
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: timeRanges.length ?? 0,
          itemBuilder: (context,index){
            return  Container(
              
              height: Get.height/812*47,
                    width: Get.width/375*115,
              child: Stack(
                children: [
                  _buildTimeZoneLayerOne(index),
                  _buildTimeZoneLayerTwo(index),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Align _buildTimeZoneLayerTwo(index) {
    return Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    height: Get.height/812*32,
                    width: Get.height/812*32,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: gray500,
                      border: Border.all(color: white,width: 1)
                    ),
                    child: Center(
                      child: IconButton(

                        icon: Icon(CupertinoIcons.multiply_circle,color: white,),
                        onPressed: (){
                          timeRanges.removeAt(index);
                          setState(() {
                                                    
                                                  });
                        },
                      ),
                    ),
                  ),
                );
  }

  Widget _buildTimeZoneLayerOne(int index) {
    return Container(
      height: Get.height/812*47,
      width: Get.width/375*102,
      decoration: BoxDecoration(
        color: blue500,
        borderRadius: BorderRadius.circular(8)
      ),
      child: Column(
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: _buildRangeText(timeRanges[index].startHour),
            ),
          ),
          Expanded(
            child: _buildRangeText(timeRanges[index].endHour),
          )
          
        ],
      ),
    );
  }


  _buildButton() {
    if (_tpaNameController.text !=null && timeRanges.length>0 && _currentSelectedSize != null  && _tpaNameController.text != "") {
      return Button.active(text: "Kaydet", onPressed: _saveTpa);
    }else{
      return Button.passive(text: "Kaydet", onPressed: null);
    }
  }

  _buildRangeText(h){
    
    String _hour;
    String _minute = "00";
    if (h < 10) {
      _hour = "0"+h.toString();
    }else{
      _hour = h.toString();
    }

    

    return Text(_hour+":"+_minute,
    style: TextStyle(
      fontFamily: "SF Pro Text",
      fontSize: 12,
      fontWeight: FontWeight.w400,color: white
    ),
    );
  }

  Widget _buildTimePicker() {
    List<String> saatler = List<String>.generate(24, (index) {
      String hour;

      if (index < 10) {
        hour = "0" + index.toString();
      } else {
        hour = index.toString();
      }

      return hour;
    });
    
    saatler.removeWhere((element) => element == null);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
          decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: gray600)),
          child: ListTile(
            onTap: () {
              showModalBottomSheet(

                shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
                  context: context,
                  builder: (context) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10)
                      ),
                      height: Get.height / 812 * 300,
                      child: _bottomSheetColumn(context, saatler),
                    );
                  });
            },
            title: Text(
              "Kiralama Saat Aralığı",
              style: TextStyle(
                  color: gray900,
                  fontFamily: "SF Pro Text",
                  fontWeight: FontWeight.w400,
                  fontSize: 17),
            ),
          )),
    );
  }

  Column _bottomSheetColumn(
      BuildContext context, List<String> saatler) {
    return Column(
      children: [
        Spacer(
          flex: 1,
        ),
        Expanded(
          flex: 1,
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    selectedHourStart = DateTime.now().hour;
                    selectedHourEnd = DateTime.now().hour;
                    selectedMinuteStart = DateTime.now().minute;
                    selectedMinuteStart = DateTime.now().minute;

                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      "İptal",
                      style: TextStyle(
                          color: gray900,
                          fontSize: 17,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    timeRanges.add(TimeRange(
                        startHour: selectedHourStart,
                        endHour: selectedHourEnd,
                        avaliable: true
                        ));
                    setState(() {});
                    timeRanges.forEach((element) {print(element.startHour);});
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      "Onayla",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: blue500,
                          fontSize: 17),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        Spacer(
          flex: 1,
        ),
        Expanded(
          flex: 1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                child: Text(
                  "Başlangıç Saati",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
              ),
              Container(
                child: Text(
                  "Bitiş Saati",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 9,
          child: Container(
            width: Get.width,
            child: Row(
              children: [
                _buildColumn1(saatler),
                Text(":"),
                _buildMidColumn(),
                Text("ile"),
                _buildColumn3(saatler),
                Text(":"),
                _buildMidColumn(),
              ],
            ),
          ),
        )
      ],
    );
  }

  _buildMidColumn(){
    return Expanded(child: Center(child: Text("00",style: TextStyle(
      fontSize: 17,
    ),)));
  }

  Expanded _buildColumn1(saatler) {
    return Expanded(
      child: CupertinoPicker(
        itemExtent: 64,
        diameterRatio: 0.7,
        children: modelBuilder(saatler),
        onSelectedItemChanged: (index) {
          selectedHourStart = int.parse(saatler[index]);
        },
      ),
    );
  }

  Expanded _buildColumn3(saatler) {
    return Expanded(
      child: CupertinoPicker(
        itemExtent: 64,
        diameterRatio: 0.7,
        children: modelBuilder(saatler),
        onSelectedItemChanged: (index) {
          selectedHourEnd = int.parse(saatler[index]);
        },
      ),
    );
  }


  modelBuilder(values) {
    List<Widget> _widgetList = List<Widget>.generate(values.length, (index) {
      return Center(
        child: Text(values[index].toString()),
      );
    });
    return _widgetList;
  }

  _saveTpa()async{
    _showLoading();

    var _res = await _dataService.addTpa( 
      parkId: park.id, 
      tpaName: _tpaNameController.text,
      hourlyPrice: 0,
      maxCarSize: _currentSelectedSize.toString() );

    if(_res.parkId!=null){
      Get.to(()=>ProfileScreen(),fullscreenDialog: true);
    }else{
      Navigator.pop(context);
    }
  }

  void _backButtonFunc() {
    Get.to(() => ProfileScreen());
  }

  void _showLoading()async{

    Future.delayed(Duration.zero,(){
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
    });
  }

}
