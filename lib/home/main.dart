import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../BottomNavi/BotttomNavigatorBar.dart';
import '../BottomNavi/profile.dart';
import '../BottomNavi/profile/myblog_profile.dart';
import '../image_pick/add_post.dart';
import '../image_pick/image_uploading.dart';
import '../login_new/sign_up.dart';
import '../login_new/signin.dart';
import 'DetailsScreen.dart';
import 'category_section.dart';
import '../other/constants.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  );
  runApp(MyApp());
}

String  CurrentUserEmail ='';
String  CurrentUserName ='';
String  CurrentUserID ='';
String  CurrentUserAbout ='';
String  CurrentUserImage ='';


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: kHomeBGColor,
        fontFamily: "Mulish",
      ),
      // home:BottomNavBar(0),
      home: SignInScreen(),
      );
  }
}
