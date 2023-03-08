import 'package:blogui/home/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../BottomNavi/BotttomNavigatorBar.dart';
import '../BottomNavi/profile/user_profile.dart';
import '../other/constants.dart';

class detailedpost extends StatefulWidget {
  detailedpost(this.postTitle, this.PostDesctription, this.PostImage, this.likes, this.postid);
  final String postTitle;
  final String PostDesctription;
  final String PostImage;
  final List likes;
  final String postid;


  @override
  State<detailedpost> createState() => _detailedpostState();
}
bool liked = false;

var likeColor = Colors.grey;

class _detailedpostState extends State<detailedpost> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('posts').where('id',isEqualTo: widget.postid).snapshots(),
      builder: (context, snapshot) {
        if(!snapshot.hasData){
          return Text('');
        }
        var data = snapshot.data?.docs;
        List likes = data?[0]['likes'];

        return Scaffold(
          backgroundColor: kDescBGColor,
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Hero(
                          tag: "blogImage",
                          child: Image.network(
                            widget.PostImage,
                            height: 300.0,
                            width: size.width,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 68.0,
                            bottom: 0.0,
                            left: 5.0,
                            right: 24.0,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () => Navigator.of(context).pop(),
                                child: Container(
                                  height: 45.0,
                                  width: 45.0,
                                  padding: EdgeInsets.all(12.0),
                                  decoration: BoxDecoration(
                                      color: kButtonBGColor.withOpacity(0.3),
                                      borderRadius: BorderRadius.circular(48.0)),
                                  child: Icon(Icons.arrow_back,
                                      size: 20, color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 16.0,
                        horizontal: 24.0,
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                width: size.width / 2,
                                child: Text(
                                  widget.postTitle,
                                  style: TextStyle(
                                      fontSize: 22.0,
                                      color: kLightColor,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    liked = !liked;

                                    print('liked $liked');
                                    if(liked == true){
                                      FirebaseFirestore.instance.collection('posts').doc(widget.postid).update({
                                        'likes':FieldValue.arrayUnion([CurrentUserID])
                                      });

                                      setState(() {
                                        likeColor = Colors.red;
                                      });

                                    }
                                    else {
                                      FirebaseFirestore.instance.collection('posts').doc(widget.postid).update({
                                        'likes':FieldValue.arrayRemove([CurrentUserID])
                                      });

                                      setState(() {
                                        likeColor = Colors.grey;
                                      });
                                    }




                                  });
                                },
                                child: Hero(
                                  tag: "likes",
                                  child: Container(
                                    height: 34.0,
                                    width: 68.0,
                                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                                    decoration: BoxDecoration(
                                      color: kBoxColor.withOpacity(0.5),
                                      borderRadius: BorderRadius.circular(50.0),
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.favorite,
                                          size: 20,
                                          color: likeColor,
                                        ),
                                        SizedBox(
                                          width: 6.0,
                                        ),
                                        Text(
                                          likes.length.toString(),
                                          style: TextStyle(
                                            fontSize: 13.0,
                                            color: kLightColor.withOpacity(0.75),
                                            fontFamily: "Mulish-SemiBold.ttf",
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Divider(
                            thickness: 1.0,
                            color: kLightColor.withOpacity(0.08),
                            height: 32.0,
                          ),
                          StreamBuilder(
                            stream: FirebaseFirestore.instance.collection('users').where('email',isEqualTo:data?[0]['postedby']).snapshots(),
                            builder: (context, snapshot) {
                              if(!snapshot.hasData){
                                return Center(
                                  child: CircularProgressIndicator(
                                    color: kHomeBGColor,
                                  ),
                                );
                              }


                              var profiledata = snapshot.data?.docs;
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                 InkWell(
                                   onTap:(){
                                     Navigator.push(context, MaterialPageRoute(builder: (context)=>User_profile(email:data?[0]['postedby'] ,)));
                    },
                                   child: Container(
                                     height: 40,
                                     width: 40,
                                     decoration: BoxDecoration(
                                         borderRadius: BorderRadius.circular(50),
                                         image: DecorationImage(
                                             image: NetworkImage(profiledata?[0]['profile']),
                                             fit: BoxFit.cover)),
                                   ),
                                 ),
                                  SizedBox(
                                    width: 12.0,
                                  ),
                                  Expanded(
                                    child: Text(
                                      data?[0]['postedbyName'],
                                      style: TextStyle(
                                        fontSize: 12.0,
                                        color: kLightColor.withOpacity(0.8),
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "Mulish-SemiBold.ttf",
                                      ),
                                    ),
                                  ),
                                  // Text.rich(
                                  //   TextSpan(
                                  //     children: [
                                  //       WidgetSpan(
                                  //         alignment: PlaceholderAlignment.middle,
                                  //         child: Image.asset(
                                  //           "assets/icons/Follow.png",
                                  //           height: 15.0,
                                  //           width: 15.0,
                                  //         ),
                                  //       ),
                                  //       TextSpan(text: " "),
                                  //       TextSpan(
                                  //         text: "Follow",
                                  //         style: TextStyle(
                                  //           fontSize: 12.0,
                                  //           color: kLightColor,
                                  //           fontWeight: FontWeight.bold,
                                  //           fontFamily: "Mulish-SemiBold.ttf",
                                  //         ),
                                  //       ),
                                  //     ],
                                  //   ),
                                  // ),
                                ],
                              );
                            }
                          ),
                          Divider(
                            thickness: 1.0,
                            color: kLightColor.withOpacity(0.08),
                            height: 32.0,
                          ),
                          SizedBox(
                            height: 220,
                            child: Text(
                              widget.PostDesctription,
                              style: TextStyle(fontSize: 15.0, color: kLightColor),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 18.0,right: 18),
                  child: Container(
                    height: 64.0,
                    width: size.width,
                    margin: EdgeInsets.only(top: 16.0),
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    decoration: BoxDecoration(
                      color: kCommentBGColor,
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Write a comment....",
                                hintStyle: TextStyle(
                                  fontSize: 15.0,
                                  color: kLightColor,
                                  fontFamily: "Mulish-SemiBold.ttf",
                                )),
                          ),
                        ),
                        Container(
                            height: 36.0,
                            width: 34.0,
                            padding: EdgeInsets.all(9.0),
                            decoration: BoxDecoration(
                              color: kLightColor,
                              borderRadius: BorderRadius.circular(32.0),
                            ),
                            child: Icon(
                              Icons.send,
                              size: 20,
                              color: likeColor,
                            )),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }
    );
  }
}
