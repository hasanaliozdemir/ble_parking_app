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
    return User(
      userId: json["userId"],
      name: json["name"],
      phoneNumber: json["phoneNumber"],
      mail: json["mail"],
      userImageUrl: json["userImageUrl"],
      carsId: json["carsId"],
      parksId: json["parksId"]
    );
  }

}