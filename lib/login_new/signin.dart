import 'package:blogui/home/main.dart';
import 'package:blogui/login_new/re_textfield.dart';
import 'package:blogui/login_new/reset_password.dart';
import 'package:blogui/login_new/sign_up.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../BottomNavi/BotttomNavigatorBar.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();

  @override
  void initState() {
    _emailTextController.text = 'mmahshookh1@gmail.com';
    _passwordTextController.text = "asdfghjkl";
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                20, MediaQuery.of(context).size.height * 0.35 / 2, 30, 0),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 180,
                ),
                reUsableText("Enter Your Email", Icons.person, false,
                    _emailTextController),
                SizedBox(
                  height: 20,
                ),
                reUsableText("Enter Password", Icons.lock, false,
                    _passwordTextController),
                SizedBox(
                  height: 20,
                ),
                forgetPassword(context),
                fireBaseButton(context, "Sign In", () {
                  FirebaseAuth.instance
                      .signInWithEmailAndPassword(
                          email: _emailTextController.text,
                          password: _passwordTextController.text)
                      .then((value) {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BottomNavBar(0)));
                    CurrentUserEmail = _emailTextController.text;
                  }).onError((error, stackTrace) {
                    print("Error ${error.toString()}");
                  });
                }
                ),
                signUPOption(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row signUPOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Don't have a account?",
          style: TextStyle(color: Colors.white70),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SignUpScreen()));
          },
          child: const Text(
            " Sign Up",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}

Widget forgetPassword(BuildContext context) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 35,
    alignment: Alignment.bottomRight,
    child: TextButton(
      child: const Text(
        "Forgot Password",
        style: TextStyle(color: Colors.white70),
        textAlign: TextAlign.right,
      ),
      onPressed: () => Navigator.push(
          context, MaterialPageRoute(builder: (context) => ResetPassword())),
    ),
  );
}
