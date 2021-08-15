import 'package:flutter/material.dart';
import 'package:gesk_app/data_models/user_location.dart';
import 'package:provider/provider.dart';

class LiveLocationPage extends StatefulWidget {
  const LiveLocationPage({ Key key }) : super(key: key);

  @override
  _LiveLocationPageState createState() => _LiveLocationPageState();
}

class _LiveLocationPageState extends State<LiveLocationPage> {
  @override
  Widget build(BuildContext context) {
    var _userLocation = Provider.of<UserLocation>(context);

    return Scaffold(
      
    );
  }
}