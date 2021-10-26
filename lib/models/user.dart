import 'dart:convert';

class User{
   int userId;
   String name;
   String phoneNumber;
   String mail;
   String password;

   List userImageUrl;

   List<int> carsId;
   List<int> parksId;

  User({this.name, this.phoneNumber, this.mail, this.password, this.userImageUrl, this.carsId, this.parksId, this.userId});

  factory User.fromJson(Map<String,dynamic> json){
    List _refcars = json["carsId"] as List;
    List _refparks = json["parksId"] as List;
    List<int> _cars = List<int>();
    List<int> _parks= List<int>();;
    if (_refcars.isEmpty) {
      _cars = [];
    }else{
      _refcars.forEach((element) { 
        _cars.add(element);
      });
    }
    if (_refparks.isEmpty) {
      _parks = [];
    }else{
      _refparks.forEach((element) { 
        _parks.add(element);
      });
    }

    idCheck(val){
      if(val is String){
        return int.parse(val);
      }else{
        return val;
      }
    }
    return User(
      userId: idCheck(json["userId"]),
      name: json["name"],
      phoneNumber: json["phoneNumber"],
      mail: json["mail"],
      userImageUrl:jsonDecode(json["userImageUrl"]),
      carsId: _cars,
      parksId: _parks
    );
  }

  factory User.simpleFromJson(Map<String,dynamic> json){
    return User(
      userId: json["userId"],
      name: json["name"],
      password: json["password"],
      phoneNumber: json["phone"],
      mail: json["mail"],
      userImageUrl:jsonDecode(json["userImageUrl"]),
    );
  }

  factory User.forLoginJson(Map<String,dynamic> json){
    List _refcars = json["carsId"] as List;
    List _refparks = json["parksId"] as List;
    List<int> _cars = List<int>();
    List<int> _parks= List<int>();;
    if (_refcars.isEmpty) {
      _cars = [];
    }else{
      _refcars.forEach((element) { 
        _cars.add(element);
      });
    }
    if (_refparks.isEmpty) {
      _parks = [];
    }else{
      _refparks.forEach((element) { 
        _parks.add(element);
      });
    }

    idCheck(val){
      if(val is String){
        return int.parse(val);
      }else{
        return val;
      }
    }

    return User(
      userId: idCheck(json["userId"]),
      name: json["name"],
      phoneNumber: json["phoneNumber"],
      mail: json["mail"],
      carsId: _cars,
      parksId: _parks
    );
  }

}