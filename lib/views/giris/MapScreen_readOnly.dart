import 'dart:async';
import 'dart:typed_data';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:gesk_app/backend/dataService.dart';
import 'package:gesk_app/bloc/app_bloc.dart';
import 'package:gesk_app/core/components/bottomBar.dart';
import 'package:gesk_app/core/components/bottomBar_readOnly.dart';
import 'package:gesk_app/core/components/customSwitch.dart';
import 'package:gesk_app/core/components/parkCard.dart';
import 'package:gesk_app/core/components/popUp.dart';
import 'package:gesk_app/core/components/searchBar.dart';
import 'package:gesk_app/data_models/location.dart';
import 'package:gesk_app/data_models/place.dart';
import 'package:gesk_app/models/filter_modal.dart';
import 'package:gesk_app/services/distanceService.dart';
import 'package:gesk_app/views/auth/signIn.dart';
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

class MapScreenReadOnly extends StatefulWidget {
  MapScreenReadOnly({this.filterModel,this.location,this.firstParks});
  FilterModel filterModel;
  var location;
  List<Park> firstParks;
  @override
  _MapScreenReadOnlyState createState() => _MapScreenReadOnlyState(filterModel,location,firstParks);
}

class _MapScreenReadOnlyState extends State<MapScreenReadOnly> {
  var _location;
  FilterModel _filterModel;
  List<Park> _firstParks;

  int _selectedIndex = 0;
  int _caroselIndex = 0;
  final _index = 0;

  CarouselController carouselController = CarouselController();
  Completer<GoogleMapController> _mapcontroller = Completer();
  List<Marker> _markers = [];

  Location _currentPosition = Location();

  StreamSubscription locationSubscription;

  _MapScreenReadOnlyState(this._filterModel,this._location,this._firstParks);

  DataService dataService = DataService();

  @override
  void initState() {
    _parks = _firstParks;
    _currentPosition.lat = _location.latitude;
    _currentPosition.lng = _location.longitude;
    _getUserLocation();
    _distanceFix(_currentPosition.lat,_currentPosition.lng);
    final applicationBloc = Provider.of<AppBloc>(context, listen: false);
    locationSubscription = applicationBloc.selectedLocation.stream
        .asBroadcastStream()
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

    

    //listParks();
    super.initState();
  }

  void _getUserLocation() async {
    var _position = await GeolocatorPlatform.instance
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    setState(() {
      _currentPosition.lat = _position.latitude;
      _currentPosition.lng = _position.longitude;
    });

    //getParks(lat: _currentPosition.lat,lng: _currentPosition.lng); bunu açınca uzaklığa göre sıralama bozuluyor
  }

  @override
  void dispose() {
    final applicationBloc = Provider.of<AppBloc>(context, listen: false);
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
          _buildMap(),
          _buildSearchBar(context),
          Container(
            alignment: Alignment.bottomCenter,
            padding: EdgeInsets.only(bottom: 24),
            child: CarouselSlider.builder(
              carouselController: carouselController,
              itemCount: _markers.length ?? 0,
              options: CarouselOptions(
                enableInfiniteScroll: false,
                onPageChanged: (index, reason) async {
                  setState(() {
                    _caroselIndex = index;
                    _selectedIndex = _caroselIndex;
                  });
                  final GoogleMapController _controller =
                      await _mapcontroller.future;
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
                      openPopUp(context);
                      // showModalBottomSheet(
                      //     isScrollControlled: true,
                      //     shape: RoundedRectangleBorder(
                      //       borderRadius: BorderRadius.circular(10.0),
                      //     ),
                      //     backgroundColor: Colors.white,
                      //     context: context,
                      //     builder: (context) {
                      //       return ParkDetail(
                      //         park: _parks[itemIndex],
                      //       );
                      //     });
                    },
                    child: ParkCard(
                      park: _parks[itemIndex],
                    )
                  ),
                );
                
              },
            ),
          ),
          _buildSwitch(context)
        ],
      ),
      bottomNavigationBar: BottomBarRead(index: _index)
    );
  }

  Positioned _buildSwitch(BuildContext context) {
    return Positioned(
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
            )));
  }

  Container _buildMap() {
    return Container(
      child: Stack(
        children: <Widget>[
          GoogleMap(
            onMapCreated: (GoogleMapController controller) {
              _mapcontroller.complete(controller);
            },
            onCameraMove: (CameraPosition position) {
              _currentPosition.lat = position.target.latitude;
              _currentPosition.lng = position.target.longitude;
              //getParks(lat: _currentPosition.lat,lng: _currentPosition.lng);
            },
            myLocationEnabled: true,
            mapType: MapType.terrain,
            mapToolbarEnabled: false,
            initialCameraPosition: CameraPosition(
                target: LatLng(_currentPosition.lat, _currentPosition.lng),
                zoom: 17),
            markers: _markers.toSet(),
            myLocationButtonEnabled: false,
          ),
        ],
      ),
    );
  }

  List<Marker> mapBitmapsToMarkers(List<Uint8List> bitmaps) {
    List<Marker> _markersList = [];
    bitmaps.asMap().forEach((i, bmp) {
      final park = _parks[i];
      _markersList.add(Marker(
          onTap: () async {
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

  _distanceFix(lat,lng)async{
    _parks.forEach((element) async{ 
      var _dist = await DistanceService().getDistance(
        LatLng(lat, lng), 
        LatLng(element.latitude, element.longitude));
        setState(() {
                  element.distance = _dist;
                });
    });
  }

  Future<void> _getToPlace(Place place) async {
    final GoogleMapController _controller = await _mapcontroller.future;
    _controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target:
            LatLng(place.geometry.location.lat, place.geometry.location.lng),
        zoom: 17)));
  }

  Future<void> getParks({@required double lat,@required double lng})async{
    var _referance = await dataService.getNearParks(lat: lat,lng: lng);

    if (_referance is List<Park>) {
      _ref.clear();

      _referance.forEach((_element) { _ref.add(_element); });

      listParks();
    }

    
  }

  Future<void> listParks() async {
    List<Park> _ref2 = List<Park>();

    _parks.clear();
    _ref2.clear();

    if (_filterModel == null) {
      _filterModel = FilterModel(
          minPrice: 0,
          maxPrice: 100,
          isWithElectricity: false,
          isClosed: false,
          isWithCam: false,
          isWithSecurity: false);
    }

    _ref.forEach((element) {
      if ((element.price >= _filterModel.minPrice) &&
          (element.price <= _filterModel.maxPrice)) {
        _ref2.add(element);

        if (_filterModel.isClosed == true) {
          _ref2.removeWhere((closeElement) => closeElement.isClosedPark);
        }
      } else {
        
      }
    });

    _ref2.forEach((item) {_parks.add(item); });

    MarkerGenerator(markerWidgets(), (bitmaps) {
      setState(() {
        _markers = mapBitmapsToMarkers(bitmaps);
      });
    }).generate(context);
  }
}

// Example of marker widget
Widget _getMarkerWidget(double price, Status status, bool isWithElectiricity) {
  return Container(
      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      child: Container(
        width: width * 56,
        height: width * 67,
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
                  height: width * 48,
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
List<Park> _parks = List<Park>();

var _ref = [
  Park(
      ownerId: 1,
      location: "Bandırma",
      filledParkSpace: 4,
      isWithSecurity: false,
      isWithCam: false,
      isWithElectricity: false,
      isClosedPark: false,
      id: 0,
      price: 16,
      latitude: 40.355499,
      longitude: 27.971991,
      imageUrls: [],
      point: 3.5,
      status: Status.admin,
      parkSpace: 5,
      name: "16lık"),
  Park(
      ownerId: 1,
      location: "Bandırma",
      filledParkSpace: 4,
      isWithSecurity: false,
      isWithCam: false,
      isWithElectricity: false,
      isClosedPark: true,
      id: 0,
      price: 30,
      latitude: 40.355499,
      longitude: 27.971991,
      imageUrls: [],
      point: 3.5,
      status: Status.admin,
      parkSpace: 5,
      name: "30 tl lik"),
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
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
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
              //height: Get.height / 812 * 56,
              width: Get.width / 375 * 279,
              child: SearchBar()),
          SizedBox(
            width: 8,
          ),
          Container(
              width: Get.height / 812 * 56,
              height: Get.height / 812 * 56,
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
                  icon: Icon(
                    CupertinoIcons.slider_horizontal_3,
                    color: blue500,
                    size: 22,
                  ),
                  onPressed: () {

                    openPopUp(context);

                    // showModalBottomSheet(
                    //     isScrollControlled: true,
                    //     shape: RoundedRectangleBorder(
                    //       borderRadius: BorderRadius.circular(10.0),
                    //     ),
                    //     backgroundColor: Colors.white,
                    //     context: context,
                    //     builder: (context) {
                    //       return FilterDetail();
                    //     });
                  }))
        ],
      ));
}

openPopUp(context){
  showDialog(context: context, builder: (context){
    return PopUp(
      title: "Devam etmek için giriş yapmalısınız.", 
      content: "Otopark alanını kiralamak ve otopark bariyer sistemini aktif hale getirmek için üye olunuz.", 
      yesFunc: yesFunc, 
      single: true,
      icon: "assets/icons/singin-popup-people.svg",
      );
  });
}

yesFunc(){
  Get.to(()=>SignInScreen());
}

Future<Uint8List> getPerson(context) async {
  ByteData byteData =
      await DefaultAssetBundle.of(context).load("assets/icons/person2.svg");
  return byteData.buffer.asUint8List();
}
