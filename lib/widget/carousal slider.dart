import 'package:blogui/posts/detailed_post.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../BottomNavi/profile/user_profile.dart';

import '../other/constants.dart';



class CarosalPage extends StatefulWidget {
  const CarosalPage({Key? key}) : super(key: key);

  @override
  State<CarosalPage> createState() => _CarosalPageState();
}

class _CarosalPageState extends State<CarosalPage> {

  List likedPost=[];
  getPost(){
    FirebaseFirestore
    .instance
    .collection('posts')
    .snapshots()
    .listen((event) {
      likedPost.clear();
      event.docs.forEach((element) {
        if(element['likes'].length!=0){
          if(likedPost.length<=5){
            print(element.id);
            likedPost.add(element);
          }


        }
      });

      likedPost.sort((a,b){
        return b['likes'].length.compareTo(a['likes'].length);
      });


      if(mounted){
        setState(() {

        });
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPost();

  }
  
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
        options: CarouselOptions(
          autoPlay: true,
          viewportFraction: 1,
          height: 260,
        ),
        items:List.generate(likedPost.length, (index) {
          final post =likedPost[index];
          DateTime time = likedPost[index]['date'].toDate();
          return  Padding(
            padding: const EdgeInsets.only(right: 5),
            child: GestureDetector(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => detailedpost(likedPost[index]['title'], likedPost[index]['description'], likedPost[index]['image'], likedPost[index]['likes'], likedPost[index].id,likedPost[index]['postedby']),
                ),
              ),
              child: Stack(
                children: [
                  Hero(
                    tag: "blogImage",
                    child: Container(
                      height: 245.0,
                      width: 400,
                      decoration: BoxDecoration(
                        color: kLightColor,
                        borderRadius: BorderRadius.circular(24.0),
                        image: DecorationImage(
                            image: NetworkImage(likedPost[index]['image']),
                            fit: BoxFit.cover),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 24.0,
                    right: 24.0,
                    child: Hero(
                      tag: "likes",
                      child: Container(
                        height: 34.0,
                        width: 68.0,
                        decoration: BoxDecoration(
                          color: kBoxColor.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.favorite,
                              size: 20,
                              color: Colors.red,
                            ),
                            SizedBox(
                              width: 6.0,
                            ),
                            Text(
                              likedPost[index]['likes'].length.toString(),
                              style: TextStyle(

                                fontSize: 13.0,
                                color: Colors.black,
                                fontFamily: "Mulish-SemiBold.ttf",
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0.0,
                    left: 0.0,
                    right: 0.0,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.only(left: 3,right: 5),
                            decoration: BoxDecoration(
                              color: kBoxColor.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Text(
                              likedPost[index]['title'],
                              style: TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Container(
                            padding: EdgeInsets.only(right: 5),
                            decoration: BoxDecoration(
                              color: kBoxColor.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                StreamBuilder<QuerySnapshot>(
                                  stream: FirebaseFirestore.instance.collection("users").where("email",isEqualTo: likedPost[index]['postedby']).snapshots(),
                                  builder: (context, snapshot) {
                                    if(!snapshot.hasData){
                                      return Text('');
                                    }
                                    var data1 = snapshot.data?.docs;
                                    return CircleAvatar(
                                      backgroundImage: NetworkImage(data1?[0]['profile']),
                                      radius: 15,
                                    );
                                  }
                                ),
                                SizedBox(
                                  width: 12.0,
                                ),
                                Expanded(
                                  child: Text(
                                    likedPost[index]['postedby'],
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      color: Colors.black.withOpacity(0.9),
                                      fontWeight: FontWeight.w300,
                                      fontFamily: "Mulish-SemiBold.ttf",
                                    ),
                                  ),
                                ),

                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(DateFormat('hh:mm:a').format(time),style: TextStyle(
                                      color: Colors.black
                                    ),),
                                    Text(DateFormat.yMMMMd('en_US').format(time),style: TextStyle(
                                      color: Colors.black
                                    ),)

                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );

        })

        // [
        //   Padding(
        //     padding: const EdgeInsets.only(right: 5),
        //     child: GestureDetector(
        //       onTap: () => Navigator.of(context).push(
        //         MaterialPageRoute(
        //           builder: (context) => DetailsScreen(),
        //         ),
        //       ),
        //       child: Stack(
        //         children: [
        //           Hero(
        //             tag: "blogImage",
        //             child: Container(
        //               height: 245.0,
        //               width: 400,
        //               decoration: BoxDecoration(
        //                 color: kLightColor,
        //                 borderRadius: BorderRadius.circular(24.0),
        //                 image: DecorationImage(
        //                     image: AssetImage("assets/images/Image1.jpg"),
        //                     fit: BoxFit.cover),
        //               ),
        //             ),
        //           ),
        //           Positioned(
        //             top: 24.0,
        //             right: 24.0,
        //             child: Hero(
        //               tag: "likes",
        //               child: Container(
        //                 height: 34.0,
        //                 width: 68.0,
        //                 // padding: EdgeInsets.symmetric(horizontal: 10.0),
        //                 decoration: BoxDecoration(
        //                   color: kBoxColor.withOpacity(0.5),
        //                   borderRadius: BorderRadius.circular(50.0),
        //                 ),
        //                 child: Row(
        //                   children: [
        //                     Icon(
        //                       Icons.favorite,
        //                       size: 20,
        //                       color: likeColor,
        //                     ),
        //                     SizedBox(
        //                       width: 6.0,
        //                     ),
        //                     Text(
        //                       "580",
        //                       style: TextStyle(
        //                         fontSize: 13.0,
        //                         color: kLightColor.withOpacity(0.75),
        //                         fontFamily: "Mulish-SemiBold.ttf",
        //                       ),
        //                     ),
        //                   ],
        //                 ),
        //               ),
        //             ),
        //           ),
        //           Positioned(
        //             bottom: 0.0,
        //             left: 0.0,
        //             right: 0.0,
        //             child: Padding(
        //               padding: const EdgeInsets.symmetric(
        //                   vertical: 16.0, horizontal: 24.0),
        //               child: Column(
        //                 crossAxisAlignment: CrossAxisAlignment.start,
        //                 children: [
        //                   Text(
        //                     "Easy-to-grow Hardy Annuals",
        //                     style: TextStyle(
        //                         fontSize: 20.0,
        //                         color: kLightColor,
        //                         fontWeight: FontWeight.bold),
        //                   ),
        //                   SizedBox(
        //                     height: 10.0,
        //                   ),
        //                   Row(
        //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                     children: [
        //                       Icon(Icons.account_circle, size: 20),
        //                       SizedBox(
        //                         width: 12.0,
        //                       ),
        //                       Expanded(
        //                         child: Text(
        //                           "Muhammed Nihal",
        //                           style: TextStyle(
        //                             fontSize: 15.0,
        //                             color: kLightColor.withOpacity(0.8),
        //                             fontWeight: FontWeight.bold,
        //                             fontFamily: "Mulish-SemiBold.ttf",
        //                           ),
        //                         ),
        //                       ),
        //                       Text("10 June 2022"),
        //                     ],
        //                   ),
        //                 ],
        //               ),
        //             ),
        //           )
        //         ],
        //       ),
        //     ),
        //   ),
        // ]

        );
  }
}
