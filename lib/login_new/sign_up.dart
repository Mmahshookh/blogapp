import 'package:blogui/login_new/re_textfield.dart';
import 'package:blogui/login_new/signin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../BottomNavi/BotttomNavigatorBar.dart';


class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _userNameTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Text("Sign Up",style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
      ),
      backgroundColor: Colors.black,
      body: Container(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, MediaQuery.of(context).size.height * 0.4/2, 20, 0),
            child: Column(
              children: <Widget>[
               const SizedBox(
                  height: 20,
                ),
                reUsableText("Enter User Name", Icons.person, false, _userNameTextController),
                const SizedBox(
                  height: 20,
                ),
                reUsableText("Enter Email Id", Icons.email, false, _emailTextController),
                const SizedBox(
                  height: 20,
                ),
                reUsableText("Enter Password", Icons.lock, false, _passwordTextController),
                const SizedBox(
                  height: 20,
                ),
                fireBaseButton(context, "Sign Up", (){
                  FirebaseAuth.instance.createUserWithEmailAndPassword(email: _emailTextController.text,
                      password: _passwordTextController.text).then((value){
                        print("Created New Account");
                        FirebaseFirestore.instance.collection('users').add(
                            {
                              'username':_userNameTextController.text,
                              'email':_emailTextController.text,
                              "password":_passwordTextController.text,
                              'createdTime':DateTime.now(),
                              'about':'about',
                              'profile': "https://cdn.dribbble.com/users/5534/screenshots/14230133/profile_4x.jpg"
                            }).then((value) => value.update({
                          'id':value.id
                        }));
                  Navigator.push(context,MaterialPageRoute(builder: (context) => SignInScreen()));
                  }).onError((error, stackTrace) {
                    print("Error${error.toString()}");

                  });
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
