import 'package:intl/intl.dart';

class Reservation{
  final int reservationId;
  final DateTime date;
  final int start;
  final int end;
  final int parkId;
  final int tpaId;
  final String ownerId;
  String plate; 
  String visitTime; 
  String visitStatus;
  
  

  Reservation({this.plate,this.reservationId, this.date, this.start, this.end, this.parkId, this.tpaId, this.ownerId});

  factory Reservation.fromJson(Map<String,dynamic> json){
    print(json);
    String _ref = json["visitTime"];

    var _startendList = _ref.split("-");
    var _date = DateFormat("yyyy.MM.dd").parse(_startendList[0].split(" ")[0]);

    var _start = int.parse(_startendList[0].split(" ")[1].substring(0,2));
    var _end = int.parse(_startendList[1].split(" ")[1].substring(0,2));
    

    return Reservation(
      tpaId: json["tpaId"],
      plate: json["plate"],
      date: _date,
      start: _start,
      end: _end,
      parkId: json["parkId"],

    );
  }

}