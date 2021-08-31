class Reservation{
  final int reservationId;
  final String date;
  final String start;
  final String end;
  final int parkId;
  final int tpaId;
  final String ownerId;
  String plate; //TODO: ekle
  String visitTime; // "2021.08.30 20:17:00-2021.08.30 22:17:20"
  String visitStatus;
  

  Reservation({this.reservationId, this.date, this.start, this.end, this.parkId, this.tpaId, this.ownerId});


}