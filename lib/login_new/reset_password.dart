import 'package:blogui/login_new/re_textfield.dart';
import 'package:blogui/login_new/sign_up.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../BottomNavi/BotttomNavigatorBar.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {

  TextEditingController _emailTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Text("Reset Password",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, MediaQuery
                .of(context)
                .size
                .height * 0.30 / 2, 30, 0
            ),
            child: Column(
              children: <Widget>[
                logoWidget("assets/images/blogger.png"),
                SizedBox(
                  height: 30,
                ),
                reUsableText("Enter Your Email", Icons.person, false,
                    _emailTextController),
                SizedBox(
                  height: 20,
                ),
                fireBaseButton(context, "Reset Password", () {
                  FirebaseAuth.instance.sendPasswordResetEmail(
                      email: _emailTextController.text).then((value) => Navigator.of(context).pop());
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}