import 'package:gesk_app/data_models/address.dart';
import 'package:gesk_app/data_models/addressComponent.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class AdressService {
  final _key = "AIzaSyAm5L6H-LaUyOUlHNt_nMwy7b_VNRxPPLM";

  Future<Address> getFormatedAddress(LatLng location) async {
    var url = Uri.parse(
        "https://maps.googleapis.com/maps/api/geocode/json?latlng=${location.latitude},${location.longitude}&language=tr_TR&key=$_key");

    var response = await http.get(url);

    var json = convert.jsonDecode(response.body);

    var _comps = json["results"][0]["address_components"] as List;

    List<AddressComponent> _adressComponents = List<AddressComponent>();

    _comps.forEach((element) {
      _adressComponents.add(AddressComponent.fromJson(element));
    });

    

    _getAdressComp(String type) {
      var _index = _adressComponents
              .indexWhere((element) => (element.types.contains(type)));


      if (_index>-1) {
        return _adressComponents[_index]
          .shortName;
      }else{
        return "";
      }
    }

    
    return Address(
      mahalle: _getAdressComp("administrative_area_level_4"),
      formattedAddress: json["results"][0]["formatted_address"],
      numara: "",
      kat: "",
      latLng: LatLng(json['results'][0]['geometry']['location']['lat'],
          json['results'][0]['geometry']['location']['lng']),
    );
  }
}
