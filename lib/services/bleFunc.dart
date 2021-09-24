import 'package:flutter_blue/flutter_blue.dart';

class BleFunc{
  FlutterBlue flutterBlue = FlutterBlue.instance;

  Future<bool> checkBT()async{
    return flutterBlue.isOn;
  }
}