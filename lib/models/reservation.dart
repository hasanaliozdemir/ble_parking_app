import 'package:gesk_app/backend/dataService.dart';
import 'package:gesk_app/models/park.dart';
import 'package:intl/intl.dart';

class Reservation{
  final int reservationId;
  final DateTime date;
  final String start;
  final String end;
  final int parkId;
  final int tpaId;
  final String ownerId;
  String plate; 
  String visitTime; 
  String visitStatus;

  bool owned;
  double price;

  Park park;

  String parkName;
  String tpaName;

  Reservation({this.park,this.parkName,this.tpaName,this.price,this.owned,this.plate,this.reservationId, this.date, this.start, this.end, this.parkId, this.tpaId, this.ownerId});

  factory Reservation.fromJson(Map<String,dynamic> json){
    
    String _ref = json["visitTime"];

    var _startendList = _ref.split(" ");
    var _date = DateFormat("yyyy.MM.dd").parse(_startendList[0].split("-")[0]);

    var _start = _startendList[0].split("-")[1].substring(0,2);
    var _end = _startendList[1].split("-")[1].substring(0,2);
    double _price = 0;
    Park _park;



    return Reservation(
      tpaName: "",
      parkName: "",
      reservationId: json["reservationId"],
      tpaId: json["tpaId"],
      plate: json["plate"],
      date: _date,
      start: _start,
      end: _end,
      parkId: json["parkId"],
      owned: false,
      price: _price,
      park: _park
    );
  }

}