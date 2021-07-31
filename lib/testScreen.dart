import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'core/colors.dart';
import 'core/funcs/triangleCreator.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _getMarkerWidget("18"),
      ),
    );
  }
}

Widget _getMarkerWidget(String price){
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
    child: Container(
    width: 64,
    height: 70,
    child: Stack(
      children: [ 
        Padding(
          padding: const EdgeInsets.only(top:8.0,right: 8,left: 8,bottom: 1),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children:[
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.00),
                    color: blue500,
                  ),
                  
                    width: 48,
                    height: 48,
                    child: Stack(
                        children:[
                            Positioned.fill(
                                child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                        "$price₺",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 17,
                                            fontFamily: "SF Pro Text",
                                            fontWeight: FontWeight.w600,
                                        ),
                                    ),
                                ),
                            ),
                        ],
                    ),
                ),
                RotatedBox(
                  quarterTurns: 2,
                  child: CustomPaint(
                  painter: TrianglePainter(
                    strokeColor: Colors.blue,
                    strokeWidth: 10,
                    paintingStyle: PaintingStyle.fill,
                  ),
                  child: Container(
                    height: 7,
                    width: 10,
                  ),),
                )
            ],
      ),
        ),
      Align(
        alignment: Alignment.topRight,
        child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: white
              ),
              width: 24,
              height: 24,
              child: Icon(CupertinoIcons.bolt_circle,color: blue500,),
            ),
      ),
      ]
    ),
)
  );
}