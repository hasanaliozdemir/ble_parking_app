import 'package:get/get_rx/src/rx_types/rx_types.dart';

class Tpa{
  final int tapId;
  final RxBool avaliable;
  final String tpaName;
  final double hourlyPrice;
  final bool isWithElectricity;

  Tpa({this.tapId, this.avaliable, this.tpaName, this.hourlyPrice, this.isWithElectricity});
}