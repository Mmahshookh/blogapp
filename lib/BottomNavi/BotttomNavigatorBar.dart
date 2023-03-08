import 'package:blogui/BottomNavi/profile/profile%20new.dart';
import 'package:blogui/BottomNavi/search.dart';
import 'package:blogui/home/HomeScreen.dart';
import 'package:blogui/home/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../home/category_section.dart';
import '../other/constants.dart';
import '../other/demo.dart';

class BottomNavBar extends StatefulWidget {
  int currentIndex =0;
  BottomNavBar(this.currentIndex);


  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}
setSearchParam(String caseNumber) {
  List<String> caseSearchList = <String>[];
  String temp = "";

  List<String> nameSplits = caseNumber.split(" ");
  for (int i = 0; i < nameSplits.length; i++) {
    String name = "";

    for (int k = i; k < nameSplits.length; k++) {
      name = name + nameSplits[k] + " ";
    }
    temp = "";

    for (int j = 0; j < name.length; j++) {
      temp = temp + name[j];
      caseSearchList.add(temp.toUpperCase());
    }
  }
  return caseSearchList;
}
class _BottomNavBarState extends State<BottomNavBar> {

final List _children =[
  HomeScreen(),
  // Category_Section(),
  Search(),
  Profile_new(),
];


  void onTabTapped(int index){
    setState(() {
      widget.currentIndex = index;
      print('================$CurrentUserEmail');
    });
  }
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('users').where('email' ,isEqualTo: CurrentUserEmail).snapshots(),

      builder: (context, snapshot) {
        if(!snapshot.hasData){
          return Text('');
        }

        var data = snapshot.data?.docs;
        CurrentUserName =data?[0]['username'];
        CurrentUserID =data?[0]['id'];
        CurrentUserAbout =data?[0]['about'];
        CurrentUserImage =data?[0]['profile'];
        return Scaffold(
          backgroundColor: Colors.black,
          body: _children[widget.currentIndex],
          bottomNavigationBar: Container(
            height: 55.0,
            margin: EdgeInsets.all(10.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
            child: BottomNavigationBar(
              elevation: 0.0,
              type: BottomNavigationBarType.fixed,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              backgroundColor: kBottomNavBarColor.withOpacity(0.08),
              selectedItemColor: kLightColor,
              unselectedItemColor: kLightColor.withOpacity(0.4),
              onTap: onTabTapped,
              currentIndex: widget.currentIndex,
              items: [
                buildBottomNavigationBarItem(0,"assets/icons/Home.png","Home"),
                // buildBottomNavigationBarItem(1,"assets/icons/Category.png","Category"),
                buildBottomNavigationBarItem(1,"assets/icons/Search.png","Search"),
                buildBottomNavigationBarItem(2,"assets/icons/Account.png","Accounts"),
              ],
            ),
          ),
        ),
        );
      }
    );
  }

  BottomNavigationBarItem buildBottomNavigationBarItem(int index,String icon,String title){
    return BottomNavigationBarItem(
      icon: ImageIcon(AssetImage(icon),
      size: 25.0,
      ),
      label: title.toString(),
    );
  }
}

Widget emptyScreens(String image,String title) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ImageIcon(AssetImage(image),
          size: 118.0,
          color: kLightColor,
        ),
        Text(title, style: TextStyle(
            fontSize: 25.0, color: kLightColor, fontWeight: FontWeight.bold),)
      ],
    ),
  );
}