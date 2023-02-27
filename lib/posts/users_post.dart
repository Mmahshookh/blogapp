import 'package:blogui/BottomNavi/profile.dart';
import 'package:blogui/home/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../BottomNavi/BotttomNavigatorBar.dart';
import '../BottomNavi/profile/user_profile.dart';
import '../other/constants.dart';

class Users_post extends StatefulWidget {
  Users_post(this.postTitle, this.PostDesctription, this.PostImage, this.likes,
      this.postid);
  final String postTitle;
  final String PostDesctription;
  final String PostImage;
  final List likes;
  final String postid;

  @override
  State<Users_post> createState() => _Users_postState();
}

bool liked = false;

var likeColor = Colors.grey;

class _Users_postState extends State<Users_post> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('posts')
            .where('id', isEqualTo: widget.postid)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
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
                              top: 60.0,
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
                                        borderRadius:
                                            BorderRadius.circular(48.0)),
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
                            Divider(
                              thickness: 1.0,
                              color: kLightColor.withOpacity(0.08),
                              height: 32.0,
                            ),
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
                                      if (liked == true) {
                                        FirebaseFirestore.instance
                                            .collection('posts')
                                            .doc(widget.postid)
                                            .update({
                                          'likes': FieldValue.arrayUnion(
                                              [CurrentUserID])
                                        });

                                        setState(() {
                                          likeColor = Colors.red;
                                        });
                                      } else {
                                        FirebaseFirestore.instance
                                            .collection('posts')
                                            .doc(widget.postid)
                                            .update({
                                          'likes': FieldValue.arrayRemove(
                                              [CurrentUserID])
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
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.0),
                                      decoration: BoxDecoration(
                                        color: kBoxColor.withOpacity(0.5),
                                        borderRadius:
                                            BorderRadius.circular(50.0),
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
                                              color:
                                                  kLightColor.withOpacity(0.75),
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
                            SizedBox(
                              height: 220,
                              child: Text(
                                widget.PostDesctription,
                                style: TextStyle(
                                    fontSize: 15.0, color: kLightColor),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }
}
