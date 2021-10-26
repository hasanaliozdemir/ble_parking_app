


import 'package:gesk_app/backend/dataService.dart';



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gesk_app/core/colors.dart';
import 'package:gesk_app/models/park.dart';
import 'package:get/get.dart';


var h = Get.height / 812;
var w = Get.width / 375;

// ignore: must_be_immutable
class ParkCard extends StatefulWidget {
  final Park park;
  ParkCard({Key key, @required this.park});

  @override
  _ParkCardState createState() => _ParkCardState();
}

class _ParkCardState extends State<ParkCard> {
  var _imageByte;
  var _dataService = DataService();

  @override
  void initState() { 
    super.initState();
    _getImage();
  }

  @override
  Widget build(BuildContext context) {
    
    

    return Container(
      height: h * 128,
      width: w * 264,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: white,
        boxShadow: [
          BoxShadow(
            color: Color(0x3f000000),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Flexible(
                flex: 96,
                child: Stack(
                  children: [imageContainer(), pointText(h, w)],
                )),
            Spacer(
              flex: 8,
            ),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: descriptionColumn(),
                    flex: 56,
                  ),
                  Spacer(flex: 16),
                  Flexible(flex: 24, child: bottomRow()),
                ],
              ),
              flex: 128,
            ),
          ],
        ),
      ),
    );
  }

  Row bottomRow() {
    return Row(
      children: [
        Container(
          width: w * 80,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              widget.park.isClosedPark ? iconBox(1) : SizedBox(),
              widget.park.isWithElectricity ? iconBox(3) : SizedBox(),
              widget.park.isWithCam ? iconBox(4) : SizedBox(),
            ],
          ),
        ),
        Spacer(),
        Text(
          widget.park.price.toString() + " ₺",
          style: TextStyle(
            color: Colors.black,
            fontSize: 12,
            fontFamily: "SF Pro Text",
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Padding iconBox(int variant) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: Container(
        width: w * 24,
        height: h * 24,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            color: Color(0xffd1d1d6),
            width: 1,
          ),
          color: Colors.white,
        ),
        child: icon(variant),
      ),
    );
  }

  

  icon(index) {
    switch (index) {
      case 1:
        return Icon(
          CupertinoIcons.square_grid_3x2_fill,
          size: 18,
        );

        break;
      case 2:
        return Icon(CupertinoIcons.square_grid_3x2);

        break;
      case 3:
        return Icon(CupertinoIcons.bolt_fill);

        break;
      case 4:
        return Icon(CupertinoIcons.video_camera_solid);

        break;
      case 5:
        return SvgPicture.asset("assets/icons/closed-park.svg");

        break;

      default:
        return SvgPicture.asset(null);
    }
  }

  Column descriptionColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          flex: 16,
          child: Text(
            widget.park.name,
            style: TextStyle(
              color: blue500,
              fontSize: 12,
              fontFamily: "SF Pro Text",
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Spacer(flex: 4),
        Flexible(
          flex: 16,
          child: Text(
            widget.park.location,
            style: TextStyle(
              color: gray900,
              fontSize: 12,
            ),
          ),
        ),
        Spacer(flex: 4),
        Flexible(
          flex: 16,
          child: Text(
            widget.park.distance,
            
            style: TextStyle(
              color: gray900,
              fontSize: 12,
              fontFamily: "SF Pro Text",
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Align pointText(h, w) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Container(
        child: Center(
            child: Text(
          widget.park.point.toString(),
          style: TextStyle(
            color: Colors.black,
            fontSize: 11,
          ),
        )),
        height: h * 24,
        width: w * 24,
        decoration: BoxDecoration(
          border: Border.all(
            color: Color(0xffe5e5ea),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(4),
          color: white,
        ),
      ),
    );
  }

  Container imageContainer() {

    if (_imageByte!=null) {
      return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          image: DecorationImage(
              image: MemoryImage(_imageByte), fit: BoxFit.cover)),
    );
    } else {
      return Container(
        decoration: BoxDecoration(
          color: gray400
        ),
        child: Center(child: Icon(CupertinoIcons.arrow_2_circlepath)),
      );
    }

    
  }

  _getImage()async{
    _dataService.downloadPhoto(parkId: widget.park.id, photoId: widget.park.imageUrls.first).then((value) {
      setState(() {
              _imageByte = value;
            });
    });
  }
}
