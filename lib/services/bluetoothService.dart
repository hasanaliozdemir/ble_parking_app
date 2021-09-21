import 'package:flutter_blue/flutter_blue.dart';

class BleService {
  FlutterBlue flutterBlue = FlutterBlue.instance;

  dosm(BluetoothDevice device) async {
    
    print(device.name);
    
    await findServices(device);
    

  }

  scan() async {
    var devices = await flutterBlue.connectedDevices;
    devices.forEach((element) {print(element.name);});
    
    var _gskDevices = devices.where((element) => element.name == "GSK_001");

    if (_gskDevices.isNotEmpty) {
      dosm(devices[0]);
    } else {
      flutterBlue.startScan(timeout: Duration(seconds: 4));
      var subscription = flutterBlue.scanResults.listen((results) {
      // do something with scan results
      for (ScanResult r in results) {
        if (r.device.name == "GSK_001") {
          connect(r.device);
          dosm(r.device);
          break;
        }
      }
    });
    print(subscription);
    }

    flutterBlue.stopScan();
    
  }

  connect(device) async {
    await device.connect();
  }

  findServices(device) async {
    List<BluetoothService> services = await device.discoverServices();
    services.forEach((service) {
      if (service.uuid.toString() == "de8a5aac-a99b-c315-0c80-60d4cbb51224") {
        readCharacters(service);
      }
      print(service.uuid);
    });
  }

  readCharacters(service) async{
    var characteristics = service.characteristics;
    for(BluetoothCharacteristic c in characteristics) {
      if (c.uuid.toString()=="5b026510-4088-c297-46d8-be6c736a087a") {
        c.write([0x01]);
      }

    
}
  }
}
