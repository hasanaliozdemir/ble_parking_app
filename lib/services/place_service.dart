import 'package:gesk_app/data_models/place.dart';
import 'package:gesk_app/data_models/place_search.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class PlaceServices{
  final String _apiKey = "AIzaSyCN6F8cD7cwSoJ5h8Cl5c1U7EKG_oU5XZw";

  Future<List<PlaceSearch>> getAutoComplete(String search) async{
    var url = Uri.parse("https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$search&types=(regions)&language=tr_TR&components=country:tr&key=$_apiKey");

    var response = await http.get(url);

    var json = convert.jsonDecode(response.body);

    var jsonResults = json['predictions'] as List;
    return jsonResults.map(
      (place) => PlaceSearch.fromJson(place)
    ).toList();
  }

  Future<Place> getPlace(String placeId) async{
    var url = Uri.parse("https://maps.googleapis.com/maps/api/place/details/json?key=$_apiKey&place_id=$placeId");

    var response = await http.get(url);

    var json = convert.jsonDecode(response.body);

    var jsonResult = json['result'] as Map<String,dynamic>;
    return Place.fromJson(jsonResult);
  }
}