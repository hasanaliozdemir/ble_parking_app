import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gesk_app/backend/dataService.dart';
import 'package:gesk_app/core/colors.dart';
import 'package:gesk_app/core/components/button.dart';
import 'package:gesk_app/core/funcs/triangleCreator.dart';
import 'package:gesk_app/data_models/time_range.dart';
import 'package:gesk_app/models/park.dart';
import 'package:gesk_app/models/tpa.dart';
import 'package:gesk_app/services/markerCreator.dart';
import 'package:gesk_app/views/giris/MapScreen.dart';
import 'package:gesk_app/views/reservation/done.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TimeRangePage extends StatefulWidget {
  final Park park;
  final DateTime date;

  const TimeRangePage({Key key, this.park, this.date}) : super(key: key);

  @override
  _TimeRangePageState createState() => _TimeRangePageState(
        park,
        date,
      );
}

class _TimeRangePageState extends State<TimeRangePage> {
  final Park _park;
  final DateTime _date;

  List<Marker> _markers = [];
  List<Tpa> _tpas = List<Tpa>();
  List<TimeRange> _timeRanges = List<TimeRange>();
  var _count = 0;
  var _startTime = 0;
  var _endTime = 0;

  DataService _dataService = DataService();

  @override
  void initState() {
    super.initState();

    _getTimes();
    
    MarkerGenerator(markerWidgets(), (bitmaps) {
      setState(() {
        _markers = mapBitmapsToMarkers(bitmaps);
      });
    }).generate(context);
  }

  _TimeRangePageState(this._park, this._date);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                flex: 44,
                child: _buildBackButton(),
              ),
              Spacer(
                flex: 16,
              ),
              Expanded(
                flex: 340,
                child: _buildCard(),
              ),
              Spacer(
                flex: 16,
              ),
              Expanded(
                flex: 24,
                child: _buildUnderMapTitle(),
              ),
              Spacer(
                flex: 48,
              ),
              Expanded(
                flex: 216,
                child: _buildList(),
              ),
              Spacer(
                flex: 12,
              ),
              Expanded(
                flex: 56,
                child: _buildButton(),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButton() {
    if (_timeRanges.any((element) => element.selected == true)) {
      return Button.active(text: "Alanı Kirala", onPressed: _rentTpa);
    } else {
      return Button.passive(text: "Alanı Kirala", onPressed: null);
    }
  }

  ListView _buildList() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: (_tpas == null) ? 0 : _tpas.length,
      itemBuilder: (context, index) {
        return Container(
          height: Get.height / 812 * 100,
          child: Column(
            children: [
              Expanded(
                flex: 22,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      _tpas[index].tpaName,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 17,
                        fontFamily: "SF Pro Text",
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
              Spacer(
                flex: 16,
              ),
              Expanded(
                flex: 36,
                child: _buildRowModel(_tpas[index]),
              ),
              Spacer(
                flex: 36,
              )
            ],
          ),
        );
      },
    );
  }

  Widget _buildRowModel(Tpa tpa) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: tpa.avaliableTimes.length,
      itemBuilder: (context, index) {
        var _newtimeRange = TimeRange(
          uniqueId: tpa.tapId.toString() + index.toString(),
          startHour: tpa.avaliableTimes[index],
          selected: false,
          tpaId: tpa.tapId
        );

        _timeRanges.add(_newtimeRange);

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: GestureDetector(
            onTap: () => onTapFunc(_newtimeRange.uniqueId),
            child: Container(
              width: Get.width / 375 * 100,
              height: Get.height / 812 * 36,
              decoration: BoxDecoration(
                  color: fixColor(_newtimeRange.uniqueId),
                  borderRadius: BorderRadius.circular(8)),
              child: Center(
                child: Text(
                  fixRowString(tpa.avaliableTimes[index]),
                  style: TextStyle(color: white),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  fixRowString(int startTime) {
    String _first;
    String _second;

    if (startTime < 10) {
      _first = "0" + startTime.toString();
    } else {
      _first = startTime.toString();
    }

    if (startTime == 23) {
      _second = "00";
    } else {
      if (startTime + 1 < 10) {
        _second = "0" + (startTime + 1).toString();
      } else {
        _second = (startTime + 1).toString();
      }
    }

    return _first + ":00-" + _second + ":00";
  }

  fixColor(String uniqId) {
    var _refIndex =
        _timeRanges.indexWhere((element) => element.uniqueId == uniqId);
    var _ref = _timeRanges[_refIndex];
    if (_ref.selected == true) {
      return blue500;
    } else {
      return blue300;
    }
  }

  onTapFunc(String uniqId) {
    var _refIndex =
        _timeRanges.indexWhere((element) => element.uniqueId == uniqId);
    var _ref = _timeRanges[_refIndex];



    if (_ref.selected == true) {
      setState(() {
        _timeRanges[_refIndex].selected = false;
        _count = _count -1;
      });
    } else {
      if (_count==0) {
        setState(() {
          _timeRanges[_refIndex].selected = true;
          _count = _count + 1;

        });
      } else {
        if (_count == 1) {
          var _selected = _timeRanges.where((element) => element.selected).first;
          if (_selected.tpaId != _ref.tpaId) {
            Get.snackbar("Uyarı", "Seçilen zaman aralıkları aynı Tekil Park Alanına ait olmalıdır");
          } else {
            if (_selected.startHour == _ref.startHour+1 || _selected.startHour == _ref.startHour-1) {
            setState(() {
              _timeRanges[_refIndex].selected = true;
              _count = _count + 1;
            });
          } else {
            Get.snackbar("Uyarı", "Seçilen zaman aralıkları bağlantılı olmalıdır");
          }
          }
        } else {
          Get.snackbar("Uyarı", "En fazla iki zaman aralığı seçebilirsiniz");
        }
      }
    }

  }

  setStartEnd() {
    var _ref = _timeRanges.where((element) => element.selected);

    

    _startTime = _ref.first.startHour;
    _endTime = _startTime + 1;
    _ref.forEach((element) {
      element.endHour = element.startHour + 1;

      if (element.startHour < _startTime) {
        _startTime = element.startHour;
      }

      if (element.endHour > _endTime) {
        _endTime = element.endHour;
      }
    });
  }

  Padding _buildUnderMapTitle() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "${(_date.day < 10) ? "0" + _date.day.toString() : _date.day.toString()}.${(_date.month < 10) ? "0" + _date.month.toString() : _date.month.toString()}.${_date.year}",
            style: TextStyle(
              color: Colors.black,
              fontSize: 13,
              fontFamily: "SF Pro Text",
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            (_count==0)?"":"$_startTime.00-$_endTime.00", //TODO: Burayı ayarla
            style: TextStyle(
              color: Colors.black,
              fontSize: 13,
              fontFamily: "SF Pro Text",
              fontWeight: FontWeight.w600,
            ),
          )
        ],
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

  Widget markerWidget() {
    return _getMarkerWidget(0, Status.owner, false);
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

  Widget _getMarkerWidget(
      double price, Status status, bool isWithElectiricity) {
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

  _backButtonFunc() {
    Get.back();
  }

  _getTimes() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    var _userId = _prefs.getInt("userId");

    var _selectedDayString = DateFormat("yyyy.MM.dd").format(_date);

    List<Tpa> _ref = await _dataService.getFakeAvaliableTpas(
        _park.id, _userId, _selectedDayString);

    _tpas = _ref;
    setState(() {
          
        });
  }

  _rentTpa() async{  
    _showLoading();  
    var _selectedOnes = _timeRanges.where((element) => element.selected);
    var _prefs = await SharedPreferences.getInstance();

    var _userId = _prefs.getInt("userId");

    var dayString = "${_date.year}.${(_date.month<10)? "0"+_date.month.toString() : _date.month}.${(_date.day<10)? "0"+_date.day.toString() : _date.day}";

    TimeRange _totalTime;

    List<TimeRange> _ranges = List<TimeRange>();

    _selectedOnes.forEach((element) { 
      _ranges.add(element);
    });

    _ranges.sort((a,b)=>a.startHour.compareTo(b.startHour));

    _totalTime.startHour = _ranges.first.startHour;
    _totalTime.endHour = _ranges.last.endHour;
    _totalTime.tpaId = _ranges.first.tpaId;

  var _res = await _dataService.setReserved(
        parkId: _park.id,
        tpaId: _totalTime.tpaId,
        userId: _userId,
        plate: "hasan123",
        datetime: "$dayString-${_totalTime.startHour} $dayString-${_totalTime.endHour}"
      );

    var _refTpa = _tpas.where((element) => element.tapId == _totalTime.tpaId);

    if (_res!=true) {
      Navigator.pop(context);
      Get.snackbar("Hata", "Bir hata oluştu lütfen tekrar deneyin");
    } else {
      Navigator.pop(context);
      Get.to(()=>DoneReservationPage(park: _park,date: _date,start: _totalTime.startHour,end: _totalTime.endHour,tpa: _refTpa.first,),fullscreenDialog: true);
    }

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
