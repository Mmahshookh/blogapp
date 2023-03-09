import 'package:blogui/home/main.dart';
import 'package:blogui/posts/detailed_post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';



class My_blogs extends StatefulWidget {
  const My_blogs({Key? key}) : super(key: key);

  @override
  State<My_blogs> createState() => _My_blogsState();
}

class _My_blogsState extends State<My_blogs> {
  @override
  Widget build(BuildContext context) {
    var size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text("My Blog"),
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              }),
        ),
        backgroundColor: Colors.black,
        body: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection("posts").where('postedby',isEqualTo: CurrentUserEmail).snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              var data = snapshot.data!.docs;
              return ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    List likes = data[index]['likes'];
                    return InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>detailedpost( data[index]["title"],  data[index]["description"],data[index]["image"],likes,data[index]['id'],data[index]['postedbyProfile'])));
                      },
                      child: data[index]["image"] == ''
                          ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 250,
                          decoration: BoxDecoration(
                              color: Colors.white70,
                              // border: Border.all(),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                    offset: Offset(0, 0),
                                    spreadRadius: 1,
                                    blurRadius: 5,
                                    color: Colors.grey)
                              ]),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                data[index]["title"],
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                      )
                          : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              // border: Border.all(),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                    offset: Offset(0, 0),
                                    spreadRadius: 1,
                                    blurRadius: 5,
                                    color: Colors.grey)
                              ]),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 200,
                                  width: 350,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10)),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            data[index]["image"]),
                                        fit: BoxFit.fitWidth,
                                      )),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                data[index]["title"],
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  });
            }));
  }
}
