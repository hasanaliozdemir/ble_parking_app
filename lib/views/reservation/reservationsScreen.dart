import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gesk_app/backend/dataService.dart';
import 'package:gesk_app/core/colors.dart';
import 'package:gesk_app/core/components/bottomBar.dart';
import 'package:gesk_app/models/reservation.dart';
import 'package:gesk_app/views/reservation/reservation_detail.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReservationsScreen extends StatefulWidget {
  const ReservationsScreen({Key key}) : super(key: key);

  @override
  _ReservationsScreenState createState() => _ReservationsScreenState();
}

class _ReservationsScreenState extends State<ReservationsScreen> {
  List<Reservation> ownerList = List<Reservation>();
  List<Reservation> carList = List<Reservation>();
  var _turned = false.obs;

  var dataService = DataService();

  @override
  void initState() { 
    super.initState();
    _getInstance();
    _orderReservations();
  }

  final int _index = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: BottomBar(index: _index),
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).padding.top,
          ),
          Spacer(
            flex: 56,
          ),
          Expanded(flex: 160, child: _buildCards()),
          Spacer(
            flex: 37,
          ),
          Expanded(
            flex: 432,
            child: Obx((){
              if (_turned.value == false) {
                return _buildCarReservations();
              }else{
                return _buildOwnerReservations();
              }
            }),
          )
        ],
      ),
    );
  }

  Widget _buildCards() {
    return Obx(() => Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  if (_turned.value != false) {
                    _turned.value = false;
                  }
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: _turned.value
                      ? SvgPicture.asset("assets/images/grayCard2.svg")
                      : Image.asset(
                          "assets/images/blueCard.png",
                        ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            Expanded(
                child: GestureDetector(
              onTap: () {
                if (_turned.value != true) {
                  _turned.value = true;
                }
              },
              child: Container(
                child: _turned.value
                    ? SvgPicture.asset("assets/images/blueCard2.svg")
                    : Image.asset("assets/images/grayCard.png"),
                padding: EdgeInsets.symmetric(horizontal: 16),
              ),
            ))
          ],
        ));
  }

  _buildOwnerReservations() {
    return ListView.builder(
      shrinkWrap: false,
      itemCount: ownerList.length ?? 0,
      itemBuilder: (context, index) {
        var _reservation = ownerList[index];
        return _buildListTile(_reservation);
        }
    );
  }

  _buildCarReservations() {
    return ListView.builder(
      shrinkWrap: false,
      itemCount: carList.length ?? 0,
      itemBuilder: (context, index) {
        var _reservation = carList[index];
        return GestureDetector(
          onTap: ()async{
            _showLoading();
            var _tpas = await dataService.getTpas(carList[index].parkId);
            
            var _index = _tpas.indexWhere((element) => element.tapId == carList[index].tpaId);

            if (_index == -1) {
              Navigator.pop(context);
              Get.snackbar("Hata", "Bir hata oluştu");
            }else{
              var _tpa = _tpas[_index];
            if (_tpa != null && carList[index].park != null) {
              Navigator.pop(context);
              Get.to(()=> ReservationDetail(
                park: carList[index].park, 
                tpa: _tpa, 
                date: carList[index].date, 
                start: int.parse(carList[index].start), 
                end: int.parse(carList[index].end), 
                reservation: carList[index]
                ));
            }else{
              Navigator.pop(context);
            }
            }
          },
          child: _buildListTile(_reservation));
      },
      
    );
  }

  Padding _buildListTile(Reservation _reservation) {
    print(_reservation.parkName);
    return Padding(
        padding: EdgeInsets.all(8),
        child: Container(
          height: Get.height / 812 * 56,
          decoration: BoxDecoration(
              border: Border.all(color: gray500, width: 1),
              borderRadius: BorderRadius.circular(8)),
          child: Center(
            child: ListTile(
              leading: _buildLeading(),
              title: Text(
                _reservation.parkName+" "+_reservation.tpaName,
                style: TextStyle(
                    fontFamily: "SF Pro Text",
                    fontSize: 13,
                    fontWeight: FontWeight.w600),
              ),
              subtitle: _buildSubtitle(_reservation),
            ),
          ),
        ),
      );
  }

  Padding _buildLeading() {
    return Padding(
      padding: const EdgeInsets.only(bottom:8.0),
      child: Container(
        alignment: Alignment.centerLeft,
        width: Get.width / 375 * 36,
        height: Get.width / 375 * 36,
        decoration:
            BoxDecoration(color: gray400, borderRadius: BorderRadius.circular(8)),
        child: Center(
            child: Icon(
          CupertinoIcons.bell_circle,
          color: blue500,
        )),
      ),
    );
  }

  Text _buildSubtitle(Reservation _reservation){
    var _dateString= "${_reservation.date.day}.${_reservation.date.month}.${_reservation.date.year}";
    var _timeString= "${_reservation.start}:00 - ${_reservation.end}:00";

    return Text(
      _dateString+"    "+_timeString
    );
  }

  _orderReservations(){
    
  }

  _getInstance()async{
    _showLoading();
    SharedPreferences _prefs = await SharedPreferences.getInstance();

    var _userId = _prefs.getInt("userId");

    carList= await dataService.getReservationsDriver(_userId);

    ownerList = await dataService.getReservationsHost(_userId);

    Navigator.pop(context);
    setState(() {
          
        });
  }

  void _showLoading()async{

    Future.delayed(Duration.zero,(){
      showDialog(
      barrierDismissible: false,
      context: context, 
    builder: (context){
      return Center(
        child: Container(
          width: Get.width/375*50,
          height: Get.width/375*50,
          decoration: BoxDecoration(
            color: white,
            borderRadius: BorderRadius.circular(8)
          ),
          child: CircularProgressIndicator.adaptive(),
        ),
      );
    });
    });
  }

  goToReservation(Reservation reservation){
    
  }
}
