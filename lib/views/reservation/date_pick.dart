import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:gesk_app/core/colors.dart';
import 'package:gesk_app/core/components/button.dart';
import 'package:gesk_app/core/funcs/triangleCreator.dart';
import 'package:gesk_app/models/park.dart';
import 'package:gesk_app/services/markerCreator.dart';
import 'package:gesk_app/views/giris/MapScreen.dart';
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
  var selectedHourString = "SS:DD - SS:DD".obs;

  int selectedHourStart;
  int selectedHourEnd;

  int selectedMinuteStart;
  int selectedMinuteEnd;

  int index = 0;

  _DatePickScreenState(this._park);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          Expanded(flex: 240, child: _buildCard()),
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
          Expanded(
            flex: 50,
            child: _buildTimePicker(),
          ),
          Spacer(
            flex: 24,
          ),
          Expanded(flex: 50, child: _buildButton()),
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

    MarkerGenerator(markerWidgets(), (bitmaps) {
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

  Widget markerWidget() {
    return _getMarkerWidget(0, Status.owner, false);
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
            color: gray900, borderRadius: BorderRadius.circular(16)),
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: gray600)),
          child: ListTile(
            onTap: () {
              DatePicker.showDatePicker(context,
                  showTitleActions: true,
                  minTime: DateTime.now(),
                  maxTime: DateTime.now().add(Duration(hours: 24 * 14)),
                  onChanged: (date) {
                print('change $date');
              }, onConfirm: (date) {
                setState(() {
                  selectedDay = date;
                  selectedDayString.value = dayFormatter.format(selectedDay);
                });
              }, currentTime: DateTime.now(), locale: LocaleType.tr);
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

  Widget _buildTimePicker() {
    List<String> saatler = List<String>.generate(24, (index) {
      String hour;

      if (selectedDay.day == DateTime.now().day) {
        if (index >= selectedDay.hour) {
          if (index < 10) {
            hour = "0" + index.toString();
          } else {
            hour = index.toString();
          }
        }
      } else {
        if (index < 10) {
          hour = "0" + index.toString();
        } else {
          hour = index.toString();
        }
      }

      return hour;
    });
    List<String> dakikalar = List<String>.generate(60, (index) {
      String minute;
      if (index % 5 == 0) {
        if (selectedDay.day == DateTime.now().day) {
          if (index >= selectedDay.minute) {
            if (index < 10) {
              minute = "0" + index.toString();
            } else {
              minute = index.toString();
            }
          }
        } else {
          if (index < 10) {
            minute = "0" + index.toString();
          } else {
            minute = index.toString();
          }
        }
      }

      return minute;
    });

    dakikalar.removeWhere((element) => element == null);
    saatler.removeWhere((element) => element == null);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: gray600)),
          child: ListTile(
            onTap: () {
              showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return Container(
                      height: Get.height / 812 * 300,
                      child: _bottomSheetColumn(context, saatler, dakikalar),
                    );
                  });
            },
            title: Text(
              selectedHourString.value,
              style: TextStyle(
                  color: black,
                  fontFamily: "SF Pro Text",
                  fontWeight: FontWeight.w400,
                  fontSize: 17),
            ),
            leading: Icon(
              CupertinoIcons.clock_fill,
              color: blue500,
            ),
          )),
    );
  }

  Column _bottomSheetColumn(
      BuildContext context, List<String> saatler, List<String> dakikalar) {
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
                    setState(() {
                                          selectedHourString.value = "SS:DD - SS:DD";
                                        });
                    Navigator.pop(context);
                  } ,
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
                    setState(() {
                      selectedHourString.value = selectedHourStart.toString() +
                          ":" +
                          selectedMinuteStart.toString() +
                          " - " +
                          selectedHourEnd.toString() +
                          ":" +
                          selectedMinuteEnd.toString();
                    });
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
                _buildColumn2(dakikalar),
                Text("ile"),
                _buildColumn3(saatler),
                Text(":"),
                _buildColumn4(saatler),
              ],
            ),
          ),
        )
      ],
    );
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

  Expanded _buildColumn2(dakikalar) {
    return Expanded(
      child: CupertinoPicker(
        itemExtent: 64,
        diameterRatio: 0.7,
        children: modelBuilder(dakikalar),
        onSelectedItemChanged: (index) {
          selectedMinuteStart = int.parse(dakikalar[index]);
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

  Expanded _buildColumn4(dakikalar) {
    return Expanded(
      child: CupertinoPicker(
        itemExtent: 64,
        diameterRatio: 0.7,
        children: modelBuilder(dakikalar),
        onSelectedItemChanged: (index) {
          selectedMinuteEnd = int.parse(dakikalar[index]);
        },
      ),
    );
  }

  Widget _buildButton() {
    return Container(
      child: Button.active(text: "Tekil Park Alanı Ara", onPressed: _searchReservation),
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

  _backButtonFunc() {
    Get.to(() => MapScreen());
  }

  _searchReservation(){
    var _selectedDay = selectedDay;
    var _startHour = DateTime(_selectedDay.year,_selectedDay.month,_selectedDay.day,selectedHourStart,selectedMinuteStart);
    var _endHour = DateTime(_selectedDay.year,_selectedDay.month,_selectedDay.day,selectedHourEnd,selectedMinuteEnd);

    print(_selectedDay.day);
    print(_startHour);
    print(_endHour);
  }
}
