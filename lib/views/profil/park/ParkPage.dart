import 'package:flutter/material.dart';
import 'package:gesk_app/models/park.dart';

class ParkPage extends StatefulWidget {
  final Park  park;

  const ParkPage({Key key, this.park}) : super(key: key);

  @override
  _ParkPageState createState() => _ParkPageState(park);
}

class _ParkPageState extends State<ParkPage> {
  final Park park;

  _ParkPageState(this.park);
  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}