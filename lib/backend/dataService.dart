import 'package:gesk_app/models/car.dart';
import 'package:gesk_app/models/park.dart';
import 'package:gesk_app/models/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class DataService {
  final String _url = "159.146.47.86";
  final int _port = 39140;

  Future<User> registerUser(
      String name, String password, String phone, String mail) async {
    Uri _uri = Uri(scheme: "https", host: _url, port: _port, path: "/setInfo");
    Map<String, dynamic> _payloadBody = {
      "register": {
        "name": name,
        "password": password,
        "phone": phone,
        "mail": mail
      }
    };

    var _postJson = convert.jsonEncode(_payloadBody);

    var _response = await http.post(_uri, body: _postJson);

    var _responseJson = convert.jsonDecode(_response.body);

    var _user = User.fromJson(_responseJson["register"]);

    return _user;
  }

  Future<Car> addCar(
      String userId, String plate, String modelYear, String color) async {
    Uri _uri = Uri(scheme: "https", host: _url, port: _port, path: "/setInfo");
    Map<String, dynamic> _payloadBody = {
      "addCar": {
        "userID": userId,
        "plate": plate,
        "phomodelYearne": modelYear,
        "color": color
      }
    };

    var _postJson = convert.jsonEncode(_payloadBody);

    var _response = await http.post(_uri, body: _postJson);

    var _responseJson = convert.jsonDecode(_response.body);

    var _car = Car.fromJson(_responseJson["addCar"]);

    return _car;
  }

  Future<String> deleteCar(String carId) async {
    Uri _uri = Uri(scheme: "https", host: _url, port: _port, path: "/setInfo");

    Map<String, dynamic> _payloadBody = {
      "deleteCar": {"carId": carId}
    };

    var _postJson = convert.jsonEncode(_payloadBody);

    var _response = await http.post(_uri, body: _postJson);

    var _responseJson = convert.jsonDecode(_response.body);

    return _responseJson["deleteCar"];
  }

  Future<Car> editCar(
      String carId, String plate, String modelYear, String color) async {
    Uri _uri = Uri(scheme: "https", host: _url, port: _port, path: "/setInfo");
    Map<String, dynamic> _payloadBody = {
      "editCar": {
        "carId": carId,
        "plate": plate,
        "phomodelYearne": modelYear,
        "color": color
      }
    };

    var _postJson = convert.jsonEncode(_payloadBody);

    var _response = await http.post(_uri, body: _postJson);

    var _responseJson = convert.jsonDecode(_response.body);

    var _car = Car.fromJson(_responseJson["editCar"]);

    return _car;
  }

  Future<Park> addPark(
      String userId,
      bool isClosedPark,
      bool isWithCam,
      bool isWithSecurity,
      bool isWithElectricity,
      String name,
      double price,
      int status,
      int parkSpace,
      int filledParkSpace,
      double longitude,
      double latitude,
      String location) async {
    Uri _uri = Uri(scheme: "https", host: _url, port: _port, path: "/setInfo");
    Map<String, dynamic> _payloadBody = {
      "addPark": {
        "ownerId": userId,
        "isClosedPark": isClosedPark,
        "isWithCam": isWithCam,
        "isWithSecurity": isWithSecurity,
        "isWithElectricity": isWithElectricity,
        "name": name,
        "price": price,
        "status": status,
        "parkSpace": parkSpace,
        "filledParkSpace": filledParkSpace,
        "longitude": longitude,
        "latitude": latitude,
        "location": location,
      }
    };

    var _postJson = convert.jsonEncode(_payloadBody);

    var _response = await http.post(_uri, body: _postJson);

    var _responseJson = convert.jsonDecode(_response.body);

    var _park = Park.fromJson(_responseJson["addPark"]);

    return _park;
  }

  Future<String> deletePark(String parkId)async{
    Uri _uri = Uri(scheme: "https", host: _url, port: _port, path: "/setInfo");

    Map<String, dynamic> _payloadBody = {
      "deletePark": {"parkId": parkId}
    };

    var _postJson = convert.jsonEncode(_payloadBody);

    var _response = await http.post(_uri, body: _postJson);

    var _responseJson = convert.jsonDecode(_response.body);

    return _responseJson["deletePark"];
  }


  Future<Park> editPark(
      String userId,
      String parkId,
      bool isClosedPark,
      bool isWithCam,
      bool isWithSecurity,
      bool isWithElectricity,
      String name,
      double price,
      int status,
      int parkSpace,
      int filledParkSpace,
      double longitude,
      double latitude,
      String location) async {
    Uri _uri = Uri(scheme: "https", host: _url, port: _port, path: "/setInfo");
    Map<String, dynamic> _payloadBody = {
      "addPark": {
        "parkId": parkId,
        "ownerId": userId,
        "isClosedPark": isClosedPark,
        "isWithCam": isWithCam,
        "isWithSecurity": isWithSecurity,
        "isWithElectricity": isWithElectricity,
        "name": name,
        "price": price,
        "status": status,
        "parkSpace": parkSpace,
        "filledParkSpace": filledParkSpace,
        "longitude": longitude,
        "latitude": latitude,
        "location": location,
      }
    };

    var _postJson = convert.jsonEncode(_payloadBody);

    var _response = await http.post(_uri, body: _postJson);

    var _responseJson = convert.jsonDecode(_response.body);

    var _park = Park.fromJson(_responseJson["addPark"]);

    return _park;
  }

  Future<User> login(String phoneNumber, String password) async {
    Uri _uri = Uri(scheme: "https", host: _url, port: _port, path: "/getInfo");
    Map<String, dynamic> _payloadBody = {
      "login": {
        "password": password,
        "phoneNumber": phoneNumber,
      }
    };

    var _postJson = convert.jsonEncode(_payloadBody);

    var _response = await http.post(_uri, body: _postJson);

    var _responseJson = convert.jsonDecode(_response.body);

    var _user = User.fromJson(_responseJson["login"]);

    return _user;
  }

  Future<List<Car>> getCars(List<int> carsId) async{
    Uri _uri = Uri(scheme: "https", host: _url, port: _port, path: "/getInfo");
    Map<String, dynamic> _payloadBody = {
      "getUserCars": {
        "carsId": carsId,
      }
    };

    var _postJson = convert.jsonEncode(_payloadBody);

    var _response = await http.post(_uri, body: _postJson);

    var _responseJson = convert.jsonDecode(_response.body);

    var _carsJson = _responseJson["getuserCars"] as List;

  List<Car> _cars = _carsJson.map((carJson) => Car.fromJson(carJson)).toList();

    return _cars;
  }

  Future<Car> getCar(String carId) async{
    Uri _uri = Uri(scheme: "https", host: _url, port: _port, path: "/getInfo");
    Map<String, dynamic> _payloadBody = {
      "getCar": {
        "carId": carId,
      }
    };
    var _postJson = convert.jsonEncode(_payloadBody);

    var _response = await http.post(_uri, body: _postJson);

    var _responseJson = convert.jsonDecode(_response.body);

    var _car = Car.fromJson(_responseJson["getCar"][0]);

    return _car;
  }

  Future<User> getUser(String userId) async{
    Uri _uri = Uri(scheme: "https", host: _url, port: _port, path: "/getInfo");
    Map<String, dynamic> _payloadBody = {
      "getUser": {
        "userId": userId,
      }
    };
    var _postJson = convert.jsonEncode(_payloadBody);

    var _response = await http.post(_uri, body: _postJson);

    var _responseJson = convert.jsonDecode(_response.body);

    var _user = User.fromJson(_responseJson["getUser"][0]);

    return _user;
  }

  Future<Park> getPark(String parkId) async{
    Uri _uri = Uri(scheme: "https", host: _url, port: _port, path: "/getInfo");
    Map<String, dynamic> _payloadBody = {
      "getPark": {
        "parkId": parkId,
      }
    };
    var _postJson = convert.jsonEncode(_payloadBody);

    var _response = await http.post(_uri, body: _postJson);

    var _responseJson = convert.jsonDecode(_response.body);

    var _park = Park.fromJson(_responseJson["getPark"][0]);

    return _park;
  }

  Future<bool> confirm(String userId) async{
    Uri _uri = Uri(scheme: "https", host: _url, port: _port, path: "/getInfo");
    Map<String, dynamic> _payloadBody = {
      "confirm": {
        "userId": userId,
      }
    };
    var _postJson = convert.jsonEncode(_payloadBody);

    var _response = await http.post(_uri, body: _postJson);

    var _responseJson = convert.jsonDecode(_response.body);

    var _status = _responseJson["confirm"]["status"];

    return _status;
  }

}
