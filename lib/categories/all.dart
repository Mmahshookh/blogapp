import 'package:blogui/posts/detailed_post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../other/constants.dart';

class All_cat extends StatefulWidget {
  const All_cat({Key? key}) : super(key: key);

  @override
  State<All_cat> createState() => _All_catState();
}

class _All_catState extends State<All_cat> {
  @override
  Widget build(BuildContext context) {
    var size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey.shade900,
          title: Text("All"),
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              }),
        ),
        body: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection("posts").snapshots(),
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
                      onLongPress: () {
                        showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            title: const Text("Report Post"),
                            content: const Text("Do you want to report Post?"),
                            actions: <Widget>[
                              ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStatePropertyAll(Colors.green)
                                  ),
                                  onPressed: (){
                                    Navigator.pop(context);
                                  }, child: Text('cancel')),

                              ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStatePropertyAll(Colors.red)
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                 FirebaseFirestore.instance.collection('posts').doc(data[index]['id']).update({
                                   'reported':true
                                 });
                                },
                                child: const Text("okay"),
                              ),
                            ],
                          ),
                        );
                      },
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => detailedpost(
                                    data[index]["title"],
                                    data[index]["description"],
                                    data[index]["image"],
                                    data[index]['likes'],
                                    data[index]['id'])));
                      },
                      child: data[index]["image"] == ''
                          ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(

                                height: 250,
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
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(likes.length.toString()),
                                          Text(
                                            data[index]["title"],
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          InkWell(
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
                                                                  .doc(data?[
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
                                              child: Icon(Icons.report_gmailerrorred)),
                                        ],
                                      ),
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
