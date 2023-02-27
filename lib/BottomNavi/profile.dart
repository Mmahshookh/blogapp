import 'package:blogui/BottomNavi/profile/edit_profile.dart';
import 'package:blogui/BottomNavi/profile/myblog_profile.dart';
import 'package:blogui/home/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../login_new/signin.dart';
import '../other/constants.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kHomeBGColor,
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('users').where('email' ,isEqualTo: CurrentUserEmail).snapshots(),
        builder: (context, snapshot) {
            if(!snapshot.hasData){
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          var data = snapshot.data?.docs;
          CurrentUserName =data?[0]['username'];
          CurrentUserID =data?[0]['id'];
          CurrentUserAbout =data?[0]['about'];
          return SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 80,
                ),
                Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      image: DecorationImage(
                          image:NetworkImage(data?[0]['profile']),
                          fit: BoxFit.cover)),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  CurrentUserName,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),

                Text(
                  CurrentUserAbout,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Row(
                    children: [
                      Text(
                        "Email: $CurrentUserEmail",
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      )
                    ],
                  ),
                ),
                Center(),
                InkWell(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, top: 60),
                    child: Container(
                      height: 40,
                      width: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.black,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => My_blogs()));
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(
                                left: 33,
                              ),
                              child: Text(
                                "My Blog",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                InkWell(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, top: 20),
                    child: Container(
                      height: 40,
                      width: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.black,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => editprofile(username:CurrentUserName ,about:CurrentUserAbout, image: data?[0]['profile'] ,)));
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(
                                left: 53,
                              ),
                              child: Text(
                                "Edit",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                InkWell(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, top: 20),
                    child: Container(
                      height: 40,
                      width: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.black,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                             FirebaseAuth.instance.signOut();
                             Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SignInScreen()));
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(
                                left: 43,
                              ),
                              child: Text(
                                "LogOut",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          ),
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
