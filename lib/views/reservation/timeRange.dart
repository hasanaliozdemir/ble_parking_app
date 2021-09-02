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
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TimeRangePage extends StatefulWidget {
  final Park park;
  final DateTime date;
  const TimeRangePage({Key key, this.park, this.date}) : super(key: key);

  @override
  _TimeRangePageState createState() => _TimeRangePageState(park, date);
}

class _TimeRangePageState extends State<TimeRangePage> {
  final Park _park;
  final DateTime _date;
  List<Marker> _markers = [];
  List<Tpa> _tpas = List<Tpa>();
  var _selectedTimeRange = TimeRange().obs;

  DataService _dataService = DataService();

  @override
  void initState() {
    super.initState();

    _getTpas();

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
              Spacer(flex: 12,),
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

  Widget _buildButton(){
    if (_selectedTimeRange.value.startHour==null) {
      return Button.passive(text: "Alanı Kirala", onPressed: null);
    }else{
      return Button.active(text: "Alanı Kirala", onPressed: _rentTpa);
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
                          child: Text(
                            _tpas[index].tpaName,
                            style: TextStyle(
                              fontSize: 17,
                              fontFamily: "SF Pro Text",
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Spacer(
                          flex: 16,
                        ),
                        Expanded(
                          flex: 36,
                          child: _buildRowModel(),
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

  Widget _buildRowModel(){
    return Container();
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
            "19.00-20.00", //TODO: Burayı ayarla
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
    Get.to(() => MapScreen());
  }

  _getTpas() async {
    _tpas = await _dataService.getTpas(_park.id);
  }

  _rentTpa(){
    print("rent");
  }
}
