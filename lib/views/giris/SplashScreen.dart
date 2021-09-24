import 'dart:async';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:gesk_app/backend/dataService.dart';
import 'package:gesk_app/models/park.dart';
import 'package:gesk_app/services/distanceService.dart';
import 'package:gesk_app/views/giris/MapScreen.dart';
import 'package:gesk_app/views/giris/MapScreen_readOnly.dart';
import 'package:gesk_app/wrapper.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var dataService = DataService();

  var count = 0;

  var _auth;
  var _location;
  bool _fixed = false;
  List<Park> _firstParks = List<Park>();
  List<Park> _ready = List<Park>();

  @override
  void initState() {
    super.initState();
    _getAuth();
    _getUserLocation();
  }

  @override
  Widget build(BuildContext context) {
    print("splashCalled !!!!!");
    var height = 190.obs;
    var height2 = 400.obs;

    const oneSec = const Duration(seconds: 1);
    new Timer.periodic(oneSec, (Timer t) {
      if (height.value == 190) {
        height.value = 250;
        height2.value = 500;
      } else {
        height.value = 190;
        height2.value = 400;
      }
    });

    _timer();

    return Scaffold(
        body: Obx(
      () => Center(
        child: Stack(
          children: [
            Center(
              child: AnimatedContainer(
                  duration: Duration(seconds: 1),
                  height: height.value.toDouble(),
                  child: Center(
                    child: SvgPicture.asset(
                      "assets/logos/Color.svg",
                      fit: BoxFit.fitHeight,
                    ),
                  )),
            ),
            Center(
              child: AnimatedContainer(
                duration: Duration(seconds: 1),
                height: height2.value.toDouble(),
                child: Center(
                    child: SvgPicture.asset(
                  "assets/logos/Elips.svg",
                  fit: BoxFit.fitHeight,
                )),
              ),
            )
          ],
        ),
      ),
    ));
  }

  _getAuth() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    
    _auth = _prefs.getBool("auth");

    if (_auth == null) {
      _auth = false;
    }
  }

  _timer() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (_auth != null) {
        if (_location != null) {
          if (_firstParks != null) {
            if (_firstParks.last!=null && _firstParks.last.distance!=null) {
              if (_firstParks.last.distance !="") {
              _orderList();
              if (_fixed==true) {
                if (_auth == true) {
                  Get.off(() => MapScreen(location: _location,firstParks:_ready));
                  timer.cancel();
                } else {
                  Get.off(() => MapScreenReadOnly(location: _location,firstParks:_ready));
                  timer.cancel();
                }
              
              }
            }else{
              _distanceFix(_location.latitude,_location.longitude);
            }
            } 
          }
        }else{
          _getUserLocation();
        }
      }
    });
  }

  _getUserLocation() async {
    var position = await GeolocatorPlatform.instance
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    _location = position;
    _firstParks = await _getParks(lat: position.latitude, lng: position.longitude);

    
  }

  Future<List<Park>> _getParks({@required double lat, @required double lng}) async {
    List<Park> _referance = await dataService.getNearParks(lat: lat, lng: lng);
    var _prefs = await SharedPreferences.getInstance();
    var _userId = _prefs.getInt("userId");
    List<Park> _avaliableParks = List<Park>();

    if (_userId == null) {
      
    }else{
      _avaliableParks= await dataService.getAdminPark(_userId); //GETPARKSBYLOCATİON
    }

    _avaliableParks.forEach((element) {element.status = Status.admin; });


    _avaliableParks.forEach((aval) { 
      _referance.removeWhere((element) => element.id  == aval.id);
    });

    _avaliableParks.forEach((aval2) { 
      _referance.add(aval2);
    });




    if (_referance is List<Park>) {
      return _referance;
    }else{
      
      List<Park> _decoy = [];
      return _decoy;
    }


  }

  Future _distanceFix(lat,lng)async{
    _firstParks.forEach((element) async{ 
      var _dist = await DistanceService().getDistance(
        LatLng(lat, lng), 
        LatLng(element.latitude, element.longitude));
        setState(() {
                  element.distance = _dist;
                });
    });
    
  }

  _orderList(){
    
    //_firstParks.forEach((element) {print("orijin"+element.distance+" - "+element.name);});
    _firstParks.sort((a, b) => a.distance.compareTo(b.distance));
    //_firstParks.forEach((element) {print("sorted"+element.distance+" - "+element.name);});
    _ready = _firstParks;
    _fixed = true;
  }
}
