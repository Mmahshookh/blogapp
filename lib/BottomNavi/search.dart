import 'package:blogui/BottomNavi/profile/user_profile.dart';
import 'package:blogui/other/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController _searchControll = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[700],
      appBar: AppBar(
        title: Text("Search User"),
        backgroundColor: kHomeBGColor,
        elevation: 0.0,
      ),
      body: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 5.0,
                ),
                TextField(
                  controller: _searchControll,
                  onChanged: (value) => setState(() {}),
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[300],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide.none,
                      ),
                      prefixIcon: Icon(Icons.search),
                      prefixIconColor: Colors.purple.shade50),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                      stream: _searchControll.text == ''
                          ? FirebaseFirestore.instance
                              .collection('users')
                              .snapshots()
                          : FirebaseFirestore.instance
                              .collection('users')
                              .where('search',
                                  arrayContains:
                                      _searchControll.text.toUpperCase())
                              .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return CircularProgressIndicator(
                            color: kHomeBGColor,
                          );
                        }
                        var data = snapshot.data?.docs;
                        return ListView.builder(
                          itemCount: data?.length,
                          itemBuilder: (context, index) => InkWell(
                           onTap:    (){
                             Navigator.push(context, MaterialPageRoute(builder: (context) => User_profile(email:data?[index]['email'],)));

                           },
                            child: ListTile(
                              contentPadding: EdgeInsets.all(8.0),
                              title: Text(
                                data?[index]['username'],
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                data?[index]['email'],
                                style: TextStyle(color: Colors.white60),
                              ),
                              trailing: Icon(
                                CupertinoIcons.right_chevron,
                                color: Colors.amber,
                              ),
                              leading: Container(
                                height: 60,
                                width: 60,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        image:
                                            NetworkImage(data?[index]['profile']),
                                        fit: BoxFit.cover)),
                              ),
                            ),
                          ),
                        );
                      }),
                )
              ])),
    );
  }
}

class MovieModel {
  String? user_name;
  int? movie_releae_year;
  String? movie_poster_url;
  double? likes;

  MovieModel(this.user_name, this.movie_releae_year, this.likes,
      this.movie_poster_url) {}
}
