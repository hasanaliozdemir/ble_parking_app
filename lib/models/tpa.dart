import 'package:get/get_rx/src/rx_types/rx_types.dart';

class Tpa{
  final int tapId;
  int parkId;
  RxBool avaliable;
  String tpaName;
  double hourlyPrice;
  bool isWithElectricity;
  String maxCarSize; 
  List reservedTimes;
  List avaliableTimes;
  

  Tpa({this.avaliableTimes,this.reservedTimes,this.parkId,this.maxCarSize,this.tapId, this.avaliable, this.tpaName, this.hourlyPrice, this.isWithElectricity});

  factory Tpa.fromJson(Map<String,dynamic> json){
    fixReservedTimes(val){
      if (val is String) {
        print(val);
        return [];
      } else {
        return val;
      }
    }


    return Tpa(
      tapId: json["tpaId"],
      parkId: json["parkId"],
      tpaName: json["tpaName"],
      hourlyPrice: json["hourlyPrice"],
      isWithElectricity: false, //TODO: data ?
      avaliable: true.obs, //TODO: data ?
      maxCarSize: "SUV", //TODO: ekle seçimini
      reservedTimes : fixReservedTimes(json["reservedTimes"])
    );
  }

  factory Tpa.fromJsonWithAvaliable(Map<String,dynamic> json){
    return Tpa(
      tapId: json["tpaId"],
      tpaName: json["tpaName"],
      avaliableTimes: json["times"]
    );
  }

}