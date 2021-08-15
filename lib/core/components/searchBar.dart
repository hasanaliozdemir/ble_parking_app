import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gesk_app/core/colors.dart';
import 'package:get/get.dart';

class SearchBar extends StatelessWidget {
  
  const SearchBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var focused = false.obs;
    FocusNode searchFocus = FocusNode();
    TextEditingController searchController = TextEditingController();
    String _hintText= "Adres Giriniz";

    var _h = Get.height/812;
    return Obx(()=>
      Container(
      
      
      height:_h* 56,
      decoration: BoxDecoration(
        border: focused.value ?  Border.all(color: blue500) : Border.all(color: Colors.transparent),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
            BoxShadow(
                color: Color(0x33000000),
                blurRadius: 10,
                offset: Offset(0, 4),
            ),
        ],
        color: white,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10, ),
      child: TextFormField(
        controller: searchController,
        focusNode: searchFocus,
        onTap: (){
          focused.value = true;
        },
        onFieldSubmitted: (term){
          searchFocus.unfocus();
          focused.value = false;
          search(searchController.text);
        },
        textInputAction: TextInputAction.search,
        keyboardType: TextInputType.streetAddress,
        cursorColor: blue500,
        decoration: InputDecoration(
          hintText: _hintText,
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          focusColor: blue500,
          icon: IconButton(
            icon: Icon(CupertinoIcons.search,color: gray900,),
            onPressed: (){
              search(searchController.text);
            },
          ),
          suffixIcon: IconButton(
            icon: Icon(CupertinoIcons.multiply,color: gray900,),
            onPressed: (){
              searchController.clear();
            },
          ),
          
        ),
      ),
    )
    );
  }

  void search(String adress){
    print("search  $adress ");
  }
}