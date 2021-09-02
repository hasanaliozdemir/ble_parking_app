import 'dart:async';
import 'dart:typed_data';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:gesk_app/bloc/app_bloc.dart';
import 'package:gesk_app/core/components/bottomBar.dart';
import 'package:gesk_app/core/components/customSwitch.dart';
import 'package:gesk_app/core/components/parkCard.dart';
import 'package:gesk_app/core/components/searchBar.dart';
import 'package:gesk_app/data_models/place.dart';
import 'package:gesk_app/views/giris/filter.dart';
import 'package:gesk_app/views/giris/park_detail.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gesk_app/core/colors.dart';
import 'package:gesk_app/core/funcs/triangleCreator.dart';
import 'package:gesk_app/models/park.dart';
import 'package:gesk_app/services/markerCreator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

var _electricitySelected = false.obs;
var width = Get.width / 375;
var height = Get.height / 812;


class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  int _selectedIndex = 0;
  int _caroselIndex = 0;
  final _index = 0;

  CarouselController carouselController = CarouselController();
  Completer<GoogleMapController> _mapcontroller = Completer();
  List<Marker> _markers = [];


  CameraPosition cameraPosition =
      CameraPosition(target: LatLng(40.355499, 27.971991), zoom: 17);

  StreamSubscription locationSubscription;
  
  @override
  void initState() { 
    final applicationBloc = Provider.of<AppBloc>(context,listen: false);
    locationSubscription =  applicationBloc.selectedLocation.stream.asBroadcastStream()
    .listen((place) {
      if (place != null) {
        _getToPlace(place);
      }
    });

    MarkerGenerator(markerWidgets(), (bitmaps) {
      setState(() {
        _markers = mapBitmapsToMarkers(bitmaps);
      });
    }).generate(context);
    super.initState();
    
  }

  @override
  void dispose() { 
    final applicationBloc = Provider.of<AppBloc>(context,listen: false);
    applicationBloc.dispose();
    applicationBloc.selectedLocation.close();
    locationSubscription.cancel();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    
    
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
            child: Stack(
              children: <Widget>[
                GoogleMap(
                  onMapCreated: (GoogleMapController controller) {
                    _mapcontroller.complete(controller);
                  },
                  myLocationEnabled: true,
                  mapType: MapType.terrain,
                  mapToolbarEnabled: false,
                  initialCameraPosition: cameraPosition,
                  markers: _markers.toSet(),
                  myLocationButtonEnabled: false,
                ),
              ],
            ),
          ),
          _buildSearchBar(context),
          Container(
            alignment: Alignment.bottomCenter,
            padding: EdgeInsets.only(bottom: 24),
            child: CarouselSlider.builder(
              carouselController: carouselController,
              itemCount: _markers.length ?? 0,
              options: CarouselOptions(
                enableInfiniteScroll: false,
                onPageChanged: (index, reason) async{
                  setState(() {
                    _caroselIndex = index;
                    _selectedIndex = _caroselIndex;
                  });
                  final GoogleMapController _controller = await _mapcontroller.future;
                  _controller.animateCamera(CameraUpdate.newCameraPosition(
                      CameraPosition(
                          target: LatLng(
                              _parks[index].latitude, _parks[index].longitude),
                          zoom: 16)));
                },
                height: h * 128,
              ),
              itemBuilder: (context, itemIndex, pageIndex) {
                return Container(
                  height: h * 128,
                  width: w * 264,
                  child: GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        isScrollControlled: true,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          backgroundColor: Colors.white,
                          context: context,
                          builder: (context) {
                            return ParkDetail(
                              park: _parks[itemIndex],
                            );
                          });
                    },
                    child: ParkCard(park: _parks[itemIndex],
                        ),
                  ),
                );
              },
            ),
          ),
          Positioned(
              top: MediaQuery.of(context).padding.top + (h * 108),
              left: w * 300,
              child: Container(
                  width: w * 56,
                  height: h * 31,
                  child: CustomSwitch(
                    value: _electricitySelected,
                    activeToggleColor: white,
                    activeIcon: Icon(
                      CupertinoIcons.bolt_fill,
                      color: blue500,
                    ),
                    passiveIcon: Icon(
                      CupertinoIcons.bolt_fill,
                      color: white,
                    ),
                    passiveToggleColor: blue400,
                    func: () {
                      MarkerGenerator(markerWidgets(), (bitmaps) {
                        setState(() {
                          _markers = mapBitmapsToMarkers(bitmaps);
                        });
                      }).generate(context);
                    },
                  )))
        ],
      ),
      bottomNavigationBar: BottomBar(
        index: _index,
      ),
    );
  }


  List<Marker> mapBitmapsToMarkers(List<Uint8List> bitmaps) {
    List<Marker> _markersList = [];
    bitmaps.asMap().forEach((i, bmp) {
      final park = _parks[i];
      _markersList.add(Marker(
          onTap: () async{
            final GoogleMapController _controller = await _mapcontroller.future;
            _controller
              ..animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
                  target: LatLng(park.latitude, park.longitude), zoom: 16)));
            setState(() {
              _selectedIndex =
                  _parks.indexWhere((element) => element.id == park.id);
            });
            carouselController.animateToPage(_selectedIndex,
                duration: Duration(seconds: 1));
          },
          markerId: MarkerId(park.id.toString()),
          position: LatLng(park.latitude, park.longitude),
          icon: BitmapDescriptor.fromBytes(bmp)));
    });
    return _markersList;
  }

  Future<void> _getToPlace(Place place) async{
    final GoogleMapController _controller = await _mapcontroller.future;
  _controller.animateCamera(
    CameraUpdate.newCameraPosition(
      CameraPosition(target: LatLng(place.geometry.location.lat,place.geometry.location.lng),zoom: 17)
    )
  );
}
}

// Example of marker widget
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

// Example of backing data
List<Park> _parks = [
  Park(
    name: "Ma Cafe",
    location: "Bandırma",
    latitude: 40.355499,
    longitude: 27.971991,
    price: 18.00,
    status: Status.admin,
    isWithCam: true,
    filledParkSpace: 4,
    id: 0,
    isWithElectricity: true,
    isWithSecurity: true,
    point: 4.5,
    parkSpace: 6,
    isClosedPark: true,
    imageUrls: [
      "https://images.unsplash.com/photo-1552519507-da3b142c6e3d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1000&q=80",
      "https://images.pexels.com/photos/112460/pexels-photo-112460.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
    ]
  ),
];

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

List<Widget> markerWidgets() {
  return _parks
      .map((c) => _getMarkerWidget(c.price, c.status, c.isWithElectricity))
      .toList();
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
  if (active && _electricitySelected.value) {
    return Container(
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(24),
          border: Border.all(color: gray400),
          color: white),
      width: width * 24,
      height: height * 24,
      child: Icon(
        CupertinoIcons.bolt_fill,
        color: blue500,
        size: 16,
      ),
    );
  } else {
    return SizedBox();
  }
}

_buildSearchBar(context) {
  return Positioned(
      top: MediaQuery.of(context).padding.top + (h * 36),
      left: 16,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: Get.height/812*56,
            width: Get.width/375*279,
            child: SearchBar()),
          SizedBox(
            width: 8,
          ),
          Container(
            width: Get.height/812*56,
            height: Get.height/812*56,
            decoration: BoxDecoration(
                color: white,
                boxShadow: [
                  BoxShadow(
                    color: Color(0x33000000),
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
                borderRadius: BorderRadius.circular(8)),
            child: IconButton(
              icon: Icon(CupertinoIcons.slider_horizontal_3,color: blue500,size: 22,), 
              onPressed: (){
                showModalBottomSheet(
                        isScrollControlled: true,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          backgroundColor: Colors.white,
                          context: context,
                          builder: (context) {
                            return FilterDetail();
                          });
              }
              )
          )
        ],
      ));

      
}



Future<Uint8List> getPerson(context) async {
  ByteData byteData =
      await DefaultAssetBundle.of(context).load("assets/icons/person2.svg");
  return byteData.buffer.asUint8List();
}
