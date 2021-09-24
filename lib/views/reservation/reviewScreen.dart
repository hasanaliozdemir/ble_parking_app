import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gesk_app/core/colors.dart';
import 'package:gesk_app/core/components/bottomBar.dart';
import 'package:gesk_app/core/components/button.dart';
import 'package:gesk_app/views/giris/SplashScreen.dart';
import 'package:get/get.dart';

class ReviewScreen extends StatefulWidget {
  
  const ReviewScreen({ Key key }) : super(key: key);

  @override
  _ReviewScreenState createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  TextEditingController _infoController = TextEditingController();

  int point = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: _buildStack(),
          )
        ],
      ),
      bottomNavigationBar: BottomBar(index: 1),
    );
  }

  Stack _buildStack() {
    return Stack(
      clipBehavior: Clip.hardEdge,
      children: [
        _buildLayer1(),
        _buildLayer2(),
        _buildLayer3()
      ],
    );
  }

  _buildLayer1(){
    return Positioned(
      child: SvgPicture.asset("assets/logos/Elips2.svg"),
      top: Get.height/812*(-110),
      left: 15,
    );
  }

  _buildLayer2(){
    return Positioned(
      child: SvgPicture.asset("assets/logos/Color.svg",width: Get.width/375*96,height: Get.height/812*130,),
      top: MediaQuery.of(context).padding.top + 44,
      left: Get.width/375*((375-96)/2),
    );
  }

  _buildLayer3(){
    return Column(
      children: [
        Spacer(
          flex: 57,
        ),
        Expanded(
          flex: 44,
          child: _buildBackButton(),
        ),
        Spacer(
          flex: 229,
        ),
        Expanded(
          flex: 22,
          child: Text(
            "Teşekkürler",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: blue500,
              fontSize: 17,
            fontFamily: "SF Pro Text",
            fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Expanded(
          flex: 88,
          child: Text(
            "Otopark kiralama işleminiz başarı ile sona ermiştir. Sizden almış olduğumuz geri bildirimler daha iyi bir deneyim sunmamız için bizlere yol gösterecektir.",
            textAlign: TextAlign.center,
        style: TextStyle(
            color: black,
            fontSize: 17,
        ),
          ),
        ),
        Spacer(
          flex: 16,
        ),
        Expanded(
          flex: 44,
          child: _buildStars(),
        ),
        Spacer(
          flex: 16,
        ),
        Expanded(
          flex: 120,
          child: _buildInfo(),
        ),
        Spacer(
          flex: 16,
        ),
        Expanded(
          flex: 56,
          child: Button.active(text: "Gönder", onPressed: _sendReview),
        ),
        Spacer(
          flex: 22,
        )
      ],
    );
  }
  
  Widget _buildInfo(){
    return Container(
      width: Get.width/375*343,
      height: Get.height/812*120,
      decoration: BoxDecoration(
        border: Border.all(width: 2,color: gray500),
        borderRadius: BorderRadius.circular(8)
      ),
      child: TextField(
        controller: _infoController,
        maxLines: null,
        decoration: InputDecoration(
          hintText: "Otopark hakkında düşünceleriniz.",
          border: InputBorder.none
        ),
      ),
    );
  }

  Widget _buildStars(){
    return Container(
      width: Get.width/375*245,
      height: Get.height/812*22,
      child: MediaQuery.removePadding(
        context: context,
        removeLeft: true,
        removeRight: true,
        child: ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          itemCount: 5,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context,index){
            return  _buildStar(index);
          },
          ),
      )
    );
  }

  _buildStar(index){
    return IconButton(icon: Icon(CupertinoIcons.star_fill,color: (index<point)?yellow500:gray500,), 
    onPressed: (){
      if (index==0 && point==1) {
        setState(() {
                  point = 0;
                });
      }else{
        setState(() {
                  point = index+1;
                });
      }
    }
    );
  }

  Widget _buildBackButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        child: GestureDetector(
          onTap: () => _backButtonFunc(),
          child: Row(
            children: [
              Icon(CupertinoIcons.left_chevron, color: blue500),
              Text(
                "Geri",
                style: TextStyle(fontSize: 17, color: blue500),
              )
            ],
          ),
        ),
      ),
    );
  }

  _backButtonFunc() {
    Get.back();
  }
  _sendReview(){
    printInfo(info: "BAĞLI DEĞİLİM BEN (YORUM GÖNDERME) !!!!");
    Get.to(()=>SplashScreen(),fullscreenDialog: true);
  }
}