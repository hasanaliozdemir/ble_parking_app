import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gesk_app/core/colors.dart';
import 'package:gesk_app/core/components/bottomBar.dart';
import 'package:gesk_app/models/car.dart';
import 'package:gesk_app/models/park.dart';
import 'package:gesk_app/views/profil/ayarlarPage.dart';
import 'package:gesk_app/views/profil/car/addCArPage.dart';
import 'package:gesk_app/views/profil/car/carPage.dart';
import 'package:gesk_app/views/profil/park/ParkPage.dart';
import 'package:gesk_app/views/profil/park/addParkPage.dart';
import 'package:get/get.dart';



class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List<Car> cars = [
    Car.withoutID(plaka: "34 QWY 545", renk: "Siyah", model: 2021,size: "Sedan"),
    Car.withoutID(plaka: "34 QWY 546", renk: "Siyah", model: 2021,size: "Sedan"),
    Car.withoutID(plaka: "34 QWY 547", renk: "Siyah", model: 2021,size: "Sedan"),
  ];

  List<Park> parks = [
    Park(
        isClosedPark: true,
        longitude: 27.971991,
        latitude: 40.355499,
        location: "Bandırma",
        isWithElectricity: true,
        status: Status.selected,
        isWithCam: true,
        parkSpace: 6,
        name: "Bandırma Otopark",
        price: 12.5,
        filledParkSpace: 3,
        isWithSecurity: false,
        id: 123,
        point: 3,
        imageUrls: [
          "https://images.unsplash.com/photo-1552519507-da3b142c6e3d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1000&q=80",
          "https://images.pexels.com/photos/112460/pexels-photo-112460.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
        ])
  ];

  final int _index = 2;
  var w = Get.width / 375;
  var h = Get.height / 812;
  String name = "Hasan Ali Özdemir";
  String phoneNumber = "+90 535 069 01 77";
  String imageUrl =
      "https://media-exp1.licdn.com/dms/image/C4D03AQGYcK6j7HPXOA/profile-displayphoto-shrink_200_200/0/1606888856127?e=1632355200&v=beta&t=-tbOl92SK-ZO87X1OIRg5uroCA4eOLcQ_up8DFsOSyA";

  @override
  Widget build(BuildContext context) {
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
        child: Image(
          fit: BoxFit.fill,
          image: NetworkImage(imageUrl),
        ),
      ),
    );
  }

  _buildNameBar() {
    return Container(
      child: Text(
        name,
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
        phoneNumber,
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
            _buildOtoparklarim(),
            _buildGecmisParklarim(),
            _buildAyarlar(),
            _buildCikis(),
          ],
        ));
  }

  ListTile _buildCikis() {
    return ListTile(
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
    );
  }

  ListTile _buildAyarlar() {
    return ListTile(
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
    );
  }

  Theme _buildGecmisParklarim() {
    return Theme(
      data: ThemeData().copyWith(dividerColor: Colors.transparent),
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
      ),
    );
  }

  Theme _buildOtoparklarim() {
    return Theme(
      data: ThemeData().copyWith(dividerColor: Colors.transparent),
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
              itemCount: parks.length,
              itemBuilder: (context, index) {
                return Container(
                  width: w * 343,
                  child: ListTile(
                    leading: Container(
                      width: w * 48,
                      height: w * 48,
                      child: Center(
                          child:
                              SvgPicture.asset("assets/icons/park_icon.svg")),
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
    );
  }

  Theme _buildAraclarim() {
    return Theme(
      data: ThemeData().copyWith(dividerColor: Colors.transparent),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Color(0x19000000),
                blurRadius: 10,
                offset: Offset(0, 4),
            ),
        ],
        ),
        child: ExpansionTile(
          backgroundColor: white,
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
                itemCount: cars.length,
                itemBuilder: (context, index) {
                  return Container(
                    width: w * 343,
                    child: ListTile(
                      leading: Container(
                        width: w * 48,
                        height: w * 48,
                        child: Center(
                            child:
                                SvgPicture.asset("assets/icons/carCircle.svg")),
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
                leading: Icon(CupertinoIcons.add_circled,color: white,),
              ),
            ),
          ],
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
    Get.to(()=> AddCArPage() );
  }

  _onPressedAddPark() {
    Get.to(()=>AddParkPage());
  }

  _onPressedPark(Park park) {
    Get.to(()=>ParkPage(
      park: park
    ));
  }
}
