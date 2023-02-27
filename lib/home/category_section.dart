import 'package:blogui/categories/all.dart';
import 'package:flutter/material.dart';

import '../categories/University.dart';
import '../categories/educational.dart';
import '../categories/exam.dart';
import '../categories/health.dart';
import '../categories/sports.dart';
import '../other/style.dart';

class Category_Section extends StatefulWidget {
  const Category_Section({Key? key}) : super(key: key);

  @override
  State<Category_Section> createState() => _Category_SectionState();
}

class _Category_SectionState extends State<Category_Section> {
  @override
  Widget build(BuildContext context) {
    var size;
    return Scaffold(
      body:Container(
        height:double.infinity,width:double.infinity,
    decoration: const BoxDecoration(
    color: Colors.purple,
    image: DecorationImage(
    image: AssetImage('assets/images/Image2.jpg'),
    alignment: Alignment.bottomCenter,
    fit: BoxFit.cover),
    ),
        child: Padding(
          padding: const EdgeInsets.only(top: 200),
          child: Container(
            padding: EdgeInsets.only(top: 35.0,bottom: 0.0,left: 24.0,right: 24.0),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(34)),
            child:SingleChildScrollView(

              child: Column(
                children: [
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> All_cat(),));
                        },
                        child: LongCourseCard(
                            background: Colors.orange,
                            title: 'All',
                            subtitle: '15 Course',
                            image: 'assets/images/exam-results.png'),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> Educationcat(),));
                        },
                        child: ShortBottomCourseCard(
                            background: Colors.purple,
                            title: 'Educational',
                            subtitle: '12 Course',
                            image: 'assets/images/healthcare.png'),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> Exam_cat(),));
                        },
                        child: ShortTopCourseCard(
                            background: Colors.purple,
                            title: 'Exam',
                            subtitle: '12 Course',
                            image: 'assets/images/healthcare.png'),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> Health_cat(),));
                        },
                        child: ShortBottomCourseCard(
                            background: Colors.green,
                            title: 'Health',
                            subtitle: '110 Course',
                            image: 'assets/images/sports.png'),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> Sports_cat(),));
                        },
                        child: ShortTopCourseCard(
                            background: Colors.green,
                            title: 'Sports',
                            subtitle: '20 Course',
                            image: 'assets/images/graduation-hat.png'),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> Univercity_cat(),));
                        },
                        child: ShortBottomCourseCard(
                            background: Colors.green,
                            title: 'Univercity',
                            subtitle: '110 Course',
                            image: 'assets/images/sports.png'),
                      ),
                    ],
                  ),
                ],
                    ),
                  ),
                ),
            ),
          ),
        );

  }
}

class LongCourseCard extends StatelessWidget {
  final Color background;
  final String title;
  final String subtitle;
  final String image;
  const LongCourseCard(
      {Key? key,
        required this.background,
        required this.title,
        required this.subtitle,
        required this.image})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      width: 155,
      height: 192,
      decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(34),
          border: Border.all(color: Colors.white, width: 10),
          boxShadow: [
            BoxShadow(
                blurRadius: 50,
                color: const Color(0xFF0B0C2A).withOpacity(.09),
                offset: const Offset(10, 10))
          ]),
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        const SizedBox(height: 16),
        Text(title, style: MyStyles.mab),
        Text(subtitle, style: MyStyles.mab),
        Expanded(child: Image.asset(image)),
      ]),
    );
  }
}
class ShortTopCourseCard extends StatelessWidget {
  final Color background;
  final String title;
  final String subtitle;
  final String image;
  const ShortTopCourseCard(
      {Key? key,
        required this.background,
        required this.title,
        required this.subtitle,
        required this.image})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      width: 155,
      height: 163,
      decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(34),
          border: Border.all(color: Colors.white, width: 10),
          boxShadow: [
            BoxShadow(
                blurRadius: 50,
                color: const Color(0xFF0B0C2A).withOpacity(.09),
                offset: const Offset(10, 10))
          ]),
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        const SizedBox(height: 16),
        Text(title, style: MyStyles.mab),
        Text(subtitle, style: MyStyles.mab),
        Expanded(child: Image.asset(image)),
      ]),
    );
  }
}
class ShortBottomCourseCard extends StatelessWidget {
  final Color background;
  final String title;
  final String subtitle;
  final String image;
  const ShortBottomCourseCard(
      {Key? key,
        required this.background,
        required this.title,
        required this.subtitle,
        required this.image})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      width: 155,
      height: 163,
      decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(34),
          border: Border.all(color: Colors.white, width: 10),
          boxShadow: [
            BoxShadow(
                blurRadius: 50,
                color: const Color(0xFF0B0C2A).withOpacity(.09),
                offset: const Offset(10, 10))
          ]),
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        const SizedBox(height: 8),
        Expanded(child: Image.asset(image)),
        Text(title, style: MyStyles.mab),
        Text(subtitle, style: MyStyles.mab),
        const SizedBox(height: 12),
      ]),
    );
  }
}
