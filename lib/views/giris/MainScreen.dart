import 'dart:typed_data';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gesk_app/core/colors.dart';
import 'package:gesk_app/core/funcs/triangleCreator.dart';
import 'package:gesk_app/models/park.dart';
import 'package:gesk_app/services/markerCreator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

  var width = Get.width/375;
  var height = Get.height/812;

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {

  List<Marker> markers = [];

  CameraPosition cameraPosition = CameraPosition(target: LatLng(40.355499, 27.971991), zoom: 17);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Stack(
          children: <Widget>[
            GoogleMap(
              mapType: MapType.terrain,
              initialCameraPosition: cameraPosition,
              markers: markers.toSet(),
            ),
          ],
        ),
    );
  }

  @override
  void initState() {
    super.initState();

    MarkerGenerator(markerWidgets(), (bitmaps) {
      setState(() {
        markers = mapBitmapsToMarkers(bitmaps);
      });
    }).generate(context);
  }

  List<Marker> mapBitmapsToMarkers(List<Uint8List> bitmaps) {
    List<Marker> markersList = [];
    bitmaps.asMap().forEach((i, bmp) {
      final park = parks[i];
      markersList.add(Marker(
          onTap: (){
            setState(() {
                          cameraPosition = CameraPosition(target: park.position,zoom: 18);
                        });
          },
          markerId: MarkerId(park.name),
          position: park.position,
          icon: BitmapDescriptor.fromBytes(bmp)));
    });
    return markersList;
  }
}

// Example of marker widget
Widget _getMarkerWidget(String price,Status status,bool isWithElectiricity){
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
    child: Container(
    width: width*64,
    height: height*70,
    child: Stack(
      children: [ 
        Padding(
          padding: const EdgeInsets.only(top:8.0,right: 8,left: 8,bottom: 1),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children:[
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.00),
                    color: _markerColor(status),
                  ),
                  
                    width: width*48,
                    height: height*48,
                    child: Stack(
                        children:[
                            Positioned.fill(
                                child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                        "$price₺",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 17,
                                            fontFamily: "SF Pro Text",
                                            fontWeight: FontWeight.w600,
                                        ),
                                    ),
                                ),
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
                    height: height*7,
                    width: width*10,
                  ),),
                )
            ],
      ),
        ),
      Align(
        alignment: Alignment.topRight,
        child: _electricityIcon(isWithElectiricity)
      ),
      ]
    ),
)
  );
}

// Example of backing data
List<Park> parks = [
  Park("Bandırma", LatLng(40.355499, 27.971991),18,Status.admin,true),
  Park("MaCafe", LatLng(40.357547, 27.970377),18,Status.selected,false),
  Park("OttoSocialHouse", LatLng(40.357235, 27.971058),18,Status.deselected,false),
];

List<Widget> markerWidgets() {
  return parks.map((c) => _getMarkerWidget(c.price.toString(),c.status,c.isWeithElectricity)).toList();
}

Color _markerColor(Status status){
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

Widget _electricityIcon(bool active){
  if (active) {
    return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: white
              ),
              width: width*24,
              height: height*24,
              child: Icon(CupertinoIcons.bolt_circle,color: blue500,),
            );
  }else{
    return SizedBox();
  }
}



