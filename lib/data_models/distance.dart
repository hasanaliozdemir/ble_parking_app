class Distance{
  final String distance;

  Distance({this.distance});

  factory Distance.fromJson(Map<String,dynamic> json){
    return Distance(
      distance: json['rows']['distance']['text']
    );
  }
}



