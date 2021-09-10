import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gesk_app/bloc/app_bloc.dart';
import 'package:gesk_app/core/colors.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class SearchBar extends StatefulWidget {
  
  const SearchBar({Key key}) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  TextEditingController _nameController;

  @override
  void initState() { 
    final applicationBloc = Provider.of<AppBloc>(context,listen: false);

    super.initState();
    _nameController = TextEditingController();
  }

  @override
  void dispose() { 
    final applicationBloc = Provider.of<AppBloc>(context,listen: false);
    applicationBloc.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var applicationBloc = Provider.of<AppBloc>(context);

    var focused = false.obs;
    
    
    String _hintText= "Adres Giriniz";

    var _h = Get.height/812;
    return Obx(()=>
      Column(
        children: [
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
        controller: _nameController,
        onChanged: (val){
          
          applicationBloc.searchPlaces(val);
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
              applicationBloc.searchPlaces(_nameController.text);
            },
          ),
          suffixIcon: IconButton(
            icon: Icon(CupertinoIcons.multiply,color: gray900,),
            onPressed: (){
              _nameController.clear();
              applicationBloc.clearSearch();
            },
          ),
        ),
      ),
    ),
    (applicationBloc.searchResults != null && applicationBloc.searchResults.length != 0)? Container(
      height:( 3*40).toDouble(),
      decoration: BoxDecoration(
        color: white
      ),
      child: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: ListView.builder(
          itemCount: applicationBloc.searchResults.length ,
          itemBuilder: (context,index){
            return ListTile(
              leading: SvgPicture.asset("assets/icons/adressPin.svg"),
              title: Text(applicationBloc.searchResults[index].description),
              onTap: (){
                applicationBloc.setSelectedLocation(
                  applicationBloc.searchResults[index].placeId);
                
              },
            );
          },
        ),
      ),
    ) : SizedBox()
        ],
      )
    );
  }

  
}