import 'package:blogui/login/sign_upp.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../BottomNavi/BotttomNavigatorBar.dart';
import '../home/main.dart';
import 'forgotpassword.dart';

class Sign_in extends StatefulWidget {
  const Sign_in({Key? key}) : super(key: key);

  @override
  State<Sign_in> createState() => _Sign_inState();
}

class _Sign_inState extends State<Sign_in> {
  var size, height, width;
  late String? _name, _email, _phone;

  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _confirmpassword = TextEditingController();

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  bool passwordVisible = true;

  @override
  void initState() {
    super.initState();
    passwordVisible = true;
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/back.jpg"), fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: height * 0.10),
                child: Text(
                  "Welcome,",
                  style: TextStyle(color: Colors.white, fontSize: 28),
                ),
              ),
              SizedBox(
                height: height * 0.01,
              ),
              Container(
                child: Text(
                  "Glad to see you,",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.20,
                    right: 35,
                    left: 35),
                child: Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _emailTextController,
                        keyboardType: TextInputType.text,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.cyan)),
                            fillColor: Colors.transparent,
                            filled: true,
                            labelText: 'Email',
                            labelStyle: TextStyle(color: Colors.white),
                            hintText: "Enter Your Email",
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            hintStyle: TextStyle(color: Colors.white),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                        validator: (String? value) {
                          if (value.toString().isEmpty) {
                            return "Please enter Email";
                          }
                          if (!RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value!)) {
                            return "Please enter a valid Email";
                          }
                          return null;
                        },
                        onSaved: (String? email) {
                          _email = _email;
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        controller: _passwordTextController,
                        keyboardType: TextInputType.text,
                        obscureText: passwordVisible,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.cyan)),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          hintStyle: TextStyle(color: Colors.white),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          fillColor: Colors.transparent,
                          filled: true,
                          labelText: 'Password',
                          labelStyle: TextStyle(color: Colors.white),
                          hintText: "Enter Your Password",
                          suffixIcon: IconButton(
                            color: Colors.white,
                            icon: Icon(passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off),
                            onPressed: () {
                              setState(
                                () {
                                  passwordVisible = !passwordVisible;
                                },
                              );
                            },
                          ),
                          alignLabelWithHint: false,
                        ),
                        textInputAction: TextInputAction.done,
                        validator: (String? value) {
                          if (value.toString().isEmpty) {
                            return "Please enter password";
                          }
                          return null;
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 180, top: 10),
                        child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Forgott()));
                            },
                            child: Text("forgotpassword",
                                style: TextStyle(color: Colors.white))),
                      ),
                      SizedBox(
                        height: height * 0.03,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Sign In",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.w700),
                          ),
                          CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.transparent,
                            child: IconButton(
                                color: Colors.white,
                                onPressed: () {
                                  if (_formkey.currentState!.validate()) {
                                    return;
                                  } else {
                                    print("Unsuccessfull");
                                  }
                                },
                                icon: InkWell(
                                    onTap: () async {
                                      try {
                                        UserCredential userCredential =
                                            await FirebaseAuth.instance
                                                .signInWithEmailAndPassword(
                                                    email: _emailTextController
                                                        .text,
                                                    password:
                                                        _passwordTextController
                                                            .text);
                                      } on FirebaseAuthException catch (e) {
                                        if (e.code == 'user-not-found') {
                                          print(
                                              'No user found for that email.');

                                          const snackBar = SnackBar(
                                            content: Text(
                                                'No user found for that email'),
                                          );

                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(snackBar);
                                        } else if (e.code == 'wrong-password') {
                                          print(
                                              'Wrong password provided for that user.');

                                          const snackBar = SnackBar(
                                            content: Text(
                                                'Wrong password provided for that user'),
                                          );

                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(snackBar);
                                        }
                                      }
                                    },
                                    child: Icon(Icons.arrow_forward))),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 42),
                            child: Text(
                              "Don't have an account ?",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w100),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 5),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Sign_up()));
                              },
                              child: Text(
                                "Sign Up",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w900),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
