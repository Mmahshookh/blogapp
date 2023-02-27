import 'package:flutter/material.dart';

class BlogDetailsScreen extends StatefulWidget {
  const BlogDetailsScreen({Key? key}) : super(key: key);

  @override
  State<BlogDetailsScreen> createState() => _BlogDetailsScreenState();
}

class _BlogDetailsScreenState extends State<BlogDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: true,
            title: Text('Blog'),
            leading: IconButton(icon:Icon(Icons.arrow_back),
              onPressed:() => Navigator.pop(context, false),
            )
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Text("Blog Titiles",style: TextStyle(fontSize:22,fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 10,),
              Container(
                height: 190,
                width: 430,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(image: AssetImage("assets/images/Image3.jpg",),
                      fit: BoxFit.cover),
                ),
              ),
              SizedBox(height: 10,),
              Text("Description",style: TextStyle(fontSize:22,fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
