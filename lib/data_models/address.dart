import 'package:google_maps_flutter/google_maps_flutter.dart';

class Address {
   String sokak;
   String mahalle; //administrative_area_level_4
   String numara;
   String kat;
   String ilce;
   String il;
   String ulke;
   String postaKodu;
   String formattedAddress;
   LatLng latLng;
  
  Address({this.latLng,this.formattedAddress,this.sokak, this.mahalle, this.numara, this.kat, this.ilce, this.il,
      this.ulke, this.postaKodu});
}
