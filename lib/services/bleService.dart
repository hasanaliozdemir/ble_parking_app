import 'dart:async';
import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:flutter_ble_lib/flutter_ble_lib.dart';

class NewBleService {
  BleManager bleManager = BleManager();
  Peripheral peripheral;

  start() async {

    bleManager.createClient();
    if (peripheral != null) {
      findServices();
    } else {
      scan();
    }
  }

  Future<bool> chechOn() async {
    var state = false;

    bleManager.bluetoothState().then((value) {
      print(value);
      if (value == BluetoothState.POWERED_ON) {
        state = true;
      }
    });

    return state;
  }

  scan() async {
    bleManager.startPeripheralScan().listen((scanResult) {
      //Scan one peripheral and stop scanning
      print(
          "Scanned Peripheral ${scanResult.peripheral.name}, RSSI ${scanResult.rssi}");
      if (scanResult.peripheral.name == "GSK_001") {
        peripheral = scanResult.peripheral;
        connect();
        bleManager.stopPeripheralScan();
      }
    });
  }

  connect() async {
    if (await isConnected()) {
      peripheral.disconnectOrCancelConnection();
    }

    peripheral
        .observeConnectionState(
            emitCurrentValue: true, completeOnDisconnect: true)
        .listen((connectionState) {
      print(
          "Peripheral ${peripheral.identifier} connection state is $connectionState");
    });
    await peripheral.connect();

    if (await isConnected()) {
      bleManager.stopPeripheralScan();
      findServices();
    } else {
      print("bağlanılamadı");
    }
  }

  isConnected() async {
    bool _connected = await peripheral.isConnected();
    return _connected;
  }

  findServices() async {
    await peripheral.discoverAllServicesAndCharacteristics();
    List<Service> services = await peripheral.services(); //getting all services
    List<Characteristic> characteristics2 = await services
        .firstWhere(
            (service) => service.uuid == "de8a5aac-a99b-c315-0c80-60d4cbb51224")
        .characteristics();

    selectCharacteristic(characteristics2);
  }

  selectCharacteristic(List<Characteristic> characteristics2) {
    Characteristic selectedOne;
    characteristics2.forEach((element) {
      if (element.uuid == "5b026510-4088-c297-46d8-be6c736a087a") {
        selectedOne = element;
        writeCharacter(selectedOne);
      }
    });
  }

  writeCharacter(
    Characteristic characteristic,
  ) {
    var data = Uint8List.fromList([0x01]);
    printInfo(info: "data : $data \n  charUuid : ${characteristic.uuid}");
    characteristic.write(data, true).then((value) => dispose);
  }

  dispose(){
    peripheral.disconnectOrCancelConnection();
    bleManager.destroyClient();
  }
}
