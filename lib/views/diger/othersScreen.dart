import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gesk_app/core/colors.dart';
import 'package:gesk_app/core/components/bottomBar.dart';
import 'package:get/get.dart';

class OthersScreen extends StatefulWidget {
  const OthersScreen({Key key}) : super(key: key);

  @override
  _OthersScreenState createState() => _OthersScreenState();
}

class _OthersScreenState extends State<OthersScreen> {
  String desc1 =
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc ultricies, lorem vitae fringilla sagittis, magna mauris dictum ligula, non pharetra lacus turpis ut neque. Vestibulum nulla dolor, tristique vitae lectus et, ultricies dictum velit. Pellentesque euismod congue tortor non consectetur. Curabitur felis ipsum, dictum a congue at, rutrum viverra leo. Donec nec lobortis arcu, at gravida nulla. In ut pharetra lacus. Suspendisse ac hendrerit elit. Pellentesque pharetra tempus elit nec condimentum.Quisque dolor augue, auctor at dui ut, pulvinar ultrices mi. Aenean egestas nisi in laoreet tristique. Proin vitae quam eros. Curabitur sit amet gravida nibh, vel posuere sapien. Nam.";
  String title = "Title";
  final _index = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomBar(
        index: _index,
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: _buildLogo(),
              flex: 356,
            ),
            Spacer(
              flex: 42,
            ),
            Expanded(
              child: _buildHelpButton(),
              flex: 56,
            ),
            Spacer(
              flex: 16,
            ),
            Expanded(
              child: _buildGizlilikButton(context),
              flex: 56,
            ),
            Spacer(
              flex: 16,
            ),
            Expanded(
              child: _buildHizmetButton(context),
              flex: 56,
            ),
            Spacer(
              flex: 87,
            )
          ],
        ),
      ),
    );
  }

  _onPressedGizlilik() {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        backgroundColor: Colors.white,
        context: context,
        builder: (context) {
          return Container(
            height: Get.height / 812 * 732,
            
            child: Column(
              children: [
                Spacer(
                  flex: 8,
                ),
                Expanded(
                  flex: 5,
                  child: Container(
                    width: 40,
                    height: 5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Color(0xffaeaeb2),
                    ),
                  ),
                ),
                Spacer(
                  flex: 16,
                ),
                Expanded(
                  flex: 36,
                  child: Row(
                    children: [
                      Spacer(
                        flex: 56,
                      ),
                      Expanded(
                        flex: 263,
                        child: Text(
                          "Gizlilik Sözleşmesi",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontFamily: "SF Pro Text",
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Spacer(
                        flex: 8,
                      ),
                      Expanded(
                        flex: 36,
                        child: Center(
                          child: IconButton(
                            icon: Icon(
                              CupertinoIcons.multiply_circle_fill,
                              color: gray900,
                              size: 24,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ),
                      Spacer(
                        flex: 8,
                      )
                    ],
                  ),
                ),
                Spacer(
                  flex: 16,
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    color: gray400,
                    height: Get.height / 812 * 1,
                    width: Get.width,
                  ),
                ),
                Expanded(
                  flex: 650,
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: 16, right: 16, left: 16, bottom: 16),
                    child: Container(
                      height: Get.height / 812 * 656,
                      child: ListView(
                        children: [
                          Text(
                            title,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontFamily: "SF Pro Text",
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            desc1,
                            softWrap: true,
                          ),
                          Text(
                            title,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontFamily: "SF Pro Text",
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            desc1,
                            softWrap: true,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Spacer(
                  flex: 8,
                )
              ],
            ),
          );
        });
  }

  _onPressedHizmet() {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        backgroundColor: Colors.white,
        context: context,
        builder: (context) {
          return Container(
            height: Get.height / 812 * 732,
            
            child: Column(
              children: [
                Spacer(
                  flex: 8,
                ),
                Expanded(
                  flex: 5,
                  child: Container(
                    width: 40,
                    height: 5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Color(0xffaeaeb2),
                    ),
                  ),
                ),
                Spacer(
                  flex: 16,
                ),
                Expanded(
                  flex: 36,
                  child: Row(
                    children: [
                      Spacer(
                        flex: 56,
                      ),
                      Expanded(
                        flex: 263,
                        child: Text(
                          "Hizmet Sözleşmesi",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontFamily: "SF Pro Text",
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Spacer(
                        flex: 8,
                      ),
                      Expanded(
                        flex: 36,
                        child: Center(
                          child: IconButton(
                            icon: Icon(
                              CupertinoIcons.multiply_circle_fill,
                              color: gray900,
                              size: 24,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ),
                      Spacer(
                        flex: 8,
                      )
                    ],
                  ),
                ),
                Spacer(
                  flex: 16,
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    color: gray400,
                    height: Get.height / 812 * 1,
                    width: Get.width,
                  ),
                ),
                Expanded(
                  flex: 650,
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: 16, right: 16, left: 16, bottom: 16),
                    child: Container(
                      height: Get.height / 812 * 656,
                      child: ListView(
                        children: [
                          Text(
                            title,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontFamily: "SF Pro Text",
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            desc1,
                            softWrap: true,
                          ),
                          Text(
                            title,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontFamily: "SF Pro Text",
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            desc1,
                            softWrap: true,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Spacer(
                  flex: 8,
                )
              ],
            ),
          );
        });
  }

  _onPressedHelp() {}

  _buildButton({String text, Color textColor, Icon icon, Function onTap}) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        width: Get.width / 375 * 343,
        height: Get.height / 812 * 56,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: gray400)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 48,
              child: Container(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [icon],
                ),
              ),
            ),
            Spacer(flex: 8),
            Expanded(
              flex: 287,
              child: Text(
                text,
                style: TextStyle(
                  color: textColor,
                  fontSize: 17,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildHelpButton() {
    return _buildButton(
        onTap: _onPressedHelp,
        text: "Yardım",
        textColor: blue500,
        icon: Icon(
          CupertinoIcons.phone_fill,
          color: blue500,
        ));
  }

  _buildHizmetButton(BuildContext context) {
    return _buildButton(
        onTap: _onPressedHizmet,
        text: "Hizmet Sözleşmesi",
        textColor: gray900,
        icon: Icon(
          CupertinoIcons.doc_text,
          color: blue500,
        ));
  }

  _buildGizlilikButton(BuildContext context) {
    return _buildButton(
        onTap: _onPressedGizlilik,
        text: "Gizlilik Sözleşmesi",
        textColor: gray900,
        icon: Icon(
          CupertinoIcons.doc_text,
          color: blue500,
        ));
  }

  _buildLogo() {
    return Container(
      child: Stack(
        children: [
          Container(
            alignment: Alignment.center,
            child: SvgPicture.asset("assets/logos/Elips2.svg"),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              width: Get.width / 375 * 124,
              height: Get.height / 812 * 168,
              alignment: Alignment.center,
              child: SvgPicture.asset("assets/logos/Color.svg"),
            ),
          )
        ],
      ),
    );
  }
}
