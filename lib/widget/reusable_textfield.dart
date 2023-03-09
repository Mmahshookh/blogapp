import 'package:flutter/material.dart';

class ReusableTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool isMultiline;


  const ReusableTextField({
    required this.hintText,
    required this.controller,
    required this.isMultiline,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      height: isMultiline ? 200 : 55,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        controller: controller,
        maxLines: isMultiline ? null : 1,
        keyboardType: isMultiline ? TextInputType.multiline : null,
        decoration: InputDecoration(
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      ),
    );
  }
}




// Row(
//   mainAxisAlignment:
//       MainAxisAlignment
//           .spaceBetween,
//   children: [
//     InkWell(
//       onTap: () {
//         setState(() {
//           postliked = !postliked;
//
//           print('liked $postliked');
//           if (postliked == true) {
//             FirebaseFirestore
//                 .instance
//                 .collection('posts')
//                 .doc(
//                     Postdata?[index]
//                         ['id'])
//                 .update({
//               'likes': FieldValue
//                   .arrayUnion([
//                 CurrentUserID
//               ])
//             });
//
//             setState(() {
//               likeColor =
//                   Colors.red;
//             });
//           } else {
//             FirebaseFirestore
//                 .instance
//                 .collection('posts')
//                 .doc(
//                     Postdata?[index]
//                         ['id'])
//                 .update({
//               'likes': FieldValue
//                   .arrayRemove([
//                 CurrentUserID
//               ])
//             });
//
//             setState(() {
//               likeColor =
//                   Colors.grey;
//             });
//           }
//         });
//       },
//       child: Container(
//         height: 40.0,
//         width: 55.0,
//         padding:
//             EdgeInsets.symmetric(
//                 horizontal: 10.0),
//         decoration: BoxDecoration(
//           color: kBoxColor
//               .withOpacity(0.5),
//           borderRadius:
//               BorderRadius.circular(
//                   50.0),
//         ),
//         child: Row(
//           children: [
//             Icon(
//               Icons.favorite,
//               size: 20,
//               color: likeColor,
//             ),
//             SizedBox(
//               width: 6.0,
//             ),
//             Text(
//               (Postdata?[index]
//                       ['likes'])
//                   .length
//                   .toString(),
//               style: TextStyle(
//                 fontSize: 13.0,
//                 color: kDescBGColor
//                     .withOpacity(
//                         0.75),
//                 fontFamily:
//                     "Mulish-SemiBold.ttf",
//               ),
//             ),
//           ],
//         ),
//       ),
//     ),
//     Column(
//       children: [
//         // Text('data')
//         Center(
//           child: Text(
//               Postdata?[index]
//                   ['title']),
//         )
//
//         // Text(data?[index]['description']),
//       ],
//     ),
//     InkWell(
//       child: Icon(Icons
//           .report_gmailerrorred),
//       onTap: () {
//         showDialog(
//           context: context,
//           builder: (ctx) =>
//               AlertDialog(
//             title: const Text(
//                 "Report Post"),
//             content: const Text(
//                 "Do you want to report Post?"),
//             actions: <Widget>[
//               ElevatedButton(
//                   style: ButtonStyle(
//                       backgroundColor:
//                           MaterialStatePropertyAll(
//                               Colors
//                                   .green)),
//                   onPressed: () {
//                     Navigator.pop(
//                         context);
//                   },
//                   child: Text(
//                       'cancel')),
//               ElevatedButton(
//                 style: ButtonStyle(
//                     backgroundColor:
//                         MaterialStatePropertyAll(
//                             Colors
//                                 .red)),
//                 onPressed: () {
//                   Navigator.pop(
//                       context);
//                   FirebaseFirestore
//                       .instance
//                       .collection(
//                           'posts')
//                       .doc(Postdata?[
//                               index]
//                           ['id'])
//                       .update({
//                     'reported': true
//                   });
//                 },
//                 child: const Text(
//                     "okay"),
//               ),
//             ],
//           ),
//         );
//       },
//     ),
//   ],
// ),

