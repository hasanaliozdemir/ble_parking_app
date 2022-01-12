import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:gesk_app/core/colors.dart';
import 'package:get/get.dart';

class BleService{
  final flutterReactiveBle = FlutterReactiveBle();

  StreamController<DiscoveredDevice> _controller = StreamController<DiscoveredDevice>();

  final _devices = <DiscoveredDevice>[];
  StreamSubscription _subscription;

  
  StreamSubscription<ConnectionStateUpdate> _connection;

  startScan(BuildContext context){
    _showLoading(context);
    _subscription?.cancel();
    if (_devices.isEmpty) {
      try {
        _subscription=
    flutterReactiveBle.scanForDevices(withServices: []).listen((device) {
      if (device.name != null && device.name.length >2) {
        if (device.name.substring(0,3) == "GSK") {
        _devices.add(device);
        connectDevice(device,context);
        stopScan();
      }
      }
    });
      } catch (e) {
        Get.snackbar("Hata", e);
      }
    }else{
      connectDevice(_devices.first,context);
    }
  }

  connectDevice(DiscoveredDevice device,BuildContext context){
    _connection = flutterReactiveBle.connectToAdvertisingDevice(
      id: device.id, 
      withServices: [], 
      prescanDuration: const Duration(seconds: 5),
      connectionTimeout: const Duration(seconds:  2),
      ).listen((connectionState) {
        print(connectionState);
        if (connectionState.connectionState == DeviceConnectionState.connected) {
          writeWithResponse(device,context);
        }
      },onError: (error){
        Get.snackbar("Uyarı", error.toString());
      });
  }

  writeWithResponse(DiscoveredDevice device,BuildContext context)async{
    final characteristic = QualifiedCharacteristic(
      serviceId: Uuid.parse("de8a5aac-a99b-c315-0c80-60d4cbb51224"), 
      characteristicId: Uuid.parse("5b026510-4088-c297-46d8-be6c736a087a"), 
      deviceId: device.id);
    await flutterReactiveBle.writeCharacteristicWithResponse(characteristic, value: [1]);
    disConnect(device);
  }

  stopScan()async{
    await _subscription.cancel();
    _subscription = null;
  }

  disConnect(DiscoveredDevice device)async{
    _devices.clear();
    try{
      await _connection.cancel(); 
    }on Exception catch(e,_){
      print("Error disconnecting from a device: $e");
    }
  }

  void _showLoading(context){
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
        Timer(Duration(seconds: 7), (){
          Navigator.pop(context);
        });
  }

}