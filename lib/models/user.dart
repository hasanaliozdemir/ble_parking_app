class User{
  final String userId;
  final String name;
  final String phoneNumber;
  final String mail;
  final String password;

  final String userImageUrl;

  final List<String> carsId;
  final List<String> parksId;

  User(this.name, this.phoneNumber, this.mail, this.password, this.userImageUrl, this.carsId, this.parksId, this.userId);


}