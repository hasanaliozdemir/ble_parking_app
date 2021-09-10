import 'dart:async';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:gesk_app/backend/dataService.dart';
import 'package:gesk_app/models/park.dart';
import 'package:gesk_app/wrapper.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var dataService = DataService();

  var _auth;
  var _location;
  List<Park> _firstParks = List<Park>();

  @override
  void initState() {
    super.initState();
    _getAuth();
    _getUserLocation();
  }

  @override
  Widget build(BuildContext context) {
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
    Timer(Duration(seconds: 2), () {
      if (_auth != null) {
        if (_location != null) {
          if (_firstParks != null) {
            Get.to(() => Wrapper(auth: _auth, location: _location,firstParks: _firstParks),
              fullscreenDialog: true);
          }
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
    var _referance = await dataService.getNearParks(lat: lat, lng: lng);

    if (_referance is List<Park>) {
      return _referance;
    }else{
      _referance.printInfo();
      List<Park> _decoy = [];
      return _decoy;
    }
  }
}
