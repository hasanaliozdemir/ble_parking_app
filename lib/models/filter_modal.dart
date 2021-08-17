class FilterModel {
  final int minPrice;
  final int maxPrice;
  final bool isClosed;
  final bool isWithCam;
  final bool isWithElectricity;
  final bool isWithSecurity;
  final String size;

  FilterModel({this.minPrice, this.maxPrice, this.isClosed, this.isWithCam,
      this.isWithElectricity, this.isWithSecurity, this.size});
}
