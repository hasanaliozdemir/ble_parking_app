import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:gesk_app/core/colors.dart';
import 'package:gesk_app/core/components/button.dart';
import 'package:gesk_app/core/components/dateSelector.dart';
import 'package:gesk_app/core/funcs/triangleCreator.dart';
import 'package:gesk_app/models/park.dart';
import 'package:gesk_app/services/markerCreator.dart';
import 'package:gesk_app/views/giris/MapScreen.dart';
import 'package:gesk_app/views/reservation/timeRange.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

class DatePickScreen extends StatefulWidget {
  final Park park;

  const DatePickScreen({Key key, this.park}) : super(key: key);

  @override
  _DatePickScreenState createState() => _DatePickScreenState(park);
}

class _DatePickScreenState extends State<DatePickScreen> {
  List<Marker> _markers = [];
  final Park _park;

  DateTime now = DateTime.now();
  final DateFormat dayFormatter = DateFormat('yyyy.MM.dd');
  DateTime selectedDay = DateTime.now();
  var selectedDayString = "Tarih".obs;
  var _startDay;
  var _endDay;
  List<DateTime> _activeDays = List<DateTime>();

  int index = 0;

  

  _DatePickScreenState(this._park);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).padding.top,
          ),
          Spacer(
            flex: 22,
          ),
          Expanded(flex: 44, child: _buildBackButton()),
          Spacer(
            flex: 16,
          ),
          Expanded(flex: 290, child: _buildCard()),
          Spacer(
            flex: 24,
          ),
          Expanded(
            flex: 50,
            child: _buildDatePick(),
          ),
          Spacer(
            flex: 32,
          ),
          Spacer(
            flex: 24,
          ),
          Expanded(flex: 50, child: SizedBox()),
          Spacer(
            flex: 240,
          ),
          SizedBox(
            height: MediaQuery.of(context).padding.bottom,
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _parseString();
    MarkerGenerator(markerWidget(), (bitmaps) {
      setState(() {
        _markers = mapBitmapsToMarkers(bitmaps);
      });
    }).generate(context);
  }

  List<Marker> mapBitmapsToMarkers(List<Uint8List> bitmaps) {
    List<Marker> _markersList = [];
    bitmaps.asMap().forEach((i, bmp) {
      final park = _park;
      _markersList.add(Marker(
          markerId: MarkerId(park.id.toString()),
          position: LatLng(park.latitude, park.longitude),
          icon: BitmapDescriptor.fromBytes(bmp)));
    });
    return _markersList;
  }

  Widget _getMarkerWidget(double price, Status status, bool isWithElectiricity) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        child: Container(
          width: width * 64,
          height: height * 70,
          child: Stack(children: [
            Padding(
              padding:
                  const EdgeInsets.only(top: 8.0, right: 8, left: 8, bottom: 1),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.00),
                      color: _markerColor(status),
                    ),
                    width: width * 48,
                    height: height * 48,
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: Align(
                              alignment: Alignment.center,
                              child: _buildMarkerText(status, price)),
                        ),
                      ],
                    ),
                  ),
                  RotatedBox(
                    quarterTurns: 2,
                    child: CustomPaint(
                      painter: TrianglePainter(
                        strokeColor: _markerColor(status),
                        strokeWidth: 10,
                        paintingStyle: PaintingStyle.fill,
                      ),
                      child: Container(
                        height: height * 7,
                        width: width * 10,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Align(
                alignment: Alignment.topRight,
                child: _electricityIcon(isWithElectiricity)),
          ]),
        ));
  }

  Widget _buildMarkerText(Status status, price) {
    if (status == Status.owner) {
      return Icon(
        CupertinoIcons.map_pin_ellipse,
        color: white,
      );
    } else {
      return Text(
        price.truncate().toString() + "₺",
        style: TextStyle(
          color: Colors.white,
          fontSize: 17,
          fontFamily: "SF Pro Text",
          fontWeight: FontWeight.w600,
        ),
      );
    }
  }

  List<Widget> markerWidget() {
    return [_getMarkerWidget(widget.park.price, Status.admin, widget.park.isWithElectricity)];
  }

  Color _markerColor(Status status) {
    switch (status) {
      case Status.deselected:
        return blue200;
        break;
      case Status.selected:
        return blue500;
        break;
      case Status.admin:
        return yellow400;
        break;
      case Status.deselected:
        return gray800;
        break;
      case Status.owner:
        return blue800;
        break;

      default:
        return blue500;
    }
  }

  Widget _electricityIcon(bool active) {
    if (active) {
      return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16), color: white),
        width: width * 24,
        height: height * 24,
        child: Icon(
          CupertinoIcons.bolt_circle,
          color: blue500,
        ),
      );
    } else {
      return SizedBox();
    }
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

  Widget _buildCard() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
            color: gray600, borderRadius: BorderRadius.circular(16)),
        child: Column(
          children: [
            Expanded(flex: 36, child: _buildParkTextRow()),
            Expanded(
              flex: 204,
              child: Container(
                child: _buildMap(),
              ),
            )
          ],
        ),
      ),
    );
  }

  Row _buildParkTextRow() {
    return Row(
      children: [
        Spacer(
          flex: 16,
        ),
        Expanded(
          flex: 251,
          child: Text(
            widget.park.name,
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
          ),
        ),
        Spacer(
          flex: 8,
        ),
        Expanded(
          child: Text(
            widget.park.price.toString() + " ₺",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
            textAlign: TextAlign.right,
          ),
          flex: 56,
        ),
        Spacer(
          flex: 8,
        )
      ],
    );
  }

  Widget _buildMap() {
    return GoogleMap(
      markers: _markers.toSet(),
      initialCameraPosition: CameraPosition(
          target: LatLng(widget.park.latitude, widget.park.longitude),
          zoom: 17),
      myLocationButtonEnabled: false,
      myLocationEnabled: true,
      tiltGesturesEnabled: false,
      zoomGesturesEnabled: false,
      rotateGesturesEnabled: false,
      scrollGesturesEnabled: false,
    );
  }

  Widget _buildDatePick() {
    print(_startDay.toString()+"  burda başlıyor");
    print(_endDay.toString()+"  burda bitiyor");
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: gray600)),
          child: ListTile(
            onTap: () {
              showModalBottomSheet(context: context, builder: (context){
                return DateSelector(days: _activeDays,park: _park,);
            });
              
            },
            title: Text(
              selectedDayString.value,
              style: TextStyle(
                  color: black,
                  fontFamily: "SF Pro Text",
                  fontWeight: FontWeight.w400,
                  fontSize: 17),
            ),
            leading: Icon(
              CupertinoIcons.calendar,
              color: blue500,
            ),
          )),
    );
  }

  

  
  Widget _buildButton() {
    if (selectedDay.day !=null && selectedDayString.value != "Tarih") {
      return Container(
      child: Button.active(text: "Tekil Park Alanı Ara", onPressed: _searchReservation),
    );
    } else {
      return Container(
      child: Button.passive(text: "Tekil Park Alanı Ara", onPressed: null),
    );
    }
  }

  modelBuilder(values) {
    List<Widget> _widgetList = List<Widget>.generate(values.length, (index) {
      return Center(
        child: Text(values[index].toString()),
      );
    });
    return _widgetList;
  }

  _backButtonFunc() {
    Get.back();
  }

  _parseString(){
    print(_park.avaliableTime);
    List<String> _ref = _park.avaliableTime.split(",");
    _ref.removeAt(0);
    List<String> _days = List<String>();
    _ref.forEach((element) {
      var _part = element.split("-");
      _days.add(_part[0]);
    });

    List<String> _removedId =List<String>();

    _days.forEach((element) { 
      var _ref =element.split("|");
      _removedId.add(_ref[1]); 
      });
    
    List<DateTime> _dateTimes = List<DateTime>();

    _removedId.forEach((element) {
      _dateTimes.add( DateFormat("yyyy.MM.dd").parse(element) );
     });
  
    _dateTimes.sort((a, b) => a.compareTo(b));

    _activeDays = _dateTimes;
    _activeDays.removeWhere((element) => 0>=element.add(Duration(days: 1)).compareTo(DateTime.now()));
  }

  _searchReservation(){
    var _selectedDay = selectedDay;
    
    

    Get.to(()=>TimeRangePage(date: _selectedDay,park: _park));

  }
}
