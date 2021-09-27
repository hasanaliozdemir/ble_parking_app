import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gesk_app/backend/dataService.dart';
import 'package:gesk_app/core/colors.dart';
import 'package:gesk_app/core/components/bottomBar.dart';
import 'package:gesk_app/core/components/popUp.dart';
import 'package:gesk_app/models/car.dart';
import 'package:gesk_app/models/park.dart';
import 'package:gesk_app/models/reservation.dart';
import 'package:gesk_app/models/user.dart';
import 'package:gesk_app/views/giris/SplashScreen.dart';
import 'package:gesk_app/views/profil/ayarlarPage.dart';
import 'package:gesk_app/views/profil/car/addCArPage.dart';
import 'package:gesk_app/views/profil/car/carPage.dart';
import 'package:gesk_app/views/profil/park/ParkPage.dart';
import 'package:gesk_app/views/profil/park/addParkPage.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  User _currentUser;
  var dataService = DataService();
  List<Car> cars = List<Car>();
  List<Park> parks = List<Park>();

  List<Reservation> ownerList = List<Reservation>();
  List<Reservation> carList = List<Reservation>();

  @override
  void initState() {
    super.initState();
    _getInfo();
  }

  final int _index = 2;
  var w = Get.width / 375;
  var h = Get.height / 812;

  bool _loaded = false;
  @override
  Widget build(BuildContext context) {
    if (_loaded) {
      return _buildScaffold(context);
    } else {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator.adaptive(),
        ),
      );
    }
  }

  Scaffold _buildScaffold(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomBar(
        index: _index,
      ),
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).padding.top,
          ),
          Spacer(
            flex: 56,
          ),
          Expanded(
            flex: 220,
            child: Column(
              children: [
                Spacer(
                  flex: 32,
                ),
                Expanded(
                  child: _buildPhotoFrame(),
                  flex: 96,
                ),
                Spacer(
                  flex: 16,
                ),
                Expanded(
                  child: _buildNameBar(),
                  flex: 22,
                ),
                Spacer(
                  flex: 8,
                ),
                Expanded(
                  child: _buildPhoneNumber(),
                  flex: 22,
                ),
                Spacer(
                  flex: 24,
                )
              ],
            ),
          ),
          Spacer(
            flex: 16,
          ),
          Expanded(
            flex: 337,
            child: _buildOptions(),
          ),
        ],
      ),
    );
  }

  _buildPhotoFrame() {
    return Container(
      width: w * 96,
      height: h * 96,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Color(0x3f000000),
            blurRadius: 10,
            offset: Offset(4, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }

  _buildNameBar() {
    return Container(
      child: Text(
        (_currentUser == null) ? "" : _currentUser.name,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: black,
          fontSize: 22,
          fontFamily: "SF Pro Display",
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  _buildPhoneNumber() {
    return Container(
      child: Text(
        (_currentUser == null) ? "" : _currentUser.phoneNumber,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: gray900,
          fontSize: 13,
        ),
      ),
    );
  }

  _buildOptions() {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: ListView(
          children: [
            _buildAraclarim(),
            _space(),
            _buildOtoparklarim(),
            _space(),
            _buildGecmisParklarim(),
            _space(),
            _buildAyarlar(),
            _space(),
            _buildCikis(),
          ],
        ));
  }

  Widget _space() {
    return SizedBox(
      height: Get.height / 812 * 16,
    );
  }

  Widget _buildCikis() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: white,
          boxShadow: [
            BoxShadow(
              color: Color(0x19000000),
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: ListTile(
          onTap: () {
            showDialog(
                context: context,
                builder: (context) {
                  return PopUp(
                      title: "Çıkış",
                      content: "Hesabınızdan çıkış yapmak istiyor musunuz ?",
                      yesFunc: logOut,
                      noFunc: () {
                        Navigator.pop(context);
                      },
                      single: false,
                      icon: "assets/icons/person2.svg");
                });
          },
          title: Text(
            "Çıkış",
            style: TextStyle(
              color: gray900,
              fontSize: 17,
              fontFamily: "SF Pro Text",
              fontWeight: FontWeight.w600,
            ),
          ),
          leading: Container(
            width: w * 48,
            height: h * 48,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Color(0xfff2f2f7),
            ),
            child: Icon(
              CupertinoIcons.person_crop_circle_badge_xmark,
              color: blue500,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAyarlar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: white,
          boxShadow: [
            BoxShadow(
              color: Color(0x19000000),
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: ListTile(
          onTap: () {
            Get.to(() => AyarlarPage());
          },
          title: Text(
            "Ayarlar",
            style: TextStyle(
              color: blue500,
              fontSize: 17,
              fontFamily: "SF Pro Text",
              fontWeight: FontWeight.w600,
            ),
          ),
          leading: Container(
            width: w * 48,
            height: h * 48,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Color(0xfff2f2f7),
            ),
            child: Icon(
              CupertinoIcons.gear_alt_fill,
              color: blue500,
            ),
          ),
        ),
      ),
    );
  }

  Theme _buildGecmisParklarim() {
    return Theme(
      data: ThemeData().copyWith(dividerColor: Colors.transparent),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: white,
            boxShadow: [
              BoxShadow(
                color: Color(0x19000000),
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: ExpansionTile(
            title: Text(
              "Geçmiş Parklarım",
              style: TextStyle(
                color: blue500,
                fontSize: 17,
                fontFamily: "SF Pro Text",
                fontWeight: FontWeight.w600,
              ),
            ),
            leading: Container(
              width: w * 48,
              height: h * 48,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Color(0xfff2f2f7),
              ),
              child: Icon(
                CupertinoIcons.arrowshape_turn_up_left_circle_fill,
                color: blue500,
              ),
            ),
            trailing: Icon(
              CupertinoIcons.chevron_down,
              color: blue500,
            ),
            children: [
              ListView.separated(
                shrinkWrap: true,
                separatorBuilder: (context, i) {
                  return Container(
                    height: h * 1,
                    width: w * 343,
                    color: gray400,
                  );
                },
                itemCount: (carList != null && ownerList != null)
                    ? (carList.length + ownerList.length)
                    : 0,
                itemBuilder: (context, index) {
                  var _ref = carList + ownerList;
                  return Container(
                    width: w * 343,
                    child: ListTile(
                      leading: Container(
                        width: w * 48,
                        height: h * 48,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Color(0xfff2f2f7),
                        ),
                        child: Icon(
                          CupertinoIcons.creditcard_fill,
                          color: blue500,
                        ),
                      ),
                      title: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "txt",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: (_ref[index].owned == true)
                                  ? blue500
                                  : Colors.red,
                              fontSize: 17,
                              fontFamily: "SF Pro Text",
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            _ref[index].plate,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: black,
                              fontSize: 17,
                              fontFamily: "SF Pro Text",
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        ],
                      ),
                      subtitle: Text(
                          "${_ref[index].start}:00 - ${_ref[index].end}:00"),
                      trailing: Text(
                        "${_ref[index].price}₺",
                        style: TextStyle(
                          color: (_ref[index].owned == true)? blue500 : Colors.red,
                          fontSize: 17,
                          fontFamily: "SF Pro Text",
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Theme _buildOtoparklarim() {
    return Theme(
      data: ThemeData().copyWith(dividerColor: Colors.transparent),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: white,
            boxShadow: [
              BoxShadow(
                color: Color(0x19000000),
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: ExpansionTile(
            title: Text(
              "Otoparklarım",
              style: TextStyle(
                color: blue500,
                fontSize: 17,
                fontFamily: "SF Pro Text",
                fontWeight: FontWeight.w600,
              ),
            ),
            leading: Container(
              width: w * 48,
              height: h * 48,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Color(0xfff2f2f7),
              ),
              child: Icon(
                CupertinoIcons.square_stack_3d_up_fill,
                color: blue500,
              ),
            ),
            trailing: Icon(
              CupertinoIcons.chevron_down,
              color: blue500,
            ),
            children: [
              ListView.separated(
                  shrinkWrap: true,
                  separatorBuilder: (context, i) {
                    return Container(
                      height: h * 1,
                      width: w * 343,
                      color: gray400,
                    );
                  },
                  itemCount: (parks == null) ? 0 : parks.length,
                  itemBuilder: (context, index) {
                    return Container(
                      width: w * 343,
                      child: ListTile(
                        leading: Container(
                          width: w * 48,
                          height: w * 48,
                          child: Center(
                              child: SvgPicture.asset(
                                  "assets/icons/park_icon.svg")),
                        ),
                        title: Text(
                          parks[index].name,
                          style: TextStyle(),
                        ),
                        trailing: IconButton(
                          onPressed: () => _onPressedPark(parks[index]),
                          icon: Icon(
                            CupertinoIcons.chevron_forward,
                            color: blue500,
                          ),
                        ),
                      ),
                    );
                  }),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8),
                width: w * 343,
                decoration: BoxDecoration(
                    color: blue500,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(8),
                        bottomRight: Radius.circular(8))),
                child: ListTile(
                  onTap: () => _onPressedAddPark(),
                  title: Text(
                    "Otopark Ekle",
                    style: TextStyle(color: white),
                  ),
                  leading: Icon(CupertinoIcons.add_circled),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Theme _buildAraclarim() {
    return Theme(
      data: ThemeData().copyWith(dividerColor: Colors.transparent),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: white,
            boxShadow: [
              BoxShadow(
                color: Color(0x19000000),
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: ExpansionTile(
            title: Text(
              "Araçlarım",
              style: TextStyle(
                color: blue500,
                fontSize: 17,
                fontFamily: "SF Pro Text",
                fontWeight: FontWeight.w600,
              ),
            ),
            leading: Container(
              width: w * 48,
              height: h * 48,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Color(0xfff2f2f7),
              ),
              child: Icon(
                CupertinoIcons.car_detailed,
                color: blue500,
              ),
            ),
            trailing: Icon(
              CupertinoIcons.chevron_down,
              color: blue500,
            ),
            children: [
              ListView.separated(
                  shrinkWrap: true,
                  separatorBuilder: (context, i) {
                    return Container(
                      height: h * 1,
                      width: w * 343,
                      color: gray400,
                    );
                  },
                  itemCount: (cars == null) ? 0 : cars.length,
                  itemBuilder: (context, index) {
                    return Container(
                      width: w * 343,
                      child: ListTile(
                        leading: Container(
                          width: w * 48,
                          height: w * 48,
                          child: Center(
                              child: SvgPicture.asset(
                                  "assets/icons/carCircle.svg")),
                        ),
                        title: Text(
                          cars[index].plaka,
                          style: TextStyle(),
                        ),
                        trailing: IconButton(
                          onPressed: () => _onPressedCar(cars[index]),
                          icon: Icon(
                            CupertinoIcons.chevron_forward,
                            color: blue500,
                          ),
                        ),
                      ),
                    );
                  }),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8),
                width: w * 343,
                decoration: BoxDecoration(
                    color: blue500,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(8),
                        bottomRight: Radius.circular(8))),
                child: ListTile(
                  onTap: () => _onPressedAddCar(),
                  title: Text(
                    "Araç Ekle",
                    style: TextStyle(color: white),
                  ),
                  leading: Icon(
                    CupertinoIcons.add_circled,
                    color: white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _onPressedCar(Car car) {
    Get.to(() => CarPAge(
          car: car,
        ));
  }

  _onPressedAddCar() {
    Get.to(() => AddCArPage());
  }

  _onPressedAddPark() {
    Get.to(() => AddParkPage());
  }

  _onPressedPark(Park park) {
    Get.to(() => ParkPage(
          park: park,
        ));
  }

  _getInfo() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    var _userId = _prefs.getInt("userId");
    _currentUser = await dataService.getUser(userId: _userId);

    carList = await dataService.getReservationsDriver(_userId);

    ownerList = await dataService.getReservationsHost(_userId);

    var _map = await dataService.getUserInstance(userId: _userId);
    setState(() {
      cars = _map["cars"];
      parks = _map["parks"];
    });

    setState(() {
      _loaded = true;
    });
  }

  void _showLoading() async {
    Future.delayed(Duration.zero, () {
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return Center(
              child: Container(
                width: Get.width / 375 * 50,
                height: Get.width / 375 * 50,
                decoration: BoxDecoration(
                    color: white, borderRadius: BorderRadius.circular(8)),
                child: CircularProgressIndicator.adaptive(),
              ),
            );
          });
    });
  }

  void logOut() async {
    Navigator.pop(context);
    _showLoading();
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setBool("auth", false);
    Get.to(() => SplashScreen(), fullscreenDialog: true);
  }
}
