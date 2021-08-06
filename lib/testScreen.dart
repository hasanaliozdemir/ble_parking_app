import 'package:carousel_slider/carousel_slider.dart';
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
        child: _carosel() )
    );
  }
}
  List markers = [
    1,2,3
  ];

Widget _carosel(){
  return CarouselSlider.builder(
  
  itemCount: markers.length,
  itemBuilder: (a,b,c){

  }, 
  options: CarouselOptions())  ;
}