import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gesk_app/bloc/app_bloc.dart';
import 'package:gesk_app/core/colors.dart';
import 'package:gesk_app/core/components/button.dart';
import 'package:gesk_app/core/components/textInput.dart';
import 'package:gesk_app/core/funcs/triangleCreator.dart';
import 'package:gesk_app/data_models/address.dart';

import 'package:gesk_app/data_models/location.dart';

import 'package:gesk_app/models/park.dart';
import 'package:gesk_app/services/addressService.dart';
import 'package:gesk_app/services/markerCreator.dart';
import 'package:gesk_app/views/profil/park/addParkDetails.dart';
import 'package:gesk_app/views/profil/park/addParkPage.dart';
import 'package:get/get.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';


class ChoseAddressPage extends StatefulWidget {
  final LatLng latLng;
  const ChoseAddressPage({Key key, this.latLng}) : super(key: key);

  @override
  _ChoseAddressPageState createState() => _ChoseAddressPageState(latLng);
}

class _ChoseAddressPageState extends State<ChoseAddressPage> {
  
  LatLng latLng;
  Location place;
  Address address;
  
  CameraPosition cameraPosition;
  List<Marker> _markers = [];

  Completer<GoogleMapController> _mapController =
      Completer<GoogleMapController>();

  TextEditingController addressController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController floorController = TextEditingController();

  FocusNode addressFocus = FocusNode();
  FocusNode numberFocus = FocusNode();
  FocusNode floorFocus = FocusNode();

  StreamSubscription addressSubscription;

  _ChoseAddressPageState(this.latLng);
  @override
  void initState() {
    final applicationBloc = Provider.of<AppBloc>(context,listen: false);
    applicationBloc.setSelectedAddress(latLng);
    addressSubscription = applicationBloc.selectedAddress.stream.asBroadcastStream().listen((lastAddress) {
      _setAddress(lastAddress);
     });

    MarkerGenerator(markerWidgets(), (bitmaps) {
      setState(() {
        _markers = mapBitmapsToMarkers(bitmaps);
      });
    }).generate(context);
    _getFirstAddress();
    super.initState();
  }

  @override
  void dispose() {
    final applicationBloc = Provider.of<AppBloc>(context);

    addressSubscription.cancel();
    applicationBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final applicationBloc = Provider.of<AppBloc>(context, listen: false);

    return Scaffold(
      
        body: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: _columnBuild(context),
            )
          ],
        )
        );
  }

  Column _columnBuild(BuildContext context) {
    return Column(
    children: [
      SizedBox(
        height: MediaQuery.of(context).padding.top,
      ),
      Spacer(
        flex: 20,
      ),
      Expanded(
        flex: 44,
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.all(8),
              child: _buildBackButton(),
            ),
            Center(
              child: Text(
                "Yeni Adresi Ekle",
                style: TextStyle(
                    color: black,
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    fontFamily: "SF Pro Text"),
              ),
            )
          ],
        ),
      ),
      Spacer(
        flex: 6,
      ),
      Expanded(
        flex: 470,
        child: GoogleMap(
          initialCameraPosition: CameraPosition(target: latLng, zoom: 15),
          markers: _markers.toSet(),
          mapToolbarEnabled: false,
          myLocationButtonEnabled: false,
        ),
      ),
      Expanded(
          flex: 240,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Flexible(child: _buildAddressInput(),flex: 50,),
                Flexible(child: _buildAddress2(),flex: 44,),
                Flexible(child: _buildButton(),flex: 56,)
              ],
            ),
          )),
      SizedBox(
        height: MediaQuery.of(context).padding.bottom,
      )
    ],
  );
  }

  Widget _buildAddressInput() {
    
    return Container(
      
              width: Get.width/375*343,
      child: TextInputSimple(
        focusNode: addressFocus,
        controller: addressController,
        readOnly: true,
      ),
    );
  }

  Widget _buildAddress2() {
    return Row(
      children: [
        Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: Get.height/812*44,
                width: Get.width/375*164,
          child: TextInputSimple(
            onChange: (){
              setState(() {
                              
                            });
            },
              focusNode: numberFocus,
              controller: numberController,
              hintText: "Bina No",
          ),
        ),
            )),
        Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: Get.height/812*44,
                width: Get.width/375*164,
          child: TextInputSimple(
            onChange: (){
              setState(() {
                              
                            });
            },
              focusNode: floorFocus,
              controller: floorController,
              hintText: "Kat",
          ),
        ),
            )),
      ],
    );
  }

  Widget _buildButton() {
    if (numberController.text!=null && numberController.text!="" && floorController.text!=null && floorController.text != "") {
      return Container(
      child: Button.active(text: "Kaydet", onPressed: _confirmFunc),
    );
    } else {
      return Container(
      child: Button.passive(text: "Kaydet", onPressed: null),
    );
    }
  }

  List<Marker> mapBitmapsToMarkers(List<Uint8List> bitmaps) {
    final _applicationBloc = Provider.of<AppBloc>(context,listen: false);
    List<Marker> _markersList = [];
    bitmaps.asMap().forEach((i, bmp) {
      _markersList.add(Marker(
          markerId: MarkerId("20"),
          draggable: true,
          onDragEnd: (newLL) {
            setState(() {
                          latLng = newLL;
                        });
            _applicationBloc.setSelectedAddress(latLng);
            
          },
          position: latLng,
          icon: BitmapDescriptor.fromBytes(bmp)));
    });
    return _markersList;
  }

  Widget _getMarkerWidget(
      double price, Status status, bool isWithElectiricity) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        child: Container(
          width: Get.width / 375 * 64,
          height: Get.height / 812 * 70,
          child: Stack(children: [
            Padding(
              padding:
                  const EdgeInsets.only(top: 8.0, right: 8, left: 8, bottom: 1),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.00),
                      color: blue800,
                    ),
                    width: Get.width / 375 * 48,
                    height: Get.height / 812 * 48,
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: Align(
                              alignment: Alignment.center,
                              child: _buildMarkerText(Status.owner, price)),
                        ),
                      ],
                    ),
                  ),
                  RotatedBox(
                    quarterTurns: 2,
                    child: CustomPaint(
                      painter: TrianglePainter(
                        strokeColor: blue800,
                        strokeWidth: 10,
                        paintingStyle: PaintingStyle.fill,
                      ),
                      child: Container(
                        height: Get.height / 812 * 7,
                        width: Get.width / 375 * 10,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ]),
        ));
  }

  List<Widget> markerWidgets() {
    return [_getMarkerWidget(0, Status.owner, false)];
  }

  Widget _buildMarkerText(Status status, price) {
    if (status == Status.owner) {
      return Icon(
        CupertinoIcons.map_pin_ellipse,
        color: white,
      );
    } else {
      return Text(
        price.truncate().toString() + "₺",
        style: TextStyle(
          color: Colors.white,
          fontSize: 17,
          fontFamily: "SF Pro Text",
          fontWeight: FontWeight.w600,
        ),
      );
    }
  }

  Widget _buildBackButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        child: GestureDetector(
          onTap: () => _backButtonFunc(),
          child: Row(
            children: [
              Icon(CupertinoIcons.left_chevron, color: blue500),
              Text(
                "Geri",
                style: TextStyle(fontSize: 17, color: blue500),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _backButtonFunc() {
    Get.to(() => AddParkPage());
  }

  void _confirmFunc() {
    Get.to(()=> AddParkDetails(
      address: Address(
        latLng: address.latLng,
        formattedAddress: address.formattedAddress,
        mahalle: address.mahalle,
        numara: numberController.text,
        kat: floorController.text
      ),
      
    ));
  }

  _setAddress(Address newAddress){
    address = newAddress;
    setState(() {
          addressController.text = newAddress.formattedAddress;
        });
  }

  _getFirstAddress() async{
    var _adres = await AdressService().getFormatedAddress(latLng);
    address = _adres;
    setState(() {
          addressController.text = _adres.formattedAddress;
        });
  }
}
