import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'dart:async';

class BleStatusService {
  final _ble = FlutterReactiveBle();
  StreamSubscription _subscription;

  bool giveStatus() {
    _subscription= _ble.statusStream.listen((status) {
      print(status);
    });
  }
}
