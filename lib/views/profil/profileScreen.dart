import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gesk_app/core/colors.dart';
import 'package:gesk_app/core/components/bottomBar.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List<String> cars = [
    "34 QWY 545",
    "34 QWY 546",
    "34 QWY 547",
  ];

  var w = Get.width / 375;
  var h = Get.height / 812;
  String name = "Hasan Ali Özdemir";
  String phoneNumber = "+90 535 069 01 77";
  String imageUrl =
      "https://media-exp1.licdn.com/dms/image/C4D03AQGYcK6j7HPXOA/profile-displayphoto-shrink_200_200/0/1606888856127?e=1632355200&v=beta&t=-tbOl92SK-ZO87X1OIRg5uroCA4eOLcQ_up8DFsOSyA";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomBar(),
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
        Theme(
          data: ThemeData().copyWith(dividerColor: Colors.transparent),
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
                      height: h*1,
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
                          width: w*48,
                          height: h*48,
                          child: Center(child: SvgPicture.asset("assets/icons/carCircle.svg")),
                        ),
                        title: Text(
                          cars[index],
                          style: TextStyle(),
                        ),
                        trailing: IconButton(
                          onPressed: ()=> _onPressedCar(cars[index]),
                          icon: Icon(CupertinoIcons.chevron_forward,color: blue500,
                          ),
                        ),
                      ),
                    );
                  }),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    width: w*343,
                    decoration: BoxDecoration(
                      color: blue500,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(8),
                        bottomRight: Radius.circular(8)
                      )
                    ),
                    child: ListTile(
                      onTap: ()=> _onPressedAddCar(),
                      title: Text("Araç Ekle",style: TextStyle(color: white),),
                      leading: Icon(CupertinoIcons.add_circled),
                          ),
                    ),
            ],
          ),
        ),
        Theme(
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
          ),
        ),
        Theme(
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
        ),
        ListTile(
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
        ListTile(
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
      ],
    ));
  }

  _onPressedCar(String carName){
    print(carName);
  }

  _onPressedAddCar(){
    print("add car");
  }
}
