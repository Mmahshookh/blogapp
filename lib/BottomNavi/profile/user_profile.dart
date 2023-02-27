import 'package:blogui/other/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../home/main.dart';
// import '../../posts/detailed_post.dart';
import '../../posts/users_post.dart';

class User_profile extends StatefulWidget {
  const User_profile({Key? key, required this.email}) : super(key: key);
  final String email;

  @override
  State<User_profile> createState() => _User_profileState();
}

bool postliked = false;

var size, height, width;

class _User_profileState extends State<User_profile> {
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        backgroundColor: kHomeBGColor,
        elevation: 0,
      ),
      backgroundColor: kHomeBGColor,
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('users')
              .where('email', isEqualTo: widget.email)
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 25,
                      ),
                      Container(
                        height: 120,
                        width: 120,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: NetworkImage(data?[0]['profile']),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10, left: 20),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Name: $CurrentUserName",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontFamily: "Mulish-SemiBold.ttf",
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 13),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "About",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Mulish-SemiBold.ttf",
                            fontSize: 23,
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          CurrentUserAbout,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                            fontFamily: "Mulish-SemiBold.ttf",
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Divider(
                    color: kLightColor.withOpacity(0.08),
                    height: 32.0,
                    thickness: 1,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 12),
                    child: Column(
                      children: [
                        Text(
                          "Blogs",
                          style: TextStyle(
                            fontFamily: "Mulish-SemiBold.ttf",
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color: kLightColor.withOpacity(0.08),
                    height: 32.0,
                    thickness: 1,
                  ),
                  StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('posts')
                          .where('postedby', isEqualTo: widget.email)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          Center(
                              child: Text(
                            'No post found',
                            style: TextStyle(color: Colors.white),
                          ));
                        }
                        var Postdata = snapshot.data?.docs;
                        if (Postdata == null) {
                          return Text('');
                        }
                        print('post data  ${Postdata?.length}');

                        return Expanded(
                          flex: 0,
                          child: ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              // itemCount: 2,
                              itemCount: Postdata?.length,
                              itemBuilder: (context, index) {
                                List likes = Postdata?[index]['likes'];
                                print(likes);

                                return InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Users_post(
                                                  Postdata?[index]['title'],
                                                  Postdata?[index]
                                                      ['description'],
                                                  Postdata?[index]['image'],
                                                  Postdata?[index]['likes'],
                                                  Postdata?[index]['id'],
                                                )));
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SizedBox(
                                      child: Column(
                                        children: [
                                          Container(
                                            width: width * 0.9,
                                            height: height * 0.3,
                                            // child: Image.asset("assets/images/Image1.jpg",fit: BoxFit.cover,),
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    image: NetworkImage(
                                                        Postdata?[index]
                                                            ['image']),
                                                    fit: BoxFit.cover),
                                                color: Colors.white,
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(20),
                                                    topRight:
                                                        Radius.circular(20))),
                                          ),
                                          Container(
                                            height: height * 0.05,
                                            width: width * 0.9,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.only(
                                                    bottomLeft:
                                                        Radius.circular(20),
                                                    bottomRight:
                                                        Radius.circular(20))),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      postliked = !postliked;

                                                      print('liked $postliked');
                                                      if (postliked == true) {
                                                        FirebaseFirestore
                                                            .instance
                                                            .collection('posts')
                                                            .doc(
                                                                Postdata?[index]
                                                                    ['id'])
                                                            .update({
                                                          'likes': FieldValue
                                                              .arrayUnion([
                                                            CurrentUserID
                                                          ])
                                                        });

                                                        setState(() {
                                                          likeColor =
                                                              Colors.red;
                                                        });
                                                      } else {
                                                        FirebaseFirestore
                                                            .instance
                                                            .collection('posts')
                                                            .doc(
                                                                Postdata?[index]
                                                                    ['id'])
                                                            .update({
                                                          'likes': FieldValue
                                                              .arrayRemove([
                                                            CurrentUserID
                                                          ])
                                                        });

                                                        setState(() {
                                                          likeColor =
                                                              Colors.grey;
                                                        });
                                                      }
                                                    });
                                                  },
                                                  child: Container(
                                                    height: 40.0,
                                                    width: 55.0,
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 10.0),
                                                    decoration: BoxDecoration(
                                                      color: kBoxColor
                                                          .withOpacity(0.5),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50.0),
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
                                                          (Postdata?[index]
                                                                  ['likes'])
                                                              .length
                                                              .toString(),
                                                          style: TextStyle(
                                                            fontSize: 13.0,
                                                            color: kDescBGColor
                                                                .withOpacity(
                                                                    0.75),
                                                            fontFamily:
                                                                "Mulish-SemiBold.ttf",
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Column(
                                                  children: [
                                                    // Text('data')
                                                    Center(
                                                      child: Text(
                                                          Postdata?[index]
                                                              ['title']),
                                                    )

                                                    // Text(data?[index]['description']),
                                                  ],
                                                ),
                                                InkWell(
                                                  child: Icon(Icons
                                                      .report_gmailerrorred),
                                                  onTap: () {
                                                    showDialog(
                                                      context: context,
                                                      builder: (ctx) =>
                                                          AlertDialog(
                                                        title: const Text(
                                                            "Report Post"),
                                                        content: const Text(
                                                            "Do you want to report Post?"),
                                                        actions: <Widget>[
                                                          ElevatedButton(
                                                              style: ButtonStyle(
                                                                  backgroundColor:
                                                                      MaterialStatePropertyAll(
                                                                          Colors
                                                                              .green)),
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child: Text(
                                                                  'cancel')),
                                                          ElevatedButton(
                                                            style: ButtonStyle(
                                                                backgroundColor:
                                                                    MaterialStatePropertyAll(
                                                                        Colors
                                                                            .red)),
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                              FirebaseFirestore
                                                                  .instance
                                                                  .collection(
                                                                      'posts')
                                                                  .doc(Postdata?[
                                                                          index]
                                                                      ['id'])
                                                                  .update({
                                                                'reported': true
                                                              });
                                                            },
                                                            child: const Text(
                                                                "okay"),
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        );
                      }),
                ],
              ),
            );
          }),
    );
  }
}
