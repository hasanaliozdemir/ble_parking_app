import 'package:gesk_app/data_models/address.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class AdressService{
  final _key = "AIzaSyAm5L6H-LaUyOUlHNt_nMwy7b_VNRxPPLM";

  Future<Address> getFormatedAddress(LatLng location)async{
    var url = Uri.parse("https://maps.googleapis.com/maps/api/geocode/json?latlng=${location.latitude},${location.longitude}&language=tr_TR&key=$_key");
  
    var response = await http.get(url);

    var json = convert.jsonDecode(response.body);

    

    return  Address(
      formattedAddress: json['results'][0]['formatted_address'],
      sokak: json['results'][0]['address_components'][1]['short_name'],
      mahalle: json['results'][0]['address_components'][2]['short_name'],
      ilce: json['results'][0]['address_components'][3]['short_name'],
      il: json['results'][0]['address_components'][4]['short_name'],
      ulke: json['results'][0]['address_components'][5]['short_name'],
      postaKodu: json['results'][0]['address_components'][6]['short_name'],
      numara: "",
      kat: "",

      latLng: LatLng(json['results'][0]['geometry']['location']['lat'],json['results'][0]['geometry']['location']['lng']),
    );
  }
}