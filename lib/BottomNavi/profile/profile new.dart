import 'package:blogui/BottomNavi/profile/edit_profile.dart';
import 'package:blogui/home_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../../home/HomeScreen.dart';
import '../../home/main.dart';
import '../../login_new/signin.dart';
import 'myblog_profile.dart';

class Profile_new extends StatefulWidget {
  const Profile_new({Key? key}) : super(key: key);

  @override
  State<Profile_new> createState() => _Profile_newState();
}

class _Profile_newState extends State<Profile_new> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .where('email', isEqualTo: CurrentUserEmail)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          var data = snapshot.data?.docs;
          CurrentUserName = data?[0]['username'];
          CurrentUserID = data?[0]['id'];
          CurrentUserAbout = data?[0]['about'];
          return SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 280,
                  child: Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.center,
                    children: [
                      Container(
                        color: Colors.grey,
                        child:Image.network(
                            "https://www.pixelstalk.net/wp-content/uploads/2016/05/Desktop-fall-backgrounds-images.jpg"),
                      ),
                      Positioned(
                          top: 160,
                          child: CircleAvatar(
                            radius: 144 / 2,
                            backgroundColor: Colors.black,
                            backgroundImage: NetworkImage(
                                "https://cdn.dribbble.com/users/5534/screenshots/14230133/profile_4x.jpg"
                                // data?[0]['profile']
                            ),
                          )),
                    ],
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Text(
                  CurrentUserName,
                  style: TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Row(children: [
                    Text("About",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                  ],),
                ),
                SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.only(left: 25),
                  child: Row(children: [
                    Text(CurrentUserAbout,style: TextStyle(fontSize: 15),),
                  ],),
                ),
                SizedBox(
                  height: 150,
                ),
                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>editprofile(username: CurrentUserName,
                      about: CurrentUserAbout,
                      image: data?[0]['profile'],)));
                  },
                  child: Container(
                    height: 50,
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.black,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Row(
                        children: [
                          Icon(Icons.edit,color: Colors.white54,),
                          SizedBox(
                            width: 20,
                          ),
                          Text("Edit Profile",style: TextStyle(color: Colors.white54),),
                          Spacer(),
                          Icon(Icons.arrow_right,color: Colors.white54,),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>My_blogs()));
                  },
                  child: Container(
                    height: 50,
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.black,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Row(
                        children: [
                          Icon(Icons.my_library_add,color: Colors.white54,),
                          SizedBox(
                            width: 20,
                          ),
                          Text("My Blogs",style: TextStyle(color: Colors.white54),),
                          Spacer(),
                          Icon(Icons.arrow_right,color: Colors.white54,),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {
                    FirebaseAuth.instance.signOut();
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SignInScreen()));
                  },
                  child: Container(
                    height: 50,
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.black,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Row(
                        children: [
                          Icon(Icons.logout,color: Colors.white54,),
                          SizedBox(
                            width: 20,
                          ),
                          Text("LogOut",style: TextStyle(color: Colors.red),),
                          Spacer(),
                          Icon(Icons.arrow_right,color: Colors.white54,),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      ),
    );
  }
}
