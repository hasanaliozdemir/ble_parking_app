import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FullScreenWidget extends StatelessWidget {
  Uint8List parkImage;
  FullScreenWidget({Key key, this.parkImage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        (parkImage == null)
            ? Center(
                child: CircularProgressIndicator.adaptive(),
              )
            : Hero(
              tag: "detailParkImage",
              child: Image.memory(
                  parkImage,
                  fit: BoxFit.cover,
                  height: double.infinity,
                  width: double.infinity,
                  alignment: Alignment.center,
                ),
            ),
            Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 32.0,horizontal: 8),
            child: IconButton(
              icon: Icon(Icons.cancel_presentation,size: 32,),
              onPressed: () {
                Get.back();
              },
            ),
          ),
        ),
      ],
    ));
  }
}
