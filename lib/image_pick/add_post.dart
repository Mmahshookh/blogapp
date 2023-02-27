// import 'dart:html';
// import 'package:path/path.dart';
// import 'package:flutter/material.dart';
// import 'package:path_provider/path_provider.dart';
//
// class AddPostScreen extends StatefulWidget {
//   const AddPostScreen({Key? key}) : super(key: key);
//
//   @override
//   State<AddPostScreen> createState() => _AddPostScreenState();
// }
//
// class _AddPostScreenState extends State<AddPostScreen> {
//   File? _image;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Upload Blogs"
//         ),
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Center(
//               child: Container(
//                 height: MediaQuery.of(context).size.height*.2,
//                 width: MediaQuery.of(context).size.width*1,
//                 child: _image != null ? ClipRRect(
//                   child: Image.file(_image.absolute),
//                 ):Container(),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
