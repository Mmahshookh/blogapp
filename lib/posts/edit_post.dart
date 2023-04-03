import 'package:blogui/widget/round_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:snippet_coder_utils/FormHelper.dart';

import '../other/constants.dart';

class Edit_Post extends StatefulWidget {
  const Edit_Post({Key? key, required this.PostCat, required this.PostImage, required this.PostTitle, required this.PostDiscription, required this.postId,
    }) : super(key: key);

  final String PostCat;
  final String PostImage;
  final String PostTitle;
  final String PostDiscription;
  final String postId;



  @override
  State<Edit_Post> createState() => _Edit_PostState();
}
var postcategory;

class _Edit_PostState extends State<Edit_Post> {
  String imageUrl = '';
  int count = 0;
  File? _image;
  final storage = FirebaseStorage.instance;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();


  Future getImage(ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);

    print('uploading...');

    _image = File(image!.path);

    DocumentSnapshot id = await FirebaseFirestore.instance
        .collection('settings')
        .doc("settings")
        .get();
    id.reference.update({"userImage": FieldValue.increment(1)});
    var imageId = id['userImage'];

    // Upload to firebase

    var storageReference =
    await storage.ref().child("Posts/$imageId").putFile(_image!);
    var downloadUrl = await storageReference.ref.getDownloadURL();
    setState(() {
      imageUrl = downloadUrl;
      CircularProgressIndicator();
      print('uploading');
    });
    if (mounted) {
      setState(() {
        _image = File(image.path);

        print('uploaded');
      });
    }
  }

  Future<File> saveFilePermanently(String imagePath) async {
    final directory = await getApplicationDocumentsDirectory();
    final name = basename('asset');
    final image = File("${directory.path}/$name");

    return File(imagePath).copy(image.path);
  }

  List<dynamic> category = [];

  String? categoryId;
  String? categoryData = "";
  @override
  void initState() {
    super.initState();
    
    titleController.text = widget.PostTitle;
    descriptionController.text = widget.PostDiscription;
    categoryId=widget.PostCat;
    imageUrl=widget.PostImage;
postcategory = widget.PostCat;
    category.add({
      "val": 1,
      "label": "Educational",
    });
    category.add({"val": 2, "label": "Exam"});
    category.add(
      {"val": 3, "label": "Health"},
    );
    category.add({"val": 4, "label": "University"});
    category.add({"val": 5, "label": "Sports"});
    category.add({"val": 6, "label": "Learn"});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              }),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    imageUrl != ''
                        ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 300,
                        width: 340,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(imageUrl))),
                      ),
                    )
                        : Container(
                      // height: 300,
                      // width:360,
                      child: Padding(
                        padding: EdgeInsets.only(right: 20, left: 20),
                        child: Image.asset('assets/images/Image2.jpg',
                            height: 200, width: 200),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (buildContext) {
                        return  AlertDialog(
                          backgroundColor: Colors.transparent,
                          icon: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  InkWell(
                                    onTap: (){
                                      getImage(ImageSource.camera);
                                      Navigator.pop(context);
                                    },
                                    child: Image.asset(
                                      "assets/icons/picture.png",
                                      height: 50,
                                      width: 50,
                                    ),
                                  ),
                                  Text("Camera",style: TextStyle(color: Colors.white)),
                                ],
                              ),
                              Column(
                                children: [
                                  InkWell(
                                      onTap: () {
                                        getImage(ImageSource.gallery);
                                        Navigator.pop(context);
                                      },
                                      child: Image.asset(
                                        "assets/icons/picture1.png",
                                        height: 50,
                                        width: 50,
                                      )),
                                  Text("Gallery",style: TextStyle(color: Colors.white)),
                                ],
                              ),
                            ],
                          ),
                        );
                      });
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: kBottomNavBarColor.withOpacity(0.06),
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Text(
                    "UPLOAD PHOTO",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Container(
                width: 300,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(100)),
                child: FormHelper.dropDownWidget(
                    context,
                    postcategory,
                    hintFontSize: 14,
                    categoryId,
                    category, (onChangedVal) {
                  categoryData = onChangedVal;
                  categoryId = onChangedVal;
                  count = int.parse(onChangedVal) - 1;
                  print("Select Category:$onChangedVal");
                  print(
                      "Select Category:${category[int.parse(onChangedVal) - 1]['label']}");
                }, (onValidateVal) {
                      onValidateVal = postcategory;
                  if (onValidateVal == null) {
                    return "Please Select Category";
                  }
                  return null;
                },
                    borderColor: Colors.white,
                    borderWidth: 5,
                    borderFocusColor: Colors.white,
                    borderRadius: 5,
                    optionValue: "val",
                    optionLabel: "label"),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                padding: const EdgeInsets.all(5),
                child: Column(
                  children: [
                    Form(
                        child: Column(
                          children: [
                            TextFormField(
                              maxLines: 2,
                              maxLength: 85,

                              style: TextStyle(color: Colors.white),
                              controller: titleController,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white)
                                ),
                                labelText: "Title",
                                hintText: "Enter post title",
                                hintStyle: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal),
                                labelStyle: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal),
                              ),

                            ),
                            SizedBox(height: 30),
                            TextFormField(
                              minLines: null,
                              style: TextStyle(color: Colors.white),
                              controller: descriptionController,
                              keyboardType: TextInputType.multiline,
                              decoration: InputDecoration(
                                labelText: "Description",
                                hintText: "Enter post description",

                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                hintStyle: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal),
                                labelStyle: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                            SizedBox(height: 30),
                            RoundButton(
                                title: "Update",
                                onPress: () {
                                  Navigator.pop(context);
                                  if (imageUrl != '' &&
                                      titleController.text != "" &&
                                      descriptionController.text != "" &&
                                      categoryData != "") {
                                    FirebaseFirestore.instance
                                        .collection("posts")
                                        .doc(widget.postId).update({
                                      'image': imageUrl,
                                      "title": titleController.text,
                                      "description": descriptionController.text,
                                      "category": category[count]['label'],

                                    }
                                    );
                                    const snackBar = SnackBar(
                                      content: Text('Updated'),
                                    );
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                    Navigator.pop(context);
                                  } else {
                                    if (imageUrl == '') {
                                      const snackBar = SnackBar(
                                        content: Text('Please upload a image'),
                                      );
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar);
                                    } else {
                                      if (titleController.text == "") {
                                        const snackBar = SnackBar(
                                          content: Text('Please enter a title'),
                                        );
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackBar);
                                      } else {
                                        if (descriptionController.text == "") {
                                          const snackBar = SnackBar(
                                            content: Text(
                                                'Please enter the discription'),
                                          );
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(snackBar);
                                        } else {
                                          const snackBar = SnackBar(
                                            content:
                                            Text('please select a category'),
                                          );
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(snackBar);
                                        }
                                      }
                                    }
                                  }
                                })
                          ],
                        )),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget CustomButton({
  required IconData icon,
  required VoidCallback onclick,
}) {
  return Container(
    width: 120,
    child: ElevatedButton(
      onPressed: onclick,
      child: Column(
        children: [
          Icon(
            icon,
            size: 80,
          ),
        ],
      ),
    ),
  );
}
