import 'dart:async';

import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:get/get.dart';

class BleService{
  final flutterReactiveBle = FlutterReactiveBle();

  StreamController<DiscoveredDevice> _controller = StreamController<DiscoveredDevice>();

  final _devices = <DiscoveredDevice>[];
  StreamSubscription _subscription;

  
  StreamSubscription<ConnectionStateUpdate> _connection;

  startScan(){
    _devices.clear();
    _subscription?.cancel();
    _subscription=
    flutterReactiveBle.scanForDevices(withServices: []).listen((device) {
      if (device.name != null && device.name.length >2) {
        if (device.name.substring(0,3) == "GSK") {
        _devices.add(device);
        connectDevice(device);
        stopScan();
      }
      }
      
    });
  }

  connectDevice(DiscoveredDevice device){
    _connection = flutterReactiveBle.connectToAdvertisingDevice(
      id: device.id, 
      withServices: [], 
      prescanDuration: const Duration(seconds: 5),
      connectionTimeout: const Duration(seconds:  2),
      ).listen((connectionState) {
        print(connectionState);
        if (connectionState.connectionState == DeviceConnectionState.connected) {
          writeWithResponse(device);
        }
      },onError: (error){
        Get.snackbar("Uyarı", error.toString());
      });


      Timer(Duration(seconds: 10), (){
        disConnect(device);
      });
  }

  writeWithResponse(DiscoveredDevice device)async{
    final characteristic = QualifiedCharacteristic(
      serviceId: Uuid.parse("de8a5aac-a99b-c315-0c80-60d4cbb51224"), 
      characteristicId: Uuid.parse("5b026510-4088-c297-46d8-be6c736a087a"), 
      deviceId: device.id);
    await flutterReactiveBle.writeCharacteristicWithResponse(characteristic, value: [1]);
  }

  stopScan()async{
    await _subscription.cancel();
    _subscription = null;
  }

  disConnect(DiscoveredDevice device)async{
    try{
      await _connection.cancel(); 
    }on Exception catch(e,_){
      print("Error disconnecting from a device: $e");
    }
  }

}