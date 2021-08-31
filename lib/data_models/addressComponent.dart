import 'dart:convert';

class AddressComponent{
  String longName;
  String shortName;
  List<String> types;

  AddressComponent({this.longName,this.shortName,this.types});

  factory AddressComponent.fromJson( Map<String,dynamic> json ){
    List<String> _types = List<String>();
    var _ref = json["types"] as List;
    _ref.forEach((element) { _types.add(element.toString());});
    return AddressComponent(
      longName: json["long_name"],
      shortName: json["short_name"],
      types: _types
    );
  }
}