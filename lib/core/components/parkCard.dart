import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gesk_app/core/colors.dart';
import 'package:get/get.dart';

var h = Get.height / 812;
var w = Get.width / 375;

class ParkCard extends StatelessWidget {
  final variants;
  final price;
  final distance;
  final name;
  final location;
  final imageUrl;
  final point;
  ParkCard(
      {Key key,
      @required this.imageUrl,
      @required this.point,
      @required this.name,
      @required this.location,
      @required this.distance,
      @required this.price,
      @required this.variants})
      : super(key: key);

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
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: variants.length,
              itemBuilder: (context, index) {
                return iconBox(variants[index]);
              }),
        ),
        Spacer(),
        Text(
          price,
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
        return Icon(CupertinoIcons.camera_fill);

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
            name,
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
            location,
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
            distance,
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
          point,
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
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          image: DecorationImage(
              image: NetworkImage(imageUrl), fit: BoxFit.cover)),
    );
  }
}
