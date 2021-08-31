class User{
   String userId;
   String name;
   String phoneNumber;
   String mail;
   String password;

   String userImageUrl;

   List<String> carsId;
   List<String> parksId;

  User({this.name, this.phoneNumber, this.mail, this.password, this.userImageUrl, this.carsId, this.parksId, this.userId});

  factory User.fromJson(Map<String,dynamic> json){
    List _refcars = json["carsId"] as List;
    List _refparks = json["parksId"] as List;
    List<String> _cars;
    List<String> _parks;
    if (_refcars.isEmpty) {
      _cars = [];
    }else{
      _refcars.forEach((element) { 
        _cars.add(element.toString());
      });
    }
    if (_refparks.isEmpty) {
      _parks = [];
    }else{
      _refparks.forEach((element) { 
        _parks.add(element.toString());
      });
    }
    return User(
      userId: json["userId"],
      name: json["name"],
      phoneNumber: json["phoneNumber"],
      mail: json["mail"],
      userImageUrl: json["userImageUrl"],
      carsId: _cars,
      parksId: _parks
    );
  }

  factory User.simpleFromJson(Map<String,dynamic> json){
    return User(
      userId: json["userId"].toString(),
      name: json["name"],
      password: json["password"],
      phoneNumber: json["phone"],
      mail: json["mail"],
    );
  }

}