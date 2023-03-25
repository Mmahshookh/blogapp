import 'package:blogui/login/sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../BottomNavi/BotttomNavigatorBar.dart';
import '../home/main.dart';

class Sign_upp extends StatefulWidget {
  const Sign_upp({Key? key}) : super(key: key);

  @override
  State<Sign_upp> createState() => _Sign_uppState();
}

class _Sign_uppState extends State<Sign_upp> {
  var size,height,width;
  late String? _name,_email,_phone;

  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _confirmpassword =TextEditingController();


  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();




  bool passwordVisible=true;


  @override
  void initState(){
    super.initState();
    passwordVisible=true;
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/back.jpg"),fit: BoxFit.cover
          )
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                  padding: EdgeInsets.only(left: 35, top: height*0.15),
                  child: Text("Welcome\n Back",
                    style: TextStyle(color: Colors.white, fontSize: 33),
                  )
              ),
              Container(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.1,
                    right: 35,left: 35),
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
                                borderSide: BorderSide(color: Colors.cyan)
                            ),

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
                                borderRadius: BorderRadius.circular(10)
                            )
                        ),
                        validator: (String? value) {
                          if(value.toString().isEmpty)
                          {
                            return "Please enter Email";
                          }
                          if(!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value!))
                          {
                            return "Please enter a valid Email";
                          }
                          return null;
                        },onSaved: (String? email){
                        _email = _email;
                      },
                      ),
                      SizedBox(
                        height: 35,
                      ),
                      TextFormField(
                        controller: _passwordTextController,
                        keyboardType: TextInputType.text,
                        obscureText: passwordVisible,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.cyan)
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          hintStyle: TextStyle(color: Colors.white),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)
                          ),
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
                          if(value.toString().isEmpty)
                          {
                            return "Please enter password";
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Sign In", style: TextStyle(
                              color: Colors.cyanAccent,
                              fontSize: 25, fontWeight: FontWeight.w700),
                          ),
                          CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.transparent,
                            child: IconButton(
                                color: Colors.white,
                                onPressed: () {
                                  if(_formkey.currentState!.validate())
                                  {
                                    return;
                                  }
                                  else
                                  {
                                    print("Unsuccessfull");
                                  }
                                },
                                icon: InkWell(
                                    onTap: () async {


                                      try {
                                        UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                                            email: _emailTextController.text,
                                            password: _passwordTextController.text
                                        );
                                      } on FirebaseAuthException catch (e) {
                                        if (e.code == 'user-not-found') {
                                          print('No user found for that email.');

                                          const snackBar = SnackBar(
                                            content: Text('No user found for that email'),
                                          );

                                          ScaffoldMessenger.of(context).showSnackBar(snackBar);


                                        } else if (e.code == 'wrong-password') {
                                          print('Wrong password provided for that user.');

                                          const snackBar = SnackBar(
                                            content: Text('Wrong password provided for that user'),
                                          );

                                          ScaffoldMessenger.of(context).showSnackBar(snackBar);

                                        }
                                      }





                                      // FirebaseAuth.instance
                                      //     .signInWithEmailAndPassword(
                                      //     email: _emailTextController.text,
                                      //     password: _passwordTextController.text)
                                      //     .then((value) {
                                      //   Navigator.pushReplacement(
                                      //       context,
                                      //       MaterialPageRoute(
                                      //           builder: (context) => BottomNavBar(0)));
                                      //   CurrentUserEmail = _emailTextController.text;
                                      // }).onError((error, stackTrace) {
                                      //   print("Error ${error.toString()}");
                                      // });
                                    },

                                    child: Icon(Icons.arrow_forward))
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                              onPressed: () {
                               Navigator.push(context, MaterialPageRoute(builder: (context)=>Sign_inn()));
                              },
                              child: Text("Sign Up", style: TextStyle(
                                decoration: TextDecoration.underline,
                                fontSize: 18,
                                color: Colors.cyan,
                              ),)
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, "forgot");
                              }, child: Text(
                            "Forgot Password", style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontSize: 18,
                            color: Colors.cyan,
                          ),)
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
