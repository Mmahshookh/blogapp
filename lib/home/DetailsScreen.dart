import 'package:flutter/material.dart';
import '../other/constants.dart';

class DetailsScreen extends StatefulWidget {
  DetailsScreen();

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

var likeColor = Colors.grey;

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kDescBGColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Hero(
                  tag: "blogImage",
                  child: Image.asset(
                    "assets/images/Image1.jpg",
                    height: 300.0,
                    width: size.width,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 64.0,
                    bottom: 0.0,
                    left: 0.0,
                    right: 24.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.of(context).pop(),
                        child: Container(
                          height: 40.0,
                          width: 40.0,
                          padding: EdgeInsets.all(12.0),
                          decoration: BoxDecoration(
                              color: kButtonBGColor.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(48.0)),
                          child: Icon(Icons.arrow_back,
                              size: 20, color: Colors.grey),
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
                          "How To Be Like Nihal",
                          style: TextStyle(
                              fontSize: 22.0,
                              color: kLightColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            likeColor = Colors.red;
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
                    ],
                  ),
                  Divider(
                    thickness: 1.0,
                    color: kLightColor.withOpacity(0.08),
                    height: 32.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Hero(
                        tag: "BlogUserProfile",
                        child: Icon(Icons.account_circle,
                            size: 20, color: likeColor),
                      ),
                      SizedBox(
                        width: 12.0,
                      ),
                      Expanded(
                        child: Text(
                          "Muhammed Nihal",
                          style: TextStyle(
                            fontSize: 12.0,
                            color: kLightColor.withOpacity(0.8),
                            fontWeight: FontWeight.bold,
                            fontFamily: "Mulish-SemiBold.ttf",
                          ),
                        ),
                      ),
                      Text.rich(
                        TextSpan(
                          children: [
                            WidgetSpan(
                              alignment: PlaceholderAlignment.middle,
                              child: Image.asset(
                                "assets/icons/Follow.png",
                                height: 15.0,
                                width: 15.0,
                              ),
                            ),
                            TextSpan(text: " "),
                            TextSpan(
                              text: "Follow",
                              style: TextStyle(
                                fontSize: 12.0,
                                color: kLightColor,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Mulish-SemiBold.ttf",
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    thickness: 1.0,
                    color: kLightColor.withOpacity(0.08),
                    height: 32.0,
                  ),
                  Text(
                    "Being a good person means more than just doing things for others. You have to accept and love yourself before you can put positive energy into the universe. Philosophers have been debating what is good and what is not for centuries, and many people find that it's more complicated than just being kind. While every person's journey is different, being good has a lot to do with discovering yourself and your role in the world. In order to truly be good, you will have to consider what 'goodness' means to you. Perhaps this means doing good for others, or simply being an honest and kind person. Use some of the following tips to help yourself be a better person",
                    style: TextStyle(fontSize: 15.0, color: kLightColor),
                  ),
                  Container(
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
