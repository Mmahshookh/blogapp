import 'package:blogui/home/DetailsScreen.dart';
import 'package:blogui/home/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../BottomNavi/BotttomNavigatorBar.dart';
import '../BottomNavi/profile/profile new.dart';
import '../categories/University.dart';
import '../categories/all.dart';
import '../categories/educational.dart';
import '../categories/exam.dart';
import '../categories/health.dart';
import '../categories/sports.dart';
import '../image_pick/image_uploading.dart';
import '../other/constants.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen();

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  List<String> blogTypes = [
    "All",
    "Educational",
    "Health",
    "Sports",
    "Exam",
    "University"
  ];

  List catList = [
    {"image": "assets/images1/allIma.png", "title": "All", "articles": "100"},
    {
      "image": "assets/images1/exam-results (3).png",
      "title": "Educational",
      "articles": "100"
    },
    {
      "image": "assets/images1/healthcare (2).png",
      "title": "Health",
      "articles": "100"
    },
    {
      "image": "assets/images1/sports (2).png",
      "title": "Sports",
      "articles": "100"
    },
    {
      "image": "assets/images1/exam-results (3).png",
      "title": "Exam",
      "articles": "100"
    },
    {
      "image": "assets/images1/graduation-hat (2).png",
      "title": "University",
      "articles": "145"
    },
  ];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   onPressed: (){},
      //   backgroundColor: Colors.grey,
      //   child: Icon(
      //     Icons.add
      //   ),
      // ),

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.black,
        leading: InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Profile_new()));
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 12, top: 10),
              child: Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    image: DecorationImage(
                        image: NetworkImage(CurrentUserImage),
                        fit: BoxFit.cover)),
              ),
            )),
        title: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('users')
                .where('email', isEqualTo: CurrentUserEmail)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Text('');
              }

              var data = snapshot.data?.docs;
              CurrentUserName = data?[0]['username'];
              CurrentUserID = data?[0]['id'];
              CurrentUserAbout = data?[0]['about'];
              CurrentUserImage = data?[0]['profile'];

              return Text(
                'hey, ${data?[0]['username']}',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              );
            }),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Image_Upload()));
              },
              icon: Icon(Icons.add))
        ],
      ),
      backgroundColor: Colors.black,

      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 1,
              ),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: "Trending",
                      style: TextStyle(
                        fontSize: 26.0,
                        color: kLightColor,
                      ),
                    ),
                    TextSpan(text: " "),
                    TextSpan(
                      text: "Blog",
                      style: TextStyle(
                          fontSize: 26.0,
                          color: kLightColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 24,
              ),
              SizedBox(
                height: 10.0,
              ),
              GestureDetector(
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => DetailsScreen(),
                  ),
                ),
                child: Stack(
                  children: [
                    Hero(
                      tag: "blogImage",
                      child: Container(
                        height: 220.0,
                        width: size.width,
                        decoration: BoxDecoration(
                          color: kLightColor,
                          borderRadius: BorderRadius.circular(24.0),
                          image: DecorationImage(
                              image: AssetImage("assets/images/Image1.jpg"),
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
                          // padding: EdgeInsets.symmetric(horizontal: 10.0),
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
                                "580",
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
                            Text(
                              "Easy-to-grow Hardy Annuals",
                              style: TextStyle(
                                  fontSize: 20.0,
                                  color: kLightColor,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(Icons.account_circle, size: 20),
                                SizedBox(
                                  width: 12.0,
                                ),
                                Expanded(
                                  child: Text(
                                    "Muhammed Nihal",
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      color: kLightColor.withOpacity(0.8),
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Mulish-SemiBold.ttf",
                                    ),
                                  ),
                                ),
                                Text("10 June 2022"),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 22.0,
              ),
              Text(
                "Categories",
                style: TextStyle(
                    fontSize: 20.0,
                    color: kLightColor,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 22.0,
              ),
              Container(
                height: 162.0,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: catList.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        index == 0
                            ? Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => All_cat(),
                                ))
                            : index == 1
                                ? Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Educationcat(),
                                    ))
                                : index == 2
                                    ? Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Health_cat(),
                                        ))
                                    : index == 3
                                        ? Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  Sports_cat(),
                                            ))
                                        : index == 4
                                            ? Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      Exam_cat(),
                                                ))
                                            : Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      Univercity_cat(),
                                                  // Univercity_cat(),
                                                ));
                      },
                      child: Container(
                        height: 125.0,
                        width: 125.0,
                        margin: EdgeInsets.only(right: 24),
                        decoration: BoxDecoration(
                          color: kCatColor.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 23.0, bottom: 18.0),
                              child: Image.asset(
                                catList[index]["image"],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              catList[index]["title"],
                              style: TextStyle(
                                height: 1,
                                fontSize: 15.0,
                                color: kLightColor,
                                fontFamily: "Mulish-SemiBold.ttf",
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
