import 'package:flutter/material.dart';

import '../model/blogmodel.dart';


class Post extends StatelessWidget {
  final BlogsModel model;
  final bool isPopUpMenuEnabled;
  final Function? edit, delete;
  const Post({
    required this.isPopUpMenuEnabled,
    required this.model,
    this.edit,
    this.delete,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
      },
      child: Material(
        elevation: 4,
        borderRadius: BorderRadius.circular(10),
        child: SizedBox(
          height: 220,
          width: 100,
          child: Column(
            children: [
              //Image.
              Container(
                height: 155,
                width: 330,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  image: DecorationImage(
                    image: NetworkImage(model.image),
                    fit: BoxFit.cover,
                  ),
                ),
                alignment: Alignment.topRight,
                child: isPopUpMenuEnabled
                    ? Padding(
                  padding: EdgeInsets.all(10),
                  child: PopupMenuButton(
                    onSelected: (value) {
                      if (value == 0) {
                        edit!();
                      } else if (value == 1) {
                        delete!();
                      }
                    },
                    child: Icon(
                      Icons.more_vert,
                      color: Colors.white,
                    ),
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        child: Text("Edit"),
                        value: 0,
                      ),
                      PopupMenuItem(
                        child: Text("Delete"),
                        value: 1,
                      ),
                    ],
                  ),
                )
                    : SizedBox(),
              ),

              SizedBox(
                height: 5,
              ),

              Text(
                model.title,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
